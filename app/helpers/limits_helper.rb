# frozen_string_literal: true

module LimitsHelper

	# @example
	#   validated_maxlength @review, :comment #=> 1_000
	# @param [ActiveRecord::Base] record
	# @param [String, Symbol] attr
	# @return [Integer, NilClass]
	# @see https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/maxlength
	# @raise [TypeError]
	#
	def validated_maxlength(record, attr)
		maximum = validated_value(record: record, attr: attr, type: :length, options: [:maximum])
		range   = validated_value(record: record, attr: attr, type: :length, options: [:in])
		range&.max || maximum
	end

	# @example
	#   validated_minlength @review, :comment #=> 3
	# @param [ActiveRecord::Base] record
	# @param [String, Symbol] attr
	# @return [Integer, NilClass]
	# @see https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/minlength
	# @raise [TypeError]
	#
	def validated_minlength(record, attr)
		minimum = validated_value(record: record, attr: attr, type: :length, options: [:minimum])
		range   = validated_value(record: record, attr: attr, type: :length, options: [:in])
		range&.min || minimum
	end

	# @example
	#   validated_required @rating, :score #=> 5
	# @param [ActiveRecord::Base] record
	# @param [String, Symbol] attr
	# @return [Integer, NilClass]
	# @see https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/max
	# @raise [TypeError]
	#
	def validated_max(record, attr)
		validated_value(record: record, attr: attr, type: :numericality, options: [:less_than, :less_than_or_equal_to])
	end

	# @example
	#   validated_min @rating, :score #=> 1
	# @param [ActiveRecord::Base] record
	# @param [String, Symbol] attr
	# @return [Integer, NilClass]
	# @see https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/min
	# @raise [TypeError]
	#
	def validated_min(record, attr)
		validated_value(record: record, attr: attr, type: :numericality, options: [:greater_than, :greater_than_or_equal_to])
	end

	# @example
	#   validated_required @user, :email #=> true
	# @param [ActiveRecord::Base] record
	# @param [String, Symbol] attr
	# @return [Boolean]
	# @see https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/required
	# @raise [TypeError]
	#
	def validated_required(record, attr)
		# validated_value(record: record, attr: attr, type: :presence, options: [:presece]) ?
		validators_for(record: record, attr: attr, type: :presence).any?
	end

end
