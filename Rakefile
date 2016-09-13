require 'rubygems'
begin
  require 'bundler'
  require 'bundler/setup'
  require 'date'
  begin
    Bundler.setup
  rescue Bundler::GemNotFound => gemException
    raise LoadError, gemException.to_s
  end
rescue LoadError => exception
  unless ARGV.include?('init')
    puts "Rescued exception: #{exception}"
    puts "WARNING: Failed to load dependencies: Is the project initialized? Run `rake init`"
  end
end

desc "Initialize the project for development and testing"
task :init do

  puts green("Update submodules...")
  run("git submodule update --init --recursive")

  puts green("Checking for Homebrew...")
  run("which brew > /dev/null && brew update; true")
  run("which brew > /dev/null || ruby -e \"$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)\"")

  puts green("Bundling Homebrew packages...")
  packages = %w{rbenv ruby-build rbenv-gem-rehash rbenv-binstubs xctool thrift}
  packages.each { |package| run("brew install #{package} || brew upgrade #{package}") }

  puts green("Checking rbenv version...")
  run("rbenv version-name || rbenv install")

  puts green("Checking for Bundler...")
  run("rbenv whence bundle | grep `cat .ruby-version` || rbenv exec gem install bundler")

  puts green("Bundling Ruby Gems...")
  run("rbenv exec bundle install --binstubs .bundle/bin --quiet")

  puts green("Ensuring Layer Specs repository")
  run("[ -d ~/.cocoapods/repos/layer ] || rbenv exec bundle exec pod repo add layer git@github.com:layerhq/cocoapods-specs.git")

  puts green("Installing CocoaPods...")
  run("rbenv exec bundle exec pod install --verbose")

  puts green("Checking rbenv configuration...")
  system <<-SH
  if [ -f ~/.zshrc ]; then
    grep -q 'rbenv init' ~/.zshrc || echo 'eval "$(rbenv init - --no-rehash)"' >> ~/.zshrc
  else
    grep -q 'rbenv init' ~/.bash_profile || echo 'eval "$(rbenv init - --no-rehash)"' >> ~/.bash_profile
  fi
  SH
  puts "\n" + yellow("If first initialization, load rbenv by executing:")
  puts grey("$ `eval \"$(rbenv init - --no-rehash)\"`")
end

desc "Prints the current version of Atlas"
task :version do
  puts atlas_version
end

namespace :version do
  desc "Sets the version by updating staples-chat-ui.podspec"
  task :set => :fetch_origin do
    version = ENV['VERSION']
    if version.nil? || version == ''
      fail "You must specify a VERSION"
    end

    existing_tag = `git tag -l v#{version}`.chomp
    if existing_tag != ''
      fail "A tag already exists for version v#{version}: please specify a unique release version."
    end

    podspec_path = File.join(File.dirname(__FILE__), 'staples-chat-ui.podspec')
    podspec_content = File.read(podspec_path)
    unless podspec_content.gsub!(/(\.version\s+=\s+)['"](.+)['"]$/, "\\1'#{version}'")
      raise "Unable to update version of Podspec: version attribute not matched."
    end
    File.open(podspec_path, 'w') { |f| f << podspec_content }

    run "git add staples-chat-ui.podspec"

    require 'highline/import'
    system("git diff --cached") if agree("Review package diff? (y/n) ")
    system("bundle exec pod update") if agree("Run `pod update`? (y/n) ")
    system("git commit -m 'Updating version to #{version}' staples-chat-ui.podspec Podfile.lock") if agree("Commit package artifacts? (y/n) ")
    system("git push origin HEAD") if agree("Push version update to origin? (y/n)")
  end
end

desc "Verifies the staples-chat-ui release tag and package"
task :release => [:fetch_origin] do
  with_clean_env do
    path = File.join(File.dirname(__FILE__), 'staples-chat-ui.podspec')
    version = File.read(path).match(/\.version\s+=\s+['"](.+)['"]$/)[1]

    changelog = File.read(File.join(File.dirname(__FILE__), 'CHANGELOG.md'))
    version_prefix = version.gsub(/-[\w\d]+/, '')
    puts "Checking for #{version_prefix}"
    unless changelog =~ /^## #{version_prefix}/
      fail "Unable to locate CHANGELOG section for version #{version}"
    end

    puts "Fetching remote tags from origin..."
    run "git fetch origin --tags"
    existing_tag = `git tag -l v#{version}`.chomp
    if existing_tag != ''
      fail "A tag already exists for version v#{version}: Maybe you need to run `rake version:set`?"
    end

    puts green("Tagging staples-chat-ui v#{version}")
    run("git tag v#{version}")
    run("git push origin --tags")

    root_dir = File.expand_path(File.dirname(__FILE__))
    path = File.join(root_dir, 'staples-chat-ui.podspec')
    version = File.read(path).match(/\.version\s+=\s+['"](.+)['"]$/)[1]
    existing_tag = `git tag -l v#{version}`.chomp
    fail "Unable to find tag v#{version}" unless existing_tag

    #Rake::Task["publish_github_release"].invoke
  end
end

desc "Publishes a Github release including the changelog"
task :publish_github_release do
  if ENV['GITHUB_TOKEN']
    require 'json'
    run "rm -rf ~/Library/Caches/com.layer.Atlas"
    version = ENV['VERSION'] || current_version
    version_tag = "v#{version}"
    release_notes = changelog_for_version(version)
    puts "Creating Github release #{version_tag}..."
    puts "Release Notes:\n#{release_notes}"
    release = { tag_name: version_tag, body: release_notes }
    uri = URI('https://api.github.com/repos/layerhq/Atlas-iOS/releases')
    request = Net::HTTP::Post.new(uri)
    request.basic_auth ENV['GITHUB_TOKEN'], 'x-oauth-basic'
    request.body = JSON.generate(release)
    request["Content-Type"] = "application/json"
    http = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = true
    response = http.request(request)
    puts "Got response: #{response}"
    release = JSON.parse(response.body)
    puts "Created release: #{release.inspect}"
  else
    puts "!! Cannot create Github release on releases-ios: Please configure a personal Github token and export it as the `GITHUB_TOKEN` environment variable."
  end
end

task :extract_changelog do
  puts changelog_for_version(current_version)
end

task :fetch_origin do
  run "git fetch origin --tags"
end

# Safe to run when Bundler is not available
def with_clean_env(&block)
  if defined?(Bundler)
    Bundler.with_clean_env(&block)
  else
    yield
  end
end

def run(command, options = {})
  puts "Executing `#{command}`" unless options[:quiet]
  unless with_clean_env { system(command) }
    fail("Command exited with non-zero exit status (#{$?}): `#{command}`")
  end
end

def atlas_version
  path = File.join(File.dirname(__FILE__), 'Atlas.podspec')
  version = File.read(path).match(/\.version\s+=\s+['"](.+)['"]$/)[1]
end

def green(string)
 "\033[1;32m* #{string}\033[0m"
end

def yellow(string)
 "\033[1;33m>> #{string}\033[0m"
end

def grey(string)
 "\033[0;37m#{string}\033[0m"
end

def changelog_for_version(version)
  capturing = false
  Array.new.tap do |release_notes|
    File.read('./CHANGELOG.md').each_line do |line|
      if line =~ /^\#\#\s#{Regexp.escape(version)}$/
        capturing = true
      else
        if line =~ /^\#\#\s[\d\.]+$/
          capturing = false
        else
          if capturing
            release_notes << line
          end
        end
      end
    end
  end.join
end

def current_version
  root_dir = File.expand_path(File.dirname(__FILE__))
  path = File.join(root_dir, 'Atlas.podspec')
  File.read(path).match(/\.version\s+=\s+['"](.+)['"]$/)[1]
end
