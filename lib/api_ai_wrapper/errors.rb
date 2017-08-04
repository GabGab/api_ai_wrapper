class ApiAiWrapper::Errors

  module Request
    class UnsupportedParams < StandardError; end
  end

  module Engine
    class MissingTokens < StandardError
      def initialize(_message = "You have not set a developer or client token for this engine")
        @message = _message
      end
    end

    class MissingToken < StandardError
      def initialize(_message)
        @message = "Unauthorized call - #{_message}"
        @code = 401
      end
    end

    class ApiError < StandardError
      def initialize(_message, _code, _status)
        @message = _message
        @code = _code
        @status = _status
      end
    end

  end

end