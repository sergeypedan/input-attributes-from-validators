# frozen_string_literal: true

require_relative "lib/input_attributes_from_validators/version"

Gem::Specification.new do |spec|
  spec.name             = "input_attributes_from_validators"
  spec.version          = InputAttributesFromValidators::VERSION
  spec.authors          = ["Sergey Pedan"]
  spec.email            = ["sergey.pedan@gmail.com"]
  spec.license          =  "MIT"

  spec.summary          =  "A collection of helper methods for Rails to automate assigning HTML input attributes like maxlength, required, inputmode etc."
  spec.description      = <<~HEREDOC
                            #{spec.summary}.
                          HEREDOC

  spec.homepage         =  "https://github.com/sergeypedan/#{spec.name.gsub('_', '-')}"
  spec.extra_rdoc_files = ["README.md", "CHANGELOG.md"]
  spec.rdoc_options     = ["--charset=UTF-8"]
  spec.metadata         = { "changelog_uri"     => "#{spec.homepage}/blob/master/CHANGELOG.md",
                            "documentation_uri" => "https://www.rubydoc.info/gems/#{spec.name}",
                            "homepage_uri"      => "https://sergeypedan.ru/open_source_projects/#{spec.name.gsub('_', '-')}",
                            "source_code_uri"   => spec.homepage }

  spec.require_paths    = ["app", "lib"]

  spec.bindir           = "exe"
  spec.executables      = []
  spec.files            = Dir.chdir(File.expand_path(__dir__)) do
                            `git ls-files`.split("\n")
                              .reject { |f| %w[bin spec test].any? { |dir| f.start_with? dir } }
                              .reject { |f| f.start_with? "." }
                          end

  spec.add_runtime_dependency "railties", ">= 4"

  spec.add_development_dependency "rake", "~> 13"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "yard",  ">= 0.9.20", "< 1"
end
