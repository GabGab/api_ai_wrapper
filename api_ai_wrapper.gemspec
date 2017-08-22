Gem::Specification.new do |s|
  s.name        = 'api_ai_wrapper'
  s.version     = '1.0.5'
  s.date        = '2017-08-04'
  s.summary     = "An API.AI Ruby Wrapper"
  s.description = "A simple ruby library that let's any developer automate the training process of a Natural Language Processing Engine on API.AI, and retrieve meaning from new utterances."
  s.authors     = ["Vincent Gabou"]
  s.email       = 'vincent.gabou@gmail.com'
  s.files       = `git ls-files`.split($/)
  s.homepage    = 'http://rubygems.org/gems/api_ai_wrapper'
  s.license       = 'MIT'

  s.add_runtime_dependency 'httpclient', '~> 2.8', '>= 2.8.0'
end