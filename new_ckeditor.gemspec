$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "new_ckeditor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "new_ckeditor"
  spec.version     = NewCkeditor::VERSION
  spec.authors     = ["Igor Kasyanchuk"]
  spec.email       = ["igorkasyanchuk@gmail.com"]
  spec.homepage    = "https://github.com/igorkasyanchuk/new_ckeditor"
  spec.summary     = "xxx"
  spec.description = "xxx"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "pry"
end
