class DateValidator < ActiveModel::Validator
   def validate reservation
      @beg, @end = reservation.beginning, reservation.end

      num_people = reservation.adults_number.to_i + reservation.children_number.to_i

      @rooms = Room.all
      reservation.errors[:base] << "There is no free place in our Hostel at these dates." if free_places(@beg, @end, num_people)
   end

   def free_places beg_date, end_date, num_people
      Reservation.free_rooms(beg_date, end_date, num_people).empty?
   end
end

class PeopleNumValidator < ActiveModel::Validator
   def validate reservation
      adults_num = reservation.adults_number
      children_num = reservation.children_number

      reservation.errors[:base] << "Incorrect number of people." unless correct_number_of_people adults_num, children_num
   end

   def correct_number_of_people adults_num, children_num
      adults = adults_num.is_a?(Integer) && adults_num > 0
      children = (children_num.is_a?(Integer) || children_num.is_a?(NilClass)) && children_num.to_i >= 0

      adults && children
   end
end

class Reservation < ActiveRecord::Base
   belongs_to :room
   attr_writer :current_step

   validates_presence_of :adults_number, :beginning, :end, if: :date_step?
   validates_presence_of :first_name, :surname, :phone_number, :email_address, if: :personal_step?
   validates :phone_number, format: {with: /\+\d{12}/}
   validates_presence_of :room_id, if: :room_step?
   validates_with DateValidator, if: :date_step?
   validates_with PeopleNumValidator, if: :date_step?

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
   # When there is no free beds or even one of 
   # arguments is nil - It returns []
   def self.free_rooms beg_date, end_date, num_people
      return [] if [beg_date, end_date, num_people].any?{|x| x == nil}

      Room.all.map do |room|
         room if (beg_date..end_date).all? do |date|
            rooms_beds_occupied = room.reservations.map {|res| res.adults_number + res.children_number.to_i if date > res.beginning && date < res.end}.compact.reduce(:+).to_i

            room.beds_number - rooms_beds_occupied >= num_people
         end
      end.compact
   end

private
   def personal_step?
      current_step == 'personal'
   end

   def date_step?
      current_step == 'date'
   end

   def room_step?
      current_step == 'room'
   end
      
end

