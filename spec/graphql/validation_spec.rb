require 'spec_helper'
require 'dry-validation'

ProductInputType = GraphQL::InputObjectType.define do
  name 'Product'
  argument :amount, !types.Int
end

ProductType = GraphQL::ObjectType.define do
  name 'Product'
  field :amount, !types.Int
end

ProductValidator = Dry::Validation.Form do
  required(:amount).filled(:int?, gteq?: 0)
end

CreateProductMutation = GraphQL::Relay::Mutation.define do
  input_field :product, !ProductInputType, validate_with: ProductValidator
  return_field :id, types.ID
  resolve ->(*_args) { { id: 1 } }
end

MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  description 'The mutation root of this schema'
  field :createProduct, field: CreateProductMutation.field
end

Schema = GraphQL::Schema.define { mutation MutationType }

RSpec.describe Graphql::Validation do
  it 'has a version number' do
    expect(Graphql::Validation::VERSION).not_to be nil
  end

  it 'performs the validation' do
    query_string = <<-GQL
      mutation {
        createProduct(input: { product: { amount: -1 } }) {
          id
        }
      }
    GQL

    result = Schema.execute(query_string)

    expect(result.to_h).to eql(
      'data' => {
        'createProduct' => nil
      },
      'errors' => [
        {
          'message' => 'amount must be greater than or equal to 0',
          'locations' => [{ 'line' => 2, 'column' => 9 }],
          'path' => ['createProduct']
        }
      ]
    )
  end
end
