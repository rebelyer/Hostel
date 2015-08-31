class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to clients_url
    else
      render 'new'
    end
  end

private
  def client_params
    params.require(:client).permit(:name, :surname, :phone_number, :email_adress)
  end
end
