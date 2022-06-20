class Link < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  belongs_to :contact_link, dependent: :destroy, optional: true
  belongs_to :email_link, dependent: :destroy, optional: true
  belongs_to :sms_link, dependent: :destroy, optional: true
  belongs_to :telephone_link, dependent: :destroy, optional: true
  belongs_to :url_link, dependent: :destroy, optional: true
  belongs_to :wifi_link, dependent: :destroy, optional: true
  accepts_nested_attributes_for :contact_link, :email_link, :sms_link, :telephone_link, :url_link, :wifi_link
  has_many :events, dependent: :destroy
  has_paper_trail
  delegate :summary, :barcode_data, to: :link_data

  # HERE BE MULTIBLE TABLE INHERITANCE
  # https://danchak99.wordpress.com/enterprise-rails/chapter-10-multiple-table-inheritance/

  def link_data
    # for a given class, returns the appropriate symbol
    # to pass to the ActiveRecord method reflect_on_association
    def reflection_symbol(klass)
      klass.to_s.split("::").last.underscore.to_sym
    end

    # for all subclasses of the given base class, returns a
    # list of defined associations within the current class
    def association_methods(mti_base_class)
      mti_base_class.subclasses.collect{|p|
        assoc = self.class.reflect_on_association(reflection_symbol(p))
        assoc ? assoc.name : nil
      }.compact
    end

    # invoke each association method and return the first
    # that is not null
    association_methods(LinkData).collect{|a|
      self.send a
    }.inject do |a, b| 
      a || b
    end 
  end

  def link_data=(p)
    def reflection_symbol(klass)
      klass.to_s.split("::").last.underscore.to_sym
    end

    def reflection_assignment_method(klass)
      Link.reflect_on_association(reflection_symbol(klass)).name.to_s + "="
    end

    self.send reflection_assignment_method(p.class), p
  end

end

