class LanguagesController < ApplicationController
   def change
      session[:language] = params[:ln].to_sym
      I18n.locale = session[:language]
      redirect_to :back
   rescue ActionController::RedirectBackError
      redirect_to :root
   end
end
