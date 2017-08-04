module ApiAiWrapper

  # https://api.ai/docs/reference/agent/query#query_parameters_and_json_fields
  class MeaningExtractor < ApiAiWrapper::Components::ExtractorComponent

    # https://api.ai/docs/reference/agent/query#post_query
    # Retrieves the meaning of a utterance
    # options can contain (in accordance with API reference) :
    # - contexts
    # - location
    # - timezone
    # - lang
    # - sessionId
    def post_query(query, options = {})
      set_headers
      body = {
        query: query,
        lang: self.engine.locale,
        sessionId: SecureRandom.hex
      }.merge(options)
      endpoint_url = URI.join(self.engine.base_url, "query?v=#{self.engine.version}")

      res = self.post(endpoint_url, body.to_json)
    end

  end

end