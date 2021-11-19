class CargoWagon
  attr_reader :type_of_wagon
  def initialize
    self.type_of_wagon = "Грузовой"
  end

  private # Тип вагона устанавливается во время инициализации и нигде больше=>private
  attr_writer :type_of_wagon
end
