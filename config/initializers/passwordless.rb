# frozen_string_literal: true

Passwordless.default_from_address = "no-reply@#{ActionMailer::Base.default_url_options[:host]}"
Passwordless.parent_mailer = 'ApplicationMailer'
Passwordless.success_redirect_path = '/alerts'
