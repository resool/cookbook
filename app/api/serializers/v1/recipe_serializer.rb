module Serializers
  module V1
    class RecipeSerializer
      def initialize(recipe:)
        @recipe = recipe
      end

      def to_h
        {
          id: id,
          content: content,
          name: name,
          status: status
        }
      end

      private

      attr_reader :recipe

      delegate :id, :content, :name, :status, to: :recipe
    end
  end
end
