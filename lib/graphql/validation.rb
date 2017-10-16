require 'graphql'
require 'graphql/validation/version'

module Graphql
  module Validation
    class ArgumentValidationError < GraphQL::ExecutionError
      def initialize(result)
        msgs = result.messages(full: true)
        super(compile(msgs))
      end

      private

      def compile(error_messages_hash)
        error_messages_hash.values.flatten.reduce(::String.new) do |msg, v|
          if msg.empty?
            v
          else
            [msg, v].join('. ')
          end
        end
      end
    end

    GraphQL::Argument.accepts_definitions \
      validate_with: ->(type_defn, validator) {
        type_defn.define do
          prepare ->(arg, _ctx) do
            result = validator.call(arg.to_h)
            raise ArgumentValidationError, result if result.failure?
            result.output
          end
        end
      }
  end
end
