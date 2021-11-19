class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def remove_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type_of_train)
    train_t = []
    @trains.each{|train| train_t << train if train.type == type_of_train}
    train_t
  end

  def count_trains_by_type(type_of_train)
    trains_by_type(type_of_train).length
  end
end
