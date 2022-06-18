# frozen_string_literal: true

module ValidationHelper

	def validators_for(record:, attr:, type: nil, options: [])
		fail TypeError, "`options` must be an Arrya, you pass a #{options.class}" unless options.is_a? Array
		klass = ["ActiveRecord::Validations::", type.capitalize, "Validator"].join.constantize if type.present?
		result = record.class.validators
		result = result.select { _1.attributes.include? attr }
		result = result.select { _1.is_a? klass } if type.present?
		result = result.select { _1.options.keys & options }
		result
	end

	def validated_value(record:, attr:, type: nil, options: [])
		fail TypeError, "`options` must be an Arrya, you pass a #{options.class}" unless options.is_a? Array
		validators_for(record: record, attr: attr, type: type, options: options).map { first_value(_1, options) }.compact.first
	end

	def first_value(validator, options)
		options.map { |key| validator.options&.fetch(key, nil) }.compact.first
	end

	def validated_maxlengh(record, attr)
		validated_value(record: record, attr: attr, type: :length, options: [:maximum])
	end

	def validated_minlengh(record, attr)
		validated_value(record: record, attr: attr, type: :length, options: [:minimum])
	end

	def validated_presence(record, attr)
		# validated_value(record: record, attr: attr, type: :presence, options: [:presece]) ?
		validators_for(record: record, attr: attr, type: :presence).any?
	end

	def validated_numeric_max(record, attr)
		validated_value(record: record, attr: attr, type: :numericality, options: [:less_than, :less_than_or_equal_to])
	end

	def validated_numeric_min(record, attr)
		validated_value(record: record, attr: attr, type: :numericality, options: [:greater_than, :greater_than_or_equal_to])
	end

	def resolved_input_attributes(record, attr)
		{
			inputmode: input_mode(record, attr),
			max:       validated_numeric_max(record, attr),
			maxlengh:  validated_maxlengh(record, attr),
			min:       validated_numeric_min(record, attr),
			minlengh:  validated_minlengh(record, attr),
			required:  validated_presence(record, attr),
		}
	end

end
