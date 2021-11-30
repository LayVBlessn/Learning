require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'station'
require_relative 'route'

class Interface

  def initialize
    @stations_created = []
    @routes_created = []
    @trains_created = []
  end

  def start
    choice = commands()

    while true
      case choice

      when 1

        puts '==========================='
        create_station()
        puts '==========================='

      when 2

        puts '==========================='
        create_train()

      when 3

        puts '==========================='
        create_or_change_route()

      when 4

        set_route()

      when 5

        push_remove_wagon()

      when 6

        move_train()

      when 7

        show_stations_and_trains()
        puts '==========================='

      when 8

        occupate()
        puts '==========================='

      when 9

        puts 'До свидания!'
        break

      end
      choice = commands()
    end
  end


private # со всеми этими методами будет взаимодействовать метод start,
        # => юзеру нет смысла от вызова их напрямую
def commands
  puts 'Выберите команду: '
  puts '1 - Создать станцию'
  puts '2 - Создать поезд'
  puts '3 - Создать маршрут или управлять готовым'
  puts '4 - Назначить маршрут поезду'
  puts '5 - Добавить или отцепить вагон от поезда'
  puts '6 - Переместить поезд по маршруту'
  puts '7 - Просмотреть список станций и список поездов и вагонов на каждой из них'
  puts '8 - Занять место/объем в вагоне'
  puts '9 - Выйти'
  print 'Ваш выбор: '
  choice = gets.chomp.to_i
end

def create_station()
  print 'Введите название станции: '
  name = gets.chomp
  id = @stations_created.find_index{|station| station.name == name}

  if id.nil?
    @stations_created << Station.new(name)
    return @stations_created[-1]
  else
    return @stations_created[id]
  end
end

def create_train()
  print 'Введите номер поезда и его тип через пробел: '
  input = gets.chomp.split
  number = input[0].to_i
  type = input[1]

  if type == 'Пассажирский'
    @trains_created << PassengerTrain.new(number)
    puts  "#{type} поезд создан!"
  elsif type == 'Грузовой'
    @trains_created << CargoTrain.new(number)
    puts  "#{type} поезд создан!"
  end
  puts '==========================='
end

def create_or_change_route()
  puts 'Создать маршрут или изменить готовый?'
  puts '1 - Создать'
  puts '2 - Изменить'
  print 'Ваш выбор: '
  choice_in_route = gets.chomp.to_i
  puts '==========================='

  case choice_in_route
  when 1

    if @stations_created.length < 2
      puts 'Вы еще не создали как минимум двух станций для построения маршрута!'
    else
      show_stations()
      print "Введите номер начальной и конечной станций через пробел: "
      choice_in_route = gets.chomp.split.map(&:to_i).map!{|x| x - 1}
      @routes_created << Route.new(@stations_created[choice_in_route[0]], @stations_created[choice_in_route[1]])
      puts 'Маршрут создан!'
    end

  when 2

    show_routes()
    print 'Выберите маршрут, который хотите изменить: '
    id = gets.chomp.to_i - 1
    puts 'Добавить или удалить станцию?'
    puts '1 - Добавить'
    puts '2 - Удалить'
    print 'Ваш выбор: '
    choice_in_routes = gets.chomp.to_i

    case choice_in_routes
    when 1

        temp = create_station()
        if unless @routes_created[id].stations.include?(temp)
          @routes_created[id].add_inter(temp)
          puts 'Промежуточная станция добавлена!'
        end
        end

    when 2

      if @routes_created[id].stations.length <= 2
        puts 'Нельзя удалить станцию из маршрута меньшего или равного минимальной длинны!'
      else
        @routes_created[id].remove_inter(create_station(@stations_created))
        puts 'Промежуточная станция удалена!'
      end
    end
  end
  puts '==========================='

end

def show_routes()
  puts 'Список маршрутов: '
  @routes_created.each_index{|x| puts "#{x+1} - #{@routes_created[x].stations.map(&:name)}\n"}
  puts '==========================='
end

def show_trains()
  puts 'Спиок поездов: '
  @trains_created.each_index{|x| puts "#{x+1} - Номер поезда: #{@trains_created[x].number}, Тип: #{@trains_created[x].type_of_train}"}
  puts '==========================='
end

def show_stations()
  puts 'Список станций: '
  @stations_created.each_index{|x| puts "#{x+1} #{@stations_created[x].name}"}
  puts '==========================='
end

def set_route()
  return if @trains_created.empty?
  return if @routes_created.empty?
  show_routes()
  show_trains()
  print "Введите номер маршрута и поезда по списку через пробел: "
  input = gets.chomp.split.map(&:to_i)
  @trains_created[input[1]-1].set_route(@routes_created[input[0]-1])
  puts 'Маршрут добавлен!'
  puts '==========================='
end

def move_train()
  show_trains()
  print 'Выберите номер поезда из списка, чтобы проехать по маршруту: '
  id = gets.chomp.to_i - 1
  puts '==========================='
  puts 'Выберите, куда ему ехать: '
  puts '1 - Вперед'
  puts '2 - Назад'
  print 'Ваш выбор: '
  input = gets.chomp.to_i
  puts '==========================='

  case input
  when 1

    @trains_created[id].move_forward

  when 2

    @trains_created[id].move_back

  end
  puts 'Поезд проехал по маршруту!'
  puts '==========================='
end
#Новые методы для 6 кейса
def show_stations_and_trains()
  puts '==========================='
  @stations_created.each do |station|
    puts "На станции #{station.name} находятся: "
    station.jogging_through_station do |train|
      puts "#{train.type_of_train} поезд под номером #{train.number} с #{train.wagons.length} вагонов"
      puts 'Информация о вагонах: '
      train.jogging_through_wagons do |wagon, id|
        if wagon.type_of_wagon == 'Грузовой'
          puts "Номер вагона: #{id+1}"
          puts "Тип вагона #{wagon.type_of_wagon}"
          puts "#{wagon.free_volume} объема свободно, #{wagon.occupated_volume} занято"
        else
          puts "Номер вагона: #{id+1}"
          puts "Тип вагона #{wagon.type_of_wagon}"
          puts "#{wagon.free_seats} мест свободных, #{wagon.num_of_occup_seats} занято"
        end
      end
    end
  end
end

def occupate()
  print 'Введите номер поезда: '
  train_num = gets.chomp.to_i
  print 'Введите номер вагона: '
  wagon_num = gets.chomp.to_i
  @trains_created.each do |train|
    if train.number == train_num
        train.jogging_through_wagons do |wagon, id|
          if id+1 == wagon_num
            if train.type_of_train == 'Грузовой'
              print 'Введите объем занимаемого места: '
              volume = gets.chomp.to_i
              wagon.occup_volume(volume)
              puts "Объем #{volume} в вагоне номер #{wagon_num} занят!"
            else
              wagon.occup_seat
              puts "Место в вагоне #{wagon_num} занято!"
            end
          end
        end
    end
  end
end

# Метод изменен для 6 кейса
def push_remove_wagon()
  show_trains()
  print 'Выберите номер поезда в списке, чтобы добавить или удалить вагон: '
  id = gets.chomp.to_i - 1
  puts '1 - Добавить'
  puts '2 - Удалить'
  print 'Ваш выбор: '
  input = gets.chomp.to_i

  case input
  when 1

    if @trains_created[id].type_of_train == 'Пассажирский'
      print 'Введите количество мест: '
      space = gets.chomp.to_i
      @trains_created[id].add_wagon(PassengerWagon.new(space))
      puts 'Пассажирский вагон прикреплен!'
    else
      print 'Введите объем вогона: '
      space = gets.chomp.to_i
      @trains_created[id].add_wagon(CargoWagon.new(space))
      puts 'Грузовой вагон прикреплен!'
    end

  when 2

    if @trains_created[id].wagons.empty?
      puts 'У поезда нет вагонов! Сперва добавьте их...'
    else
      @trains_created[id].remove_wagon
      puts "#{@trains_created[id].type_of_train} вагон откреплен!"
    end
  end
end

end
