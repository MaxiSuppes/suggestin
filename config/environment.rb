# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Config mailer
ActionMailer::Base.smtp_settings = {}
