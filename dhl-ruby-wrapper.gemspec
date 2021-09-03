require_relative "lib/dhl/version"

Gem::Specification.new do |gem|
  gem.name          = "dhl-ruby-wrapper"
  gem.version       = Dhl::VERSION
  gem.authors       = ["denjamio"]
  gem.email         = ["denjamio@gmail.com"]

  gem.summary       = "Write a short summary, because RubyGems requires one."
  gem.description   = "Write a longer description or delete this line."
  gem.homepage      = "https://www.google.es/"
  gem.license       = "MIT"
  gem.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  gem.metadata["homepage_uri"] = gem.homepage
  gem.metadata["source_code_uri"] = gem.homepage

  gem.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  gem.executables   = gem.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_dependency "faraday", "~> 1.7"
  gem.add_dependency "faraday_middleware", "~> 1.1"
end
