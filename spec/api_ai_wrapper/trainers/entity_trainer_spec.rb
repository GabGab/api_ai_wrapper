require "spec_helper"

RSpec.describe ApiAiWrapper::Trainers::EntityTrainer do

  let :engine do
    ApiAiWrapper::Engine.new({
      client_token: "some-token",
      developer_token: "some-token"
    })
  end

  let :entity_trainer do
    engine.entity_trainer
  end

  describe "#get_entities" do
    it "should send a call to the correct endpoint with appropriate headers" do
      stub_call(engine, "entities")
      entity_trainer.get_entities
    end
  end

  describe "#get_entity(eid)" do
    it "should send a call to the correct endpoint with appropriate headers" do
      stub_call(engine, "entities/some-id")
      entity_trainer.get_entity("some-id")
    end
  end

  describe "#post_entity(name, entries)" do
    it "should send a call to the correct endpoint with appropriate headers and body params" do
      stub_call(engine, "entities?v=#{engine.version}", {
        method: :post,
        request_body: {
          name: "some-name",
          entries: "some-entries"
        }.to_json
      })
      entity_trainer.post_entity("some-name", "some-entries")
    end
  end

  describe "#post_entity_entries(eid, entries)" do
    it "should send a call to the correct endpoint with appropriate headers and body params" do
      stub_call(engine, "entities/some-id/entries?v=#{engine.version}", {
        method: :post,
        request_body: "some-entries".to_json
      })
      entity_trainer.post_entity_entries("some-id", "some-entries")
    end
  end

  describe "#put_entity(eid, options = {})" do
    it "should send a call to the correct endpoint with appropriate headers and body params" do
      stub_call(engine, "entities/some-id?v=#{engine.version}", {
        method: :put,
        request_body: {
          name: "new-name"
        }.to_json
      })
      entity_trainer.put_entity("some-id", { name: "new-name" })
    end
  end

  describe "#put_entity_entries(eid, entries)" do
    it "should send a call to the correct endpoint with appropriate headers and body params" do
      stub_call(engine, "entities/some-id/entries?v=#{engine.version}", {
        method: :put,
        request_body: {
          entries: "new-entries"
        }.to_json
      })
      entity_trainer.put_entity_entries("some-id", { entries: "new-entries" })
    end
  end

  describe "#delete_entity(eid)" do
    it "should send a call to the correct endpoint with appropriate headers and body params" do
      stub_call(engine, "entities/some-id?v=#{engine.version}", {
        method: :delete
      })
      entity_trainer.delete_entity("some-id")
    end
  end

  describe "#delete_entity_entries(eid, entries)" do
    it "should send a call to the correct endpoint with appropriate headers and body params" do
      stub_call(engine, "entities/some-id/entries?v=#{engine.version}", {
        method: :delete,
        request_body: {
          entries: "entries-to-delete"
        }
      })
      entity_trainer.delete_entity_entries("some-id", "entries-to-delete")
    end
  end

end