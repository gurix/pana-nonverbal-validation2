require 'application_responder'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  self.responder = ApplicationResponder

  def http_basic_auth
    return if Rails.application.secrets.export_password.blank?

    authenticate_or_request_with_http_basic do |_username, password|
      password == Rails.application.secrets.export_password
    end
  end

  private

  def observable_redirect_to(url)
    if Rails.env.test?
      render plain: "If this wasn't a test, you'd be redirected to: #{url}"
    else
      redirect_to url
    end
  end
end
