module Rescuers
  module IngredientRescue
    extend ActiveSupport::Concern

    included do
      rescue_from IngredientNotUniqueError do |error|
        error!({ error: "this ingredient already exists", message: error }, 400)
      end
    end
  end
end
