module API
  # Base configuration for API
  class Root < Grape::API
    mount API::V1::Base
  end
end
