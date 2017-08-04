# The API.AI ruby wrapper
A simple library that let's any developer automate the training process of a Natural Language Processing Engine on API.AI, and retrieve meaning from new utterances.

# To install
	gem install api_ai_wrapper

# To start things up
The gem is centered around the ApiAiWrapper::Engine model that will be the gateway to all the gem's available endpoints. To make such calls, just instantiate an Engine with the correct developer and client tokens (for training and meaning retrieval) like so :

    ApiAiWrapper::Engine.new({
      developer_token: "YOUR DEVELOPER TOKEN",
      client_token: "YOUR CLIENT TOKEN"
    })

That's for the basic usage, if you want complete control over your API.AI engine initialization, you might do : 

    ApiAiWrapper::Engine.new({
      developer_token: "YOUR DEVELOPER TOKEN",
      client_token: "YOUR CLIENT TOKEN",
      client_timeout: HTTPCLIENT TIMEOUT IN SECONDS (defaults to 50000),
      locale: "YOUR ENGINE REQUIRED LOCALE" (defaults to "en"),
      version: "YOUR PREFERRED API.AI VERSION" (defaults to "20150910")
    })

# To actually use the gem
The API.AI API (that's a mouthful) offers two modes : the Training mode and the Query mode.

## Training Mode

