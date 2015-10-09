class DateValidator < ActiveModel::Validator
   def validate reservation
      @beg_date, @end_date = reservation.beginning, reservation.end
      @beg_date ||= Date.today
      @end_date ||= Date.today.next

      @num_people = reservation.adults_number.to_i + reservation.children_number.to_i

      @rooms = Room.all
      reservation.errors[:base] << "There is no free place in our Hostel at these dates." if free_places(@beg_date, @end_date, @num_people) 
   end

   def free_places beg_date, end_date, num_people

      return Reservation.free_rooms(beg_date, end_date, num_people).empty?
   end
end

class Reservation < ActiveRecord::Base
   belongs_to :room
   attr_writer :current_step

   validates_presence_of :adults_number, :beginning, :end, if: lambda{|r| r.current_step == 'date'}
   validates_presence_of :first_name, :surname, :phone_number, :email_adress, if: lambda{|r| r.current_step == 'personal'}
   validates_with DateValidator

   def steps
      %w[date personal room hidden]
   end

   def current_step
      @current_step || steps.first
   end

   def next_step
      self.current_step = steps[ steps.index(current_step) + 1 ]
   end

   def previous_step
      self.current_step = steps[ steps.index(current_step) - 1]
   end

   def first_step?
      current_step == steps.first
   end

   def last_step?
      current_step == steps.last
   end

   # Array of rooms in which there are free beds
   # When there is no free beds It returns []
   def self.free_rooms beg_date, end_date, num_people
      Room.all.map do |room|
         room if (beg_date..end_date).all? do |date|
            rooms_beds_occupied = room.reservations.map {|res| res.adults_number + res.children_number.to_i if date > res.beginning && date < res.end}.compact.reduce(:+).to_i

            room.beds_number - rooms_beds_occupied >= num_people
         end
      end.compact
   end
      
end

