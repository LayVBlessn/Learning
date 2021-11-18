class Station
  attr_reader :name

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

  def show_trains_all
    num = ''
    if @trains.empty?
      puts 'Станция пуста.'
    else
      @trains.each{|train| num += train.number.to_s + ' '}
    end
    return num[0...num.length-1]
  end

  def show_trains_by_type
    gruz = 0
    pass = 0
    if @trains.empty?
      return 'Станция пуста'
    else
      @trains.each do |train|
        if train.type == 'Грузовой'
          gruz += 1
        else
          pass += 1
        end
      end
    end
    return  "Пассажирских поездов на станции #{@name}: #{pass}\nГрузовых поездов на станции #{@name}: #{gruz}"
  end
end

class Route
  attr_reader :rout

  def initialize(starting_st, end_st)
    @end_st = end_st
    @route = [starting_st, @end_st]
  end

  def show_route
    route = ''
    @route.each{|x| route += x.name + ', '}
    return route[0...route.length-2]
  end

  def add_inter(station)
    @route[-1] = station
    @route << @end_st
  end

  def remove_inter(station)
    @route.delete(station)
  end
end

class Train
  attr_reader :number, :type, :wagons
  attr_accessor :speed

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons.to_i
    @speed = 0
    @routes = []
    @location = nil
  end

  def change_wagons(what_to_do)
    if @speed == 0
      case what_to_do
      when '+'
        @wagons += 1
      when '-'
        @wagons -=1
      end
    end
  end

  def stop
    @speed = 0
  end

  def set_route(route)
    @routes = route.route
    @location = @routes[0]
    @location.add_train(self)
  end

  def move(where_to_go)
    if @location == nil
      puts 'Вначале определите маршрут!'
    else
      id = @routes.find_index(@location)
      case where_to_go
      when '+'
        if id + 1 == @routes.length
        else
          @location.remove_train(self)
          @location = @routes[id + 1]
          @location.add_train(self)
        end
      when '-'
        if id - 1 < 0
        else
          @location.remove_train(self)
          @location = @routes[id-1]
          @location.add_train(self)
        end
      end
    end
  end

  def show_location
    if @location == nil
      puts 'Вначале определите маршрут!'
    else
      return @location.name
    end
  end

  def show_prev_loc
    if @location == nil
      puts 'Вначале определите маршрут!'
    else
      id = @routes.find_index(@location)
      if id - 1 < 0
        loc = "Поезд находится на начальной станции #{@location.name}"
      else
        loc = @routes[id-1].name
      end
      return loc
    end
  end

  def show_next_loc
    if @location == nil
      puts 'Вначале определите маршрут!'
    else
      id = @routes.find_index(@location)
      if id + 1 == @routes.length
        loc = "Поезд находится на конечной станции #{@location.name}"
      else
        loc = @routes[id+1].name
      end
      return loc
    end
  end
end
