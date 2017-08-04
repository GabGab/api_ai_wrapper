require "spec_helper"

RSpec.describe ApiAiWrapper::Engine do

  let :engine do
    ApiAiWrapper::Engine.new({
      client_token: "some-token",
      developer_token: "some-token"
    })
  end

  let :default_params do
    { client_token: "some-token", developer_token: "some-token" }
  end

  describe "#initialize" do

    it "should instantiate a HTTPClient as a 'client' accessor" do
      expect(engine.client).to be_instance_of(HTTPClient)
    end

    describe "client_timeout" do
      it "should instantiate a default 'client_timeout' accessor as DEFAULT_CLIENT_TIMEOUT" do
        expect(engine.client.receive_timeout).to eq(ApiAiWrapper::Constants::DEFAULT_CLIENT_TIMEOUT)
      end

      it "should instantiate a 'client_timeout' accessor when specified in options" do
        expect(ApiAiWrapper::Engine.new(default_params.merge({ client_timeout: 1000 })).client.receive_timeout).to eq(1000)
      end
    end

    describe "locale" do
      it "should instantiate a default 'locale' accessor as en" do
        expect(engine.locale).to eq(ApiAiWrapper::Constants::DEFAULT_LOCALE)
      end

      it "should instantiate a 'locale' accessor when specified in options" do
        expect(ApiAiWrapper::Engine.new(default_params.merge({ locale: "fr" })).locale).to eq("fr")
      end
    end

    it "should instantiate the correct default base url as 'base_url' accessor" do
      expect(engine.base_url).to eq(ApiAiWrapper::Constants::DEFAULT_BASE_URL)
    end

    describe "version" do
      it "should instantiate a default 'version' accessor" do
        expect(engine.version).to eq(ApiAiWrapper::Constants::DEFAULT_VERSION)
      end

      it "should instantiate a 'locale' accessor when specified in options" do
        expect(ApiAiWrapper::Engine.new(default_params.merge({ version: "some-version" })).version).to eq("some-version")
      end
    end

    describe "tokens" do
      it "should instantiate a 'client_token' accessor when specified in options" do
        expect(ApiAiWrapper::Engine.new({ client_token: "some-token" }).client_token).to eq("some-token")
      end

      it "should instantiate a 'developer_token' accessor when specified in options" do
        expect(ApiAiWrapper::Engine.new({ developer_token: "some-token" }).developer_token).to eq("some-token")
      end

      it "should raise MissingToken error if no token is present" do
        expect { ApiAiWrapper::Engine.new }.to raise_error(ApiAiWrapper::Errors::Engine::MissingTokens)
      end
    end

    describe "class autoloading" do
      it "should instantiate an EntityTrainer as 'entity_trainer' accessor" do
        expect(engine.entity_trainer).to be_instance_of(ApiAiWrapper::Trainers::EntityTrainer)
      end

      it "should instantiate an IntentTrainer as 'intent_trainer' accessor" do
        expect(engine.intent_trainer).to be_instance_of(ApiAiWrapper::Trainers::IntentTrainer)
      end

      it "should instantiate an MeaningExtractor as 'meaning_extractor' accessor" do
        expect(engine.meaning_extractor).to be_instance_of(ApiAiWrapper::MeaningExtractor)
      end
    end

  end

end