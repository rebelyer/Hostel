class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to reservations_url
    else
      render 'new'
    end
  end

private
  def reservation_params
    params.require(:reservation).permit(:client_id, :room_id, :adults_number, :children_number, :beginning, :end, :reservation_date, :discount)
  end

end
