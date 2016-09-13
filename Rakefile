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

  puts green("Checking for Homebrew...")
  run("which brew > /dev/null && brew update; true")
  run("which brew > /dev/null || ruby -e \"$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)\"")

  puts green("Bundling Homebrew packages...")
  packages = %w{rbenv ruby-build rbenv-binstubs xctool thrift}
  packages.each { |package| run("brew install #{package} || brew upgrade #{package}") }

  puts green("Checking rbenv version...")
  run("rbenv version-name || rbenv install")

  puts green("Checking for Bundler...")
  run("rbenv whence bundle | grep `cat .ruby-version` || rbenv exec gem install bundler")

  puts green("Bundling Ruby Gems...")
  run("rbenv exec bundle install --binstubs .bundle/bin --quiet")

  puts green("Ensuring Staples Specs repository")
  run("[ -d ~/.cocoapods/repos/staples ] || rbenv exec bundle exec pod repo add staples git@bitbucket.org:tanvishah/staples-cocoapods.git")

  puts green("Installing CocoaPods...")
  run("rbenv exec bundle exec pod install")

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
  path = File.join(File.dirname(__FILE__), 'staples-chat-ui.podspec')
  version = File.read(path).match(/\.version\s+=\s+['"](.+)['"]$/)[1]
  puts version
end

namespace :version do
  desc "Sets the version by updating staples-chat-ui.podspec"
  task :set => :fetch_origin do
    version = ENV['VERSION']
    if version.nil? || version == ''
      fail "You must specify a VERSION"
    end

    existing_tag = `git tag -l #{version}`.chomp
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
    system("git push origin HEAD") if agree("Push version update to origin? (y/n) ")
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
    existing_tag = `git tag -l #{version}`.chomp
    if existing_tag != ''
      fail "A tag already exists for version v#{version}: Maybe you need to run `rake version:set`?"
    end

    puts green("Tagging staples-chat-ui #{version}")
    run("git tag #{version}")
    run("git push origin --tags")

    root_dir = File.expand_path(File.dirname(__FILE__))
    path = File.join(root_dir, 'staples-chat-ui.podspec')
    version = File.read(path).match(/\.version\s+=\s+['"](.+)['"]$/)[1]
    existing_tag = `git tag -l #{version}`.chomp
    fail "Unable to find tag #{version}" unless existing_tag

    puts "Validating staples-chat-ui.podspec"
    run("pod spec lint --allow-warnings staples-chat-ui.podspec")

    puts "Pushing staples-chat-ui.podspec to Staples specs repo"
    run("pod repo push --allow-warnings staples staples-chat-ui.podspec")

  end
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

def green(string)
 "\033[1;32m* #{string}\033[0m"
end

def yellow(string)
 "\033[1;33m>> #{string}\033[0m"
end

def grey(string)
 "\033[0;37m#{string}\033[0m"
end
