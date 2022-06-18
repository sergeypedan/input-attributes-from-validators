# HTML input attributes helper

[![Gem Version](https://badge.fury.io/rb/input_attributes_from_validators.svg)](https://badge.fury.io/rb/input_attributes_from_validators)

## Installation

```ruby
gem "input_attributes_from_validators"
```

## The main idea

HTML inputs have powerful controls over browser via attributes:

- validations ([`min`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/min), [`max`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/max), [`minlength`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/minlength), [`maxlength`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/maxlength), [`required`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/required)) and
- keyboards variations ([`inputmode`](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/inputmode), [`step`](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/step)).

Normally you write those HTML attributes manually or forget about them, but most of them can be inferred from model validations and the DB column name.

## How to use

Provided that you have validators on your model:

```ruby
class Review < ActiveRecord::Base

  validates :comment, presence: true, length: { min: 3, max: 1_000 }
  validates :score, numericality: { only_integer: true, in: 1..5 }
end
```

### Individual helper methods

This gem exposes a set of helper methods, one for the corresponding HTML attribute:

```ruby
validated_inputmode @rating, :comment #=> "text"
validated_minlength @review, :comment #=> 3
validated_maxlength @review, :comment #=> 1_000
validated_required  @review, :comment #=> true
```

```ruby
validated_inputmode @rating, :score   #=> "numeric"
validated_min       @rating, :score   #=> 1
validated_max       @rating, :score   #=> 5
validated_step      @rating, :score   #=> 1
```

### Aggregate method

There is also a method that returns a hash with all the values:

```ruby
resolved_input_attributes(record, attribute_name) #=>
{
  inputmode:  <String || NilClass>,,
  max:       <Integer || NilClass>,
  maxlength: <Integer || NilClass>,
  min:       <Integer || NilClass>,
  minlength: <Integer || NilClass>,
  required: <Boolean>,
  step:      <Integer || Decimal>,
}
```

so you don’t have to repeadedly pass the record and the attribute name:

```ruby
= form_for model: @review do |f|
  - attrs = resolved_input_attributes(@review, :score)

  = f.number_field :size \
                    inputmode: attrs[:inputmode], \
                    max:       attrs[:max], \
                    min:       attrs[:min], \
                    required:  attrs[:required], \
                    step:      attrs[:step]

  = f.text_field :description \
                    inputmode: attrs[:inputmode], \
                    maxlength: attrs[:maxlength], \
                    minlength: attrs[:minlength], \
                    required:  attrs[:required]
```

## Less useful methods

Search for validators with certain conditions:

```ruby
validators_for(record: @review, attr: :comment, type: :length, options: [:maximm])
#=> 255

validators_for(record: @review, attr: :score, type: :numericality, options: [:less_than, :less_than_or_equal_to])
#=> 5
```

Also

```ruby
validated_value(record: @review, attr: :comment, type: :length, options: [:maximm])
#=> 255
```

```ruby
validator_type_to_class :presence     #=> ActiveRecord::Validations::PresenceValidator
validator_type_to_class :numericality #=> ActiveRecord::Validations::NumericalityValidator
```

## Todo

- [ ] pattern attribute
