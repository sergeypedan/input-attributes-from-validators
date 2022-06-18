# frozen_string_literal: true

module InputModeHelper

	# helper.input_mode(Workout.new, :repetitions_count)
	#
	def input_mode(record, attr)
		v_names = validator_names(record: record, attr: attr)

		if v_names.include?("Numericality")
			needs_integer = validated_value(record: record, attr: attr, type: :numericality, options: [:only_integer])
			needs_integer ? "numeric" : "decimal"
		elsif v_names.include?("Email")
			"email"
		elsif v_names.include?("Url")
			"url"
		elsif ["Tel", "Phone"].any? { |i| v_names.include?(i) }
			"tel"
		else
			nil
		end
	end

	def input_step(record, attr)
		case input_mode(record, attr)
		when "numeric" then   1
		when "decimal" then 0.1
		end
	end

end
