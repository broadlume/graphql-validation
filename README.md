[![Gem Version](https://badge.fury.io/rb/graphql-validation.svg)](https://badge.fury.io/rb/graphql-validation)

# Graphql::Validation

A simple gem to help with common validating GraphQL input objects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'graphql-validation'
```

And then execute:

    $ bundle

## Usage

```ruby
ProductValidator = Dry::Validation.Form do
  required(:amount).filled(:int?, gteq?: 0)
end

CreateProductMutation = GraphQL::Relay::Mutation.define do
  input_field :product, !ProductInputType, validate_with: ProductValidator
  return_field :id, types.ID
  # ...
end

MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  description 'The mutation root of this schema'
  field :createProduct, field: CreateProductMutation.field
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
