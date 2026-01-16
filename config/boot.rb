ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

# Suppress DidYouMean deprecation warnings from older gems
# Note: These warnings come from gems using the old DidYouMean API and are harmless.
# They may still appear during initial gem loading but will be filtered afterward.

# Override Kernel.warn to filter out DidYouMean warnings
module Kernel
  alias_method :original_warn, :warn
  
  def warn(*messages)
    filtered = messages.reject { |msg| msg.to_s.include?("DidYouMean::SPELL_CHECKERS.merge!") }
    original_warn(*filtered) unless filtered.empty?
  end
end

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
