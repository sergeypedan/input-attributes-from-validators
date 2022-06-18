# frozen_string_literal: true

module ValidatorsReflectionHelper

	# @example
	#   validators_for_attr(User.new, :email) #=>
	#   [
	#     <ActiveRecord::Validations::PresenceValidator:0x @attributes=[:email], @options={}>,
	#     <EmailValidator:0x @attributes=[:email], @options={}>,
	#     <ActiveRecord::Validations::UniquenessValidator:0x @attributes=[:email], @options={}>,
	#     <ActiveRecord::Validations::PresenceValidator:0x @attributes=[:email], @options={:if=>:email_required?}>,
	#     <ActiveRecord::Validations::UniquenessValidator:0x @attributes=[:email], @options={:allow_blank=>true, :case_sensitive=>true, :if=>:will_save_change_to_email?}>,
	#     <ActiveModel::Validations::FormatValidator:0x @attributes=[:email], @options= {:allow_blank=>true, :if=>:will_save_change_to_email?}>
	#   ]
	# @param [ActiveRecord::Base] record
	# @param [String, Symbol] attr
	# @raise [TypeError]
	#
	def validators_for_attr(record, attr)
		fail TypeError, "`attr` must be a Symbol or String, you pass a #{attr.class}" unless [Symbol, String].include? attr.class
		# TODO: fail TypeError if record.class.ancestors.include?()

		record.class.validators.select { _1.attributes.include? attr }
	end

	# @param [ActiveRecord::Base] record
	# @param [String, Symbol] attr
	# @param [Array<Symbol>] options
	# @raise [TypeError]
	#
	def validators_for(record:, attr:, type: nil, options: [])
		fail TypeError, "`options` must be an Array, you pass a #{options.class}" unless options.is_a? Array
		result = validators_for_attr(record, attr).select { _1.options.keys & options }
		result = result.select { _1.is_a? validator_type_to_class(type) } if type.present?
		result
	end

	# @example
	#   validated_value(record: @review, attr: :comment, type: :length, options: [:maximm]) #=> 255
	# @param [ActiveRecord::Base] record
	# @param [String, Symbol] attr
	# @return [Integer, NilClass, Boolean]
	# @raise [TypeError]
	# @raise [TypeError]
	#
	def validated_value(record:, attr:, type: nil, options: [])
		fail TypeError, "`options` must be an Array, you pass a #{options.class}" unless options.is_a? Array
		validators_for(record: record, attr: attr, type: type, options: options).map { first_value(_1, options) }.compact.first
	end

	# @param [String, Symbol, NilClass] type
	# @example
	#   validator_type_to_class(:presence)     #=> ActiveRecord::Validations::PresenceValidator
	#   validator_type_to_class(:numericality) #=> ActiveRecord::Validations::NumericalityValidator
	#
	def validator_type_to_class(type)
		fail TypeError, "`type` must be a Symbol or String, you pass a #{type.class}" unless [Symbol, String, NilClass].include? type.class
		["ActiveRecord::Validations::", type.to_s.capitalize, "Validator"].join.constantize if type.present?
	end

	private def first_value(validator, options)
		options.map { |key| validator.options&.fetch(key, nil) }.compact.first
	end

end
