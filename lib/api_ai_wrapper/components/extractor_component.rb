module ApiAiWrapper::Components
  class ExtractorComponent < ApiAiWrapper::Components::Component

    def raise_if_unauthorized
      raise ApiAiWrapper::Errors::Engine::MissingToken.new("client token is missing") if self.engine.client_token.blank?
    end

    def set_headers
      self.engine.headers = {
        "Authorization" => "Bearer #{self.engine.client_token}",
        "Content-Type" => "application/json; charset=utf-8"
      }
    end

  end
end