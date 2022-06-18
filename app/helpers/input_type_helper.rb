# frozen_string_literal: true

module InputTypeHelper

	# @param [ActiveRecord::Base] record
	# @param [String, Symbol] attr
	# @return [String, NilClass]
	# @example
	#   resolved_input_type @user,   :email   #=> "email"
	#   resolved_input_type @rating, :comment #=> "text"
	#   resolved_input_type @rating, :score   #=> "numeric"
	#
	def resolved_input_type(record, attr)
		v_types = validators_for_attr(record, attr).map(&:kind)
		klass = record.class

		# TODO: try using pattern matching instead
		if v_types.include? "numericality" or [:integer, :bigint, :float, :decimal].include? klass.column_for_attribute(attr).type
			"number"

		elsif v_types.include? "email" or attr.to_s.include? "email"
			"email"

		elsif v_types.include? "url" or attr.to_s.include? "url"
			"url"

		elsif v_types.include? "tel" or attr.to_s.include? "tel"
			"tel"

		elsif v_types.include? "phone" or attr.to_s.include? "phone"
			"tel"

		elsif v_types.include? "color" or attr.to_s.include? "color"
			"color"

		elsif ["search"].any? { |i| v_types.include?(i) } or attr.to_s.include? "search"
			"search"

		elsif klass.column_for_attribute(attr).type == :text
			validated_value(record: record, attr: attr, type: :length, options: [:maximm]).to_i > 256 ? "textarea" : "text"

		elsif klass.column_for_attribute(attr).type == :date
			"date"

		elsif klass.column_for_attribute(attr).type == :datetime
			"datetimelocal"

		elsif klass.column_for_attribute(attr).type == :time
			"time"

		else
			"text"
		end
	end

end
