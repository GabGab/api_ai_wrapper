require "spec_helper"

RSpec.describe ApiAiWrapper::Components::TrainerComponent do

  describe "#raise_if_unauthorized" do
    it "should not raise if call is developer_token is present" do
      engine = ApiAiWrapper::Engine.new(developer_token: "some-token")
      expect { 
        engine.entity_trainer.raise_if_unauthorized
      }.not_to raise_error
    end

    it "should raise if call is developer_token is blank" do
      engine = ApiAiWrapper::Engine.new(client_token: "some-token", developer_token: nil)
      expect {
        engine.entity_trainer.raise_if_unauthorized
      }.to raise_error(ApiAiWrapper::Errors::Engine::MissingToken)
    end
  end

  describe "#set_headers" do
    let :engine do
      ApiAiWrapper::Engine.new({
        client_token: "some-token",
        developer_token: "some-token-1"
      })
    end

    it "should set authorization and content type headers correctly" do
      expect(engine.headers).to be_nil

      engine.intent_trainer.set_headers

      expect(engine.headers).to eq({ "Authorization" => "Bearer some-token-1", "Content-Type" => "application/json; charset=utf-8" })
    end
  end

end