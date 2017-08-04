module ApiAiWrapper::Trainers

  # https://api.ai/docs/reference/agent/entities#overview
  # https://api.ai/docs/reference/agent/entities#entity_object
  class EntityTrainer < ApiAiWrapper::Components::TrainerComponent

    # https://api.ai/docs/reference/agent/entities#get_entities
    # Retrieves all entities for a given token
    def get_entities
      endpoint_url = URI.join(self.engine.base_url, "entities?v=#{self.engine.version}")

      self.get(endpoint_url, {})
    end

    # https://api.ai/docs/reference/agent/entities#get_entitieseid
    # Retrieves entity info
    # eid can either be the ID or the entity NAME
    def get_entity(eid)
      endpoint_url = URI.join(self.engine.base_url, "entities/#{eid}?v=#{self.engine.version}")

      self.get(endpoint_url, {})
    end

    # https://docs.api.ai/docs/entities#post-entities
    # Creates an entity with the corresponding entries
    def post_entity(name, entries)
      body = {
        name: name,
        entries: entries
      }
      endpoint_url = URI.join(self.engine.base_url, "entities?v=#{self.engine.version}")

      self.post(endpoint_url, body.to_json)
    end

    # https://api.ai/docs/reference/agent/entities#post_entitieseidentries
    # Allows to add entries to en existing entity
    # eid can either be the ID or the entity NAME
    def post_entity_entries(eid, entries)
      endpoint_url = URI.join(self.engine.base_url, "entities/#{eid}/entries?v=#{self.engine.version}")

      self.post(endpoint_url, entries.to_json)
    end

    # https://api.ai/docs/reference/agent/entities#put_entitieseid
    # Update an entity
    def put_entity(eid, options = {})
      endpoint_url = URI.join(self.engine.base_url, "entities/#{eid}?v=#{self.engine.version}")

      self.put(endpoint_url, options.to_json)
    end

    # https://api.ai/docs/reference/agent/entities#put_entitieseid
    # Update an entity's entries
    def put_entity_entries(eid, entries)
      body = { entries: entries }
      endpoint_url = URI.join(self.engine.base_url, "entities/#{eid}/entries?v=#{self.engine.version}")

      self.put(endpoint_url, entries.to_json)
    end

    # https://api.ai/docs/reference/agent/entities#delete_entitieseid
    # Delete an entity
    # eid can either be the ID or the entity NAME
    def delete_entity(eid)
      endpoint_url = URI.join(self.engine.base_url, "entities/#{eid}?v=#{self.engine.version}")

      self.delete(endpoint_url, {})
    end

    # https://api.ai/docs/reference/agent/entities#delete_entitieseidentries
    # Delete an entity's entries
    # eid can either be the ID or the entity NAME
    # entries is an array of reference values (e.g. ["blue", "red"] for entity "color")
    def delete_entity_entries(eid, entries)
      body = { entries: entries }
      endpoint_url = URI.join(self.engine.base_url, "entities/#{eid}/entries?v=#{self.engine.version}")

      self.delete(endpoint_url, body.to_json)
    end

  end
end