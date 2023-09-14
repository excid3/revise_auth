require_relative "lib/revise_auth/version"

Gem::Specification.new do |spec|
  spec.name = "revise_auth-jets"
  spec.version = ReviseAuth::VERSION
  spec.authors = ["Jeremiah Parrack"]
  spec.email = ["jeremiahlukus1@gmail.com"]
  spec.homepage = "https://github.com/jeremiahlukus/revise_auth-jets"
  spec.summary = "Simple authentication for Ruby on Jets apps"
  spec.description = "Authentication for Ruby on Jets apps"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/jeremiahlukus/revise_auth-jets/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "bcrypt", "~> 3.1"
end
