class PassengerTrain < Train
  def initialize(number)
    super(number)
    @type_of_train = 'Пассажирский'
  end
end
