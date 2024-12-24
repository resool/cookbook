module Serializers
  module V1
    class IngredientSerializer
      def initialize(ingredient:)
        @ingredient = ingredient
      end

      def to_h
        {
          id: id,
          name: name || input,
          status: status
        }
      end

      private

      attr_reader :ingredient

      delegate :id, :input, :name, :status, to: :ingredient
    end
  end
end
