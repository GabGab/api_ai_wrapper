module ApiAiWrapper::Components
  class TrainerComponent < ApiAiWrapper::Components::Component

    def raise_if_unauthorized
      raise ApiAiWrapper::Errors::Engine::MissingToken.new("developer token is missing") if self.engine.developer_token.blank?
    end

    def set_headers
      self.engine.headers = {
        "Authorization" => "Bearer #{self.engine.developer_token}",
        "Content-Type" => "application/json; charset=utf-8"
      }
    end

  end
end