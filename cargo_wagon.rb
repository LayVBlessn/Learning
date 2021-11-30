class CargoWagon
  attr_reader :type_of_wagon, :occupated_volume
  def initialize(volume)
    @volume = volume
    @occupated_volume = 0
    self.type_of_wagon = "Грузовой"
  end

  def occup_volume(vol)
    @occupated_volume += vol if @volume > @occupated_volume
  end

  def free_volume
    @volume - @occupated_volume
  end



  private # Тип вагона устанавливается во время инициализации и нигде больше=>private
  attr_writer :type_of_wagon
end
