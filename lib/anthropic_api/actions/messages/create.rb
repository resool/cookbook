module AnthropicAPI
  module Actions
    module Messages
      class Create
        ENDPOINT_PATH = "/messages"

        def initialize(client:)
          @client = client
        end

        def call(payload)
          client.post(ENDPOINT_PATH, payload)
        end

        private

        attr_reader :client
      end
    end
  end
end
