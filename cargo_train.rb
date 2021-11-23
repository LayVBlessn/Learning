class CargoTrain < Train
  def initialize(number)
    super(number)
    @type_of_train = 'Грузовой'
  end
end
