class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    session[:reservation_params] ||= {}
    @reservation = Reservation.new(session[:reservation_params])
    @reservation.current_step = session[:reservation_step]

    @rooms = Room.all
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
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
     # respond_to do |format|
      #   format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
       #  format.json { render :show, stats: :created, location: @reservation }
      #end
       redirect_to @reservation
    end

    
#    if params[:confirmation_button] then
#       respond_to do |format|
#         if @reservation.save
#           format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
#           format.json { render :show, status: :created, location: @reservation }
#         else
#           format.html { render :new }
#           format.json { render json: @reservation.errors, status: :unprocessable_entity }
#         end
#       end
#    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end 
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
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
