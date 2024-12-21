module Serializers
  module V1
    # V1 API Status endpoint serializer - just to check everything is properly configured
    class StatusSerializer
      def initialize
        @timestamp = DateTime.current.iso8601
      end

      def to_h
        {
          status: :ok,
          timestamp: timestamp
        }
      end

      private

      attr_reader :timestamp
    end
  end
end
