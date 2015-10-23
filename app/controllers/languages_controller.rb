class LanguagesController < ApplicationController
  def change
    I18n.locale = params[:ln].to_sym
    redirect_to :back
  end
end
