module ApiAiWrapper::Components

  class Component

    attr_accessor :engine

    # We define http_verb methods get/post/put/delete to add correct headers and parse result automatically
    [:get, :post, :put, :delete].each do |http_verb|
      define_method(http_verb.to_sym) do |url, params = {}|
        raise_if_unauthorized # checks if the correct token is present
        set_headers # sets headers with the correct token

        response = self.engine.client.send(http_verb, url, params, self.engine.headers)

        handle_response(JSON.parse(response.body))
      end
    end

    private

    # Throws an error if the call is not successful
    # Returns response if no error is returned
    def handle_response(response_body)

      if response_body.is_a?(Hash) && response_body.has_key?("status")
        response_body = response_body.deep_symbolize_keys
        response_status = response_body[:status]
        response_code = response_status[:code]

        if response_code != 200
          raise ApiAiWrapper::Errors::Engine::ApiError.new(response_status[:errorDetails], response_code, response_status[:errorType])
        end
      end

      response_body
    end

  end
  
end