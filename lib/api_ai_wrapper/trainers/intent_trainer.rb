module ApiAiWrapper::Trainers

  # https://api.ai/docs/reference/agent/intents#overview
  # https://api.ai/docs/reference/agent/intents#intent_object
  class IntentTrainer < ApiAiWrapper::Components::TrainerComponent

    # https://api.ai/docs/reference/agent/intents#get_intents
    # Fetches all intents for a given token
    def get_intents
      endpoint_url = URI.join(self.engine.base_url, "intents?v=#{self.engine.version}")

      self.get(endpoint_url, {})
    end

    # https://api.ai/docs/reference/agent/intents#get_intentsiid
    # Retrieves intent info
    def get_intent(iid)
      endpoint_url = URI.join(self.engine.base_url, "intents/#{iid}?v=#{self.engine.version}")

      self.get(endpoint_url, {})
    end

    # https://api.ai/docs/reference/agent/intents#post_intents
    # Creates an intent
    # options can contain (in accordance with API reference) :
    # - contexts
    # - templates
    # - responses
    def post_intent(name, user_says_data, options = {})
      body = options.merge({
        name: name,
        auto: true, # ML activated
        userSays: user_says_data
      })
      endpoint_url = URI.join(self.engine.base_url, "intents?v=#{self.engine.version}")

      self.post(endpoint_url, body.to_json)
    end

    # https://api.ai/docs/reference/agent/intents#put_intentsiid
    # Update an intent
    def put_intent(iid, options = {})
      endpoint_url = URI.join(self.engine.base_url, "intents/#{iid}?v=#{self.engine.version}")

      self.put(endpoint_url, options.to_json)
    end

    # https://api.ai/docs/reference/agent/entities#delete_entitieseid
    # Delete an intent
    def delete_intent(iid)
      endpoint_url = URI.join(self.engine.base_url, "intents/#{iid}?v=#{self.engine.version}")

      self.delete(endpoint_url, {})
    end

  end
end