require "api_ai_wrapper/components/component"
require "api_ai_wrapper/components/trainer_component"
require "api_ai_wrapper/components/extractor_component"
require "api_ai_wrapper/trainers/intent_trainer"
require "api_ai_wrapper/trainers/entity_trainer"
require "api_ai_wrapper/meaning_extractor"

module ApiAiWrapper
  class Engine
    AUTOLOAD_CLASSES = [
      ApiAiWrapper::Trainers::EntityTrainer,
      ApiAiWrapper::Trainers::IntentTrainer,
      ApiAiWrapper::MeaningExtractor
    ]

    attr_accessor :client, :client_timeout, :headers, :locale, :base_url, :version, :client_token, :developer_token
    attr_accessor :entity_trainer, :intent_trainer, :meaning_extractor

    def initialize(options = {})
      self.client = HTTPClient.new
      self.client.receive_timeout = options[:client_timeout].presence || ApiAiWrapper::Constants::DEFAULT_CLIENT_TIMEOUT
      self.locale = options[:locale].presence || ApiAiWrapper::Constants::DEFAULT_LOCALE
      self.base_url = ApiAiWrapper::Constants::DEFAULT_BASE_URL
      self.version = options[:version].presence || ApiAiWrapper::Constants::DEFAULT_VERSION
      self.client_token = options[:client_token].presence
      self.developer_token = options[:developer_token].presence

      # RAISE ERROR IF NO TOKEN PRESENT
      raise ApiAiWrapper::Errors::Engine::MissingTokens.new if self.client_token.blank? && self.developer_token.blank?

      # define entity_trainer and intent_trainer on the fly
      AUTOLOAD_CLASSES.each{ |class_name|
        instance = class_name.new
        instance.engine = self
        self.send("#{class_name.to_s.demodulize.underscore}=", instance)
      }
    end

  end
end