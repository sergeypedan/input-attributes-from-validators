# frozen_string_literal: true

module InputModeHelper

	# @param [ActiveRecord::Base] record
	# @param [String, Symbol] attr
	# @return [String, NilClass]
	# @example
	#   validated_inputmode @user,   :email   #=> "email"
	#   validated_inputmode @rating, :comment #=> "text"
	#   validated_inputmode @rating, :score   #=> "numeric"
	#
	def validated_inputmode(record, attr)
		v_types = validators_for_attr(record, attr).map(&:kind)

		# TODO: try using pattern matching instead
		if v_types.include?("numericality")
			needs_integer?(record, attr) ? "numeric" : "decimal"
		elsif v_types.include?("email")
			"email"
		elsif v_types.include?("url")
			"url"
		elsif ["tel", "phone"].any? { |i| v_types.include?(i) }
			"tel"
		elsif ["search"].any? { |i| v_types.include?(i) } || attr.to_s.include?("search")
			"search"
		else
			"text"
		end
	end

	# @param [ActiveRecord::Base] record
	# @param [String, Symbol] attr
	# @return [Numeric, NilClass]
	# @example
	#   validated_step @rating,   :score  #=> 1
	#   validated_step @dumbbell, :weight #=> 0.25
	#
	def validated_step(record, attr)
		case validated_inputmode(record, attr)
		when "numeric" then   1
		when "decimal" then 0.1
		end
	end


	# https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/pattern
	# def validated_pattern(record, attr)
	# end

	private def needs_integer?(record, attr)
		validated_value(record: record, attr: attr, type: :numericality, options: [:only_integer])
	end

end
