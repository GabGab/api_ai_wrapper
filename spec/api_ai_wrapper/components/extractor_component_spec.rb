require "spec_helper"

RSpec.describe ApiAiWrapper::Components::ExtractorComponent do

  describe "#raise_if_unauthorized" do
    it "should not raise if call is client_token is present" do
      engine = ApiAiWrapper::Engine.new(client_token: "some-token")
      expect { 
        engine.meaning_extractor.raise_if_unauthorized
      }.not_to raise_error
    end

    it "should raise if call is client_token is blank" do
      engine = ApiAiWrapper::Engine.new(client_token: nil, developer_token: "some-token")
      expect {
        engine.meaning_extractor.raise_if_unauthorized
      }.to raise_error(ApiAiWrapper::Errors::Engine::MissingToken)
    end
  end

  describe "#set_headers" do
    let :engine do
      ApiAiWrapper::Engine.new({
        client_token: "some-token-1",
        developer_token: "some-token"
      })
    end

    it "should set authorization and content type headers correctly" do
      expect(engine.headers).to be_nil

      engine.meaning_extractor.set_headers

      expect(engine.headers).to eq({ "Authorization" => "Bearer some-token-1", "Content-Type" => "application/json; charset=utf-8" })
    end
  end

end