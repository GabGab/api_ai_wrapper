require "spec_helper"

RSpec.describe ApiAiWrapper::Trainers::IntentTrainer do

  let :engine do
    ApiAiWrapper::Engine.new({
      client_token: "some-token",
      developer_token: "some-token"
    })
  end

  let :intent_trainer do
    engine.intent_trainer
  end

  describe "#get_intents" do
    it "should send a call to the correct endpoint with appropriate headers" do
      stub_call(engine, "intents")
      intent_trainer.get_intents
    end
  end

  describe "#get_intent(iid)" do
    it "should send a call to the correct endpoint with appropriate headers" do
      stub_call(engine, "intents/some-id")
      intent_trainer.get_intent("some-id")
    end
  end

  describe "#post_intent(name, user_says_data, options = {})" do
    it "should send a call to the correct endpoint with appropriate headers and body params" do
      stub_call(engine, "intents?v=#{engine.version}", {
        method: :post,
        request_body: {
          name: "some-name",
          auto: true,
          userSays: "some-data"
        }.to_json
      })
      intent_trainer.post_intent("some-name", "some-data")
    end
  end

  describe "#put_intent(iid, options = {})" do
    it "should send a call to the correct endpoint with appropriate headers and body params" do
      stub_call(engine, "intents/some-id?v=#{engine.version}", {
        method: :put,
        request_body: {
          name: "new-name"
        }.to_json
      })
      intent_trainer.put_intent("some-id", { name: "new-name" })
    end
  end

  describe "#delete_intent(iid)" do
    it "should send a call to the correct endpoint with appropriate headers and body params" do
      stub_call(engine, "intents/some-id?v=#{engine.version}", {
        method: :delete
      })
      intent_trainer.delete_intent("some-id")
    end
  end

end