# frozen_string_literal: true

module AttributesHelper

	# @param [ActiveRecord::Base] record
	# @param [String, Symbol] attr
	# @return [Hash]
	#
	def resolved_input_attributes(record, attr)
		{
			inputmode: validated_inputmode(record, attr),
			max:       validated_max(record, attr),
			maxlength: validated_maxlength(record, attr),
			min:       validated_min(record, attr),
			minlength: validated_minlength(record, attr),
			required:  validated_required(record, attr),
		}.compact
	end

end
