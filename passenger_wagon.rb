class PassengerWagon
  attr_reader :type_of_wagon, :num_of_occup_seats

  def initialize(num_of_seats)
    @num_of_seats = 30
    @num_of_occup_seats = 0
    self.type_of_wagon = "Пассажирский"
  end

  def occup_seat
    @num_of_occup_seats += 1 if @num_of_seats > @num_of_occup_seats
  end

  def free_seats
    @num_of_seats - @num_of_occup_seats
  end


  private  # Тип вагона устанавливается во время инициализации и нигде больше=>private
  attr_writer :type_of_wagon
end
