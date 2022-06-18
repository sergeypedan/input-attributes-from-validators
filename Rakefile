require "bundler/setup"
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "term/ansicolor"

require "./lib/input_attributes_from_validators"

RSpec::Core::RakeTask.new(:spec)

# APP_RAKEFILE = File.expand_path("test/dummy/Rakefile", __dir__)
# load "rails/tasks/engine.rake"
load "rails/tasks/statistics.rake"

task default: :spec

# desc "Publish"
# task :publish do
# 	puts `gem push pkg/activeadmin_dark_color_scheme-#{InputAttributesFromValidators::VERSION}.gem`
# end

# require 'rake/testtask'
# Rake::TestTask.new do |t|
#   t.libs << 'test'
#   t.test_files = FileList['test/**/*_test.rb']
#   t.verbose = false
#   t.warning = false
# end

# desc 'Test all Gemfiles from test/*.gemfile'
# task :test_all_gemfiles do
#   require 'term/ansicolor'
#   require 'pty'
#   require 'shellwords'
#   cmd      = 'bundle install --quiet && bundle exec rake --trace'
#   statuses = Dir.glob('./test/gemfiles/*{[!.lock]}').map do |gemfile|
#     env = {'BUNDLE_GEMFILE' => gemfile}
#     cmd_with_env = "  (#{env.map { |k, v| "export #{k}=#{Shellwords.escape v}" } * ' '}; #{cmd})"
#     $stderr.puts Term::ANSIColor.cyan("Testing\n#{cmd_with_env}")
#     Bundler.with_clean_env do
#       PTY.spawn(env, cmd) do |r, _w, pid|
#         begin
#           r.each_line { |l| puts l }
#         rescue Errno::EIO
#           # Errno:EIO error means that the process has finished giving output.
#         ensure
#           ::Process.wait pid
#         end
#       end
#     end
#     [$? && $?.exitstatus == 0, cmd_with_env]
#   end
#   failed_cmds = statuses.reject(&:first).map { |(_status, cmd_with_env)| cmd_with_env }
#   if failed_cmds.empty?
#     $stderr.puts Term::ANSIColor.green('Tests pass with all gemfiles')
#   else
#     $stderr.puts Term::ANSIColor.red("Failing (#{failed_cmds.size} / #{statuses.size})\n#{failed_cmds * "\n"}")
#     exit 1
#   end
# end

# desc 'Start a dummy Rails app server'
# task :rails_server do
#   require 'rack'
#   require 'term/ansicolor'
#   port = ENV['PORT'] || 9292
#   puts %Q(Starting on #{Term::ANSIColor.cyan "http://localhost:#{port}"})
#   Rack::Server.start(
#     config: 'test/dummy_rails/config.ru',
#     Port: port)
# end
