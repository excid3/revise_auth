require_relative "lib/revise_auth/version"

Gem::Specification.new do |spec|
  spec.name = "revise_auth"
  spec.version = ReviseAuth::VERSION
  spec.authors = ["Chris Oliver"]
  spec.email = ["excid3@gmail.com"]
  spec.homepage = "https://github.com/excid3/revise_auth"
  spec.summary = "Simple authentication for Ruby on Rails apps"
  spec.description = "Hotwire compatible authentication for Ruby on Rails apps"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/excid3/revise_auth/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.0.beta1"
  spec.add_dependency "bcrypt", "~> 3.1"
end
