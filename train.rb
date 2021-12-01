require_relative 'module_validation'
require_relative 'module_accessor'

class Train
  NUMBER_FORMAT =  /^.{3}-*.{2}$/i
  include Validation
  extend Accessor
  attr_reader :number, :type_of_train, :location, :wagons
  attr_accessor_with_history :speed
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @route = nil
    @location = nil
  end
#Метод для 6 кейса
  def jogging_through_wagons(&block)
    @wagons.each_index{|id| yield(@wagons[id], id)}
  end

  def add_wagon(wagon)
    if self.speed == 0 && self.type_of_train == wagon.type_of_wagon
      @wagons << wagon
    end
  end

  def remove_wagon
    if self.speed == 0
      self.wagons.delete(self.wagons[-1])
    end
  end

  def stop
    self.speed = 0
  end

  def set_route(route_of_train)
    @route = route_of_train
    @location = @route.stations[0]
    @location.add_train(self)
  end

  def move_forward
    return unless location_next
    @location.remove_train(self)
    @location = @route.stations[@route.stations.find_index(@location) + 1]
    @location.add_train(self)

  end

  def move_back
    return unless location_prev
    @location.remove_train(self)
    @location = @route.stations[@route.stations.find_index(@location)- 1]
    @location.add_train(self)
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

  protected # Т.к. эти методы предназначены для выполнения функционала других методов,
            # вызвав их, пользователь, не получит для себя важной информации, но для
            # методов родительсокого и дочернего классов - эти методы необходимы, поэтому protected
  attr_writer :wagons

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
