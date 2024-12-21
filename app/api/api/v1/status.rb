module API
  module V1
    # V1 API Status endpoint - just to check everything is properly configured
    class Status < Base
      get "status" do
        Serializers::V1::StatusSerializer.new.to_h
      end
    end
  end
end
