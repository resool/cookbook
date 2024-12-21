module API
  module V1
    # Base configuration for V1 API
    class Base < Root
      version "v1", using: :path
      format :json
      default_error_formatter :json

      mount API::V1::Status
    end
  end
end
