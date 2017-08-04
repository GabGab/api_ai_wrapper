require "spec_helper"

RSpec.describe ApiAiWrapper::MeaningExtractor do

  let :engine do
    ApiAiWrapper::Engine.new({
      client_token: "some-token",
      developer_token: "some-token"
    })
  end

  let :meaning_extractor do
    engine.meaning_extractor
  end

  describe "#post_query(query, options = {})" do
    it "should send a call to the correct endpoint with appropriate headers and body params" do
      stub_call(engine, "query?v=#{engine.version}", {
        method: :post,
        request_body: {
          query: "some-query",
          lang: engine.locale,
          sessionId: "some-session-id"
        }.to_json
      })
      meaning_extractor.post_query("some-query", { sessionId: "some-session-id" })
    end
  end

end