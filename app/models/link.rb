class Link < ApplicationRecord
  validates :name, presence: true
  belongs_to :organization
  belongs_to :contact_link, dependent: :destroy, optional: true
  belongs_to :email_link, dependent: :destroy, optional: true
  belongs_to :sms_link, dependent: :destroy, optional: true
  belongs_to :telephone_link, dependent: :destroy, optional: true
  belongs_to :url_link, dependent: :destroy, optional: true
  belongs_to :wifi_link, dependent: :destroy, optional: true
  accepts_nested_attributes_for :contact_link, :email_link, :sms_link, :telephone_link, :url_link, :wifi_link
  before_save :cleanup_password
  has_many :scans, dependent: :destroy
  has_secure_password validations: false
  validates_length_of :password,
                      maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
  validate :no_password_on_static_link

  has_paper_trail
  delegate :summary, :barcode_data, to: :link_data

  def public?
    password_digest.nil?
  end

  def cleanup_password
    self.password_digest = nil unless dynamic
  end

  def no_password_on_static_link
    errors.add(:password, "can't exist for static links") unless dynamic || password.nil?
  end

  def report_scan_to_stripe
    organization.payment_processor.subscription.create_usage_record(quantity: 1)
  end

  # HERE BE MULTIBLE TABLE INHERITANCE
  # https://danchak99.wordpress.com/enterprise-rails/chapter-10-multiple-table-inheritance/

  def link_data
    # for a given class, returns the appropriate symbol
    # to pass to the ActiveRecord method reflect_on_association
    def reflection_symbol(klass)
      klass.to_s.split('::').last.underscore.to_sym
    end

    # for all subclasses of the given base class, returns a
    # list of defined associations within the current class
    def association_methods(mti_base_class)
      mti_base_class.subclasses.collect do |p|
        assoc = self.class.reflect_on_association(reflection_symbol(p))
        assoc ? assoc.name : nil
      end.compact
    end

    # invoke each association method and return the first
    # that is not null
    association_methods(LinkData).collect do |a|
      send a
    end.inject do |a, b|
      a || b
    end
  end

  def link_data=(p)
    def reflection_symbol(klass)
      klass.to_s.split('::').last.underscore.to_sym
    end

    def reflection_assignment_method(klass)
      Link.reflect_on_association(reflection_symbol(klass)).name.to_s + '='
    end

    send reflection_assignment_method(p.class), p
  end
end
