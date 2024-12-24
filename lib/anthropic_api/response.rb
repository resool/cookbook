module AnthropicAPI
  class Response
    def initialize(response:)
      @response = response
    end

    delegate :code, :body, to: :response

    def call
      handle_error
      self
    end

    def parsed_body
      @parsed_body ||= response.parsed_response
    end

    private

    attr_reader :response

    def handle_error
      case code
      when 400 then raise Errors::BadRequestError.new(body)
      when 401 then raise Errors::UnauthorizedError.new(body)
      end
    end
  end
end
