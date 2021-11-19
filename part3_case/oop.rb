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

class Route
  attr_reader :stations

  def initialize(starting_st, end_st)
    @stations = [starting_st, end_st]
  end

  def add_inter(station)
    @stations.insert(-1, station)
  end

  def remove_inter(station)
    @route.delete(station)
  end
end

class Train
  attr_reader :number, :type, :wagons, :location
  attr_accessor :speed

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons.to_i
    @speed = 0
    @route = nil
    @location = nil
  end

  def add_wagon
    if @speed == 0
      @wagons += 1
    end
  end

  def remove_wagon
    if @speed == 0
      @wagons -= 1
    end
  end

  def stop
    @speed = 0
  end

  def set_route(route_of_train)
    @route = route_of_train
    @location = @route.stations[0]
    @location.add_train(self)
  end

  def move_forward
    if check_next
      @location.remove_train(self)
      @location = @route.stations[@route.stations.find_index(@location) + 1]
      @location.add_train(self)
    end
  end

  def move_back
    if check_prev
      @location.remove_train(self)
      @location = @route.stations[@route.stations.find_index(@location)- 1]
      @location.add_train(self)
    end
  end

  def location_prev
    if check_prev
      return @route.stations[@route.stations.find_index(@location)- 1]
    end
  end

  def location_next
    if check_next
      return @route.stations[@route.stations.find_index(@location) + 1]
    end
  end

  private

  def check_prev
    if @location
      id = @route.stations.find_index(@location)
      if id - 1 >= 0
        true
      end
    end
  end

  def check_next
    if @location
      id = @route.stations.find_index(@location)
      if id + 1 != @route.stations.length
        true
      end
    end
  end
end
