# The API.AI ruby wrapper
A simple library that let's any developer automate the training process of a Natural Language Processing Engine on API.AI, and retrieve meaning from new utterances.

# To install
```ruby
gem install api_ai_wrapper
```

The only gem dependency is `http_client` to manage HTTP calls to API.AI.

# To start things up
The gem is centered around the ApiAiWrapper::Engine model that will be the gateway to all the gem's available endpoints. To make such calls, just instantiate an Engine with the correct developer and client tokens (for training and meaning retrieval) like so (in an initializer for instance) :

```ruby
$engine = ApiAiWrapper::Engine.new({
  developer_token: "YOUR DEVELOPER TOKEN",
  client_token: "YOUR CLIENT TOKEN"
})
```

That's for the basic usage, if you want complete control over your API.AI engine initialization, you might do : 

```ruby
$engine = ApiAiWrapper::Engine.new({
  developer_token: "YOUR DEVELOPER TOKEN",
  client_token: "YOUR CLIENT TOKEN",
  client_timeout: HTTPCLIENT TIMEOUT IN SECONDS (defaults to 50000),
  locale: "YOUR ENGINE REQUIRED LOCALE" (defaults to "en"),
  version: "YOUR PREFERRED API.AI VERSION" (defaults to "20150910")
})
```

Because we use HTTPClient for calls, you can override the client_timeout attribute to pick your prefered timeout. As a default, it is set to 50000 seconds.

# To actually use the gem
The API.AI API (that's a mouthful) offers two modes : the Training mode and the Query mode.

## Training Mode
Included in this gem are all endpoints available in API.AI around [entities](https://api.ai/docs/reference/agent/entities) and [intents](https://api.ai/docs/reference/agent/intents).

To use them, initializing an engine with the code above (`developer_token` is required) gives you access to an `IntentTrainer` and `EntityTrainer` instances that serve as proxy to call the corresponding endpoints. For example, assuming `$engine` has been initialized, fetching all entities on a given engine can be done as follows : 

```ruby
  entity_trainer = $engine.entity_trainer
  entities = entity_trainer.get_entities
```

Posting a new intent can be as easy as that :

```ruby
  intent_trainer = $engine.intent_trainer
  intent_trainer.post_intent({
    name: "some-name",
    user_says_data: [
      {
        data: [
          {
            text: "A sample "
          },
          {
            text: "utterance",
            alias: "object",
            meta: "@object"
          },
          {
            text: " for you"
          }
        ],
        isTemplate: false,
        count: 0
      },
      {
        data: ...
      }
    ]
  })
```

### Endpoints list

All available methods/endpoints are listed in the tables below

#### IntentTrainer

Use these methods on `intent_trainer = $engine.intent_trainer`

Name | Arguments | Description
--- | --- | ---
*get_intents* | none | Retrieves a list of all intents for the agent.
*get_intent* | `intent_id` | Retrieves the specified intent.
*post_intent* | `name`, `user_says_data`, `options` | Creates a new intent (options is a hash containing additional info about an intent specified in API.AI documentation).
*put_intent* | `intent_id`, `options` | Updates the specified intent. (options is a hash containing intent fields to modify)
*delete_intent* | `intent_id` | Deletes the specified entity.

#### EntityTrainer

Use these methods on `entity_trainer = $engine.entity_trainer`

Name | Arguments | Description
--- | --- | ---
*get_entities* | none | Retrieves a list of all entities for the agent.
*get_entity* | `entity_id` | Retrieves the specified entity.
*post_entity* | `name`, `entries` | Creates a new entity.
*post_entity_entries* | `entity_id`, `entries` | Adds an array of entity entries to the specified entity.
*put_entity* | `entity_id`, `options` | Creates or updates multiple entities. (options is a hash containing entity fields to modify)
*put_entity_entries* | `entity_id`, `entries` | Updates an array of entity entries in the specified entity.
*delete_entity* | `entity_id` | Deletes the specified entity.
*delete_entity_entries* | `entity_id`, `entries` | Deletes an array of entity entries from the specified entity.

## Query mode
After your API.AI engine is properly trained, you can retrieve meaning (intents and entities) from a novel utterance via the `query` endpoint.

To use is, initializing an engine with the code above (`client_token` is required) gives you access to a `MeaningExtractor` instance that serves as proxy to call the `query` endpoint. Assuming `$engine` has been initialized, extracting the meaning from a sentence can be done as follows : 

```ruby
  meaning_extractor = $engine.meaning_extractor
  meaning_extractor.post_query("A sample utterance")
```

This call will return a JSON parsed hash with the utterance meaning returned by API.AI

Name | Arguments | Description
--- | --- | ---
*post_query* | `query`, `options` | Takes natural language text and information, returns intent and entity information. (options is a hash containing additional info about an intent specified in API.AI documentation).

# Errors
`ApiAiWrapper::Errors::Engine::MissingTokens` error is returned when an `ApiAiWrapper::Engine` is instantiated without any token.

`ApiAiWrapper::Errors::Engine::MissingToken` errors are returned when a call is made to `entity_trainer`, `intent_trainer` or `meaning_extractor` but the appropriate token (either `developer_token` or `client_token`) has not been defined in the Engine.

`ApiAiWrapper::Errors::Engine::ApiError` error is returned whenever something goes wrong during a request to API.AI. The error contains a `error.message`, `error.code` and `error.status` identical to the ones returned by API.AI for full transparency.

