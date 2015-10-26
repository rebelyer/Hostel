class ReservationsController < ApplicationController

  # GET /reservations/new
  def new
    session[:reservation_params] ||= {}
    @reservation = Reservation.new(session[:reservation_params])
    @reservation.current_step = session[:reservation_step]

    @rooms = Room.all
  end

  # POST /reservations
  #
  def create
    session[:reservation_params].deep_merge!(params[:reservation]) if params[:reservation]
    @reservation = Reservation.new(session[:reservation_params])
    @reservation.current_step = session[:reservation_step]
    
    @rooms = Reservation.free_rooms(@reservation.beginning, @reservation.end, @reservation.adults_number.to_i + @reservation.children_number.to_i)
    
    if @reservation.valid?
      if params[:back_button]
         @reservation.previous_step
      elsif @reservation.last_step?
         @reservation.save
      else
         @reservation.next_step
      end
      session[:reservation_step] = @reservation.current_step
    end

    if @reservation.new_record?
       render :new
    else
       session[:reservation_params] = session[:reservation_step] = nil
       redirect_to :root
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:first_name, :surname, :adults_number, :children_number, :beginning, :end, :discount, :room_id)
    end
end
