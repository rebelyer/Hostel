class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_language

private

  def accepted_language
   #read from HTTP request
   :pl
  end

  def set_language
    I18n.locale = session[:language] || accepted_language
  end
end
