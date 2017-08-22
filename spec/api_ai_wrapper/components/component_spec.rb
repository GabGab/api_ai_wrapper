require "spec_helper"

RSpec.describe ApiAiWrapper::Components::Component do

  let :engine do
    ApiAiWrapper::Engine.new({
      client_token: "some-token",
      developer_token: "some-token"
    })
  end

  let :component do
    comp = ApiAiWrapper::Components::Component.new
    comp.engine = engine
    comp
  end

  describe "http_verbs" do
    it "should define http_verb methods get/post/put/delete" do
      [:get, :post, :put, :delete].each do |http_verb|
        expect(component.respond_to?(http_verb)).to be true
      end
    end

    it "should call #raise_if_unauthorized for each http_verb methods" do
      expect(engine.intent_trainer).to receive(:raise_if_unauthorized).exactly(4).times
      allow(engine.intent_trainer).to receive(:set_headers).and_call_original
      allow(engine.intent_trainer).to receive(:handle_response)

      [:get, :post, :put, :delete].each do |http_verb|
        stub_call(engine, "some-url", { method: http_verb })
        engine.intent_trainer.send(http_verb, URI.join(ApiAiWrapper::Constants::DEFAULT_BASE_URL, "some-url"))
      end
    end

    it "should call #set_headers for each http_verb methods" do
      allow(engine.intent_trainer).to receive(:raise_if_unauthorized)
      expect(engine.intent_trainer).to receive(:set_headers).exactly(4).times.and_call_original
      allow(engine.intent_trainer).to receive(:handle_response)

      [:get, :post, :put, :delete].each do |http_verb|
        stub_call(engine, "some-url", { method: http_verb })
        engine.intent_trainer.send(http_verb, URI.join(ApiAiWrapper::Constants::DEFAULT_BASE_URL, "some-url"))
      end
    end

    it "should call #handle_response for each http_verb methods" do
      allow(engine.intent_trainer).to receive(:raise_if_unauthorized)
      allow(engine.intent_trainer).to receive(:set_headers).and_call_original
      expect(engine.intent_trainer).to receive(:handle_response).exactly(4).times.and_call_original

      [:get, :post, :put, :delete].each do |http_verb|
        stub_call(engine, "some-url", { method: http_verb })
        engine.intent_trainer.send(http_verb, URI.join(ApiAiWrapper::Constants::DEFAULT_BASE_URL, "some-url"))
      end
    end
  end

  describe "#handle_response(response)" do
    context "when API.AI call is successful" do
      context "from a GET request" do
        it "should return JSON parsed array for a list GET" do
          response = [{ "object-column" => "object-value" }]

          expect(component.send(:handle_response, response)).to eq(response)
        end

        it "should return JSON parsed object for an instance GET" do
          response = { "object-column" => "object-value" }

          expect(component.send(:handle_response, response)).to eq(response)
        end
      end

      context "from a POST/PUT/DELETE request" do
        it "should return JSON parsed response" do
          response = { "status" => { "code" => 200, "errorType" => "success" } }

          expect(component.send(:handle_response, response)).to eq(response.deep_symbolize_keys)
        end
      end
    end

    context "when API.AI call is in error (code is not 200)" do
      it "should return JSON parsed response" do
        response = { "status" => { "code" => 203, "errorType" => "problem", "errorDetails" => "an error" } }

        expect {
          component.send(:handle_response, response)
        }.to raise_error(ApiAiWrapper::Errors::Engine::ApiError)
      end
    end

  end

end