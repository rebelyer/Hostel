class LanguagesController < ApplicationController
  def change
    I18n.locale = params[:ln].to_sym
    redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to :root
  end
end
