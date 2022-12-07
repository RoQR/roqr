namespace :db do
  desc "Outputs any invalid data records"
  task invalid_records: :environment do
    Rails.application.eager_load!
    puts "\n** Testing record validating in #{Rails.env.capitalize} environment**\n"
    ApplicationRecord.send(:subclasses).each do |model|
      check_valid_records(model)
    end
  end

  def check_valid_records(model)
    if model.abstract_class?
      model.subclasses.each { |m| check_valid_records(m) }
    else
      puts "#{model} records (#{model.count})"
      return if model.count.zero?

      invalid = model.all.reject(&:valid?)
      puts "  all valid" and return if invalid.size.zero?

      puts "  Some valid (#{model.count - invalid.size}), some invalid (#{invalid.size})"

      invalid.each do |record|
        puts "  #{record.id}\tinvalid\t(#{record.errors.full_messages.to_sentence})"
      end
    end
  end
end
