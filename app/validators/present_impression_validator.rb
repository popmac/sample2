class PresentImpressionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    impression_name = ['unuseful', 'difficult', 'not_enough']
    impression_values = impression_name.map { |name| record.__send__("impression_#{name}") }
    unless impression_values.include?(true)
      record.errors[attribute] << (options[:message])
    end
  end
end
