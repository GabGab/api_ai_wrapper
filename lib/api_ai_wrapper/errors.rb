class ApiAiWrapper::Errors

  module Engine
    class Error < StandardError
      def to_s
        @message
      end
    end

    class MissingTokens < Error
      def initialize(message = nil)
        @message = message || "You have not set a developer or client token for this engine."
      end
    end

    class MissingToken < Error
      attr_reader :code

      def initialize(message = nil)
        @message = message || "Unauthorized call."
        @code = 401
      end
    end

    class ApiError < Error
      attr_reader :code, :status

      def initialize(message = nil, code = nil, status = nil)
        @message = message || "An error occured in API.AI."
        @code = code
        @status = status
      end
    end

  end

end