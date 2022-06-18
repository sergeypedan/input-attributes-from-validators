# HTMLM input attributes helper

[![Gem Version](https://badge.fury.io/rb/input_attributes_from_validators.svg)](https://badge.fury.io/rb/input_attributes_from_validators)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "input_attributes_from_validators"
```

Import our Sass file “activeadmin-dark-color-scheme” in your CSS entrypoint that compiles ActiveAdmin CSS files:

```ruby
= form_for model: @thing do |f|
	- input_attr = resolved_input_attributes(@thing, :score)

	= f.number_field :size, class: "form-control", \
										inputmode: input_attr[:inputmode], \
										max:       input_attr[:max], \
										min:       input_attr[:min], \
										required:  input_attr[:required], \
										step:      input_attr[:step]

	= f.text_field :description, class: "form-control", \
										inputmode: input_attr[:inputmode], \
										maxlengh:  input_attr[:maxlengh], \
										minlengh:  input_attr[:minlengh], \
										required:  input_attr[:required]
```
