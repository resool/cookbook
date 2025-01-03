module API
  # Base configuration for API
  class Root < Grape::API
    include ::Rescuers::ActiveRecordRescue
    include ::Rescuers::IngredientRescue

    mount API::V1::Base
  end
end
