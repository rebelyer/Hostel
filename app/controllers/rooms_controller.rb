class RoomsController < ApplicationController
   def index
      @rooms = Room.all
   end

   def new
      @room = Room.new
   end

   def create
      @room = Room.new(room_params)

      if @room.save
         redirect_to rooms_url
      else
         render 'new'
      end
   end

private
   def room_params
      params.require(:room).permit(:room_number, :beds_number, :price_per_adult, :price_per_child)
   end

end
