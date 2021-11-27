require_relative 'part5_train'
require_relative 'part5_station'

class Interface

  def initialize
    @trains = []
    @stations = []
  end

  def start
    while true
      case choice()
      when 1
        puts '='*20
        processor_1()

      when 2
        puts '='*20
        processor_2()

      when 3
        puts '='*20
        puts 'До свидания!'
        puts '~'*20
        break

      end
    end
  end

private

  def processor_1
    show_created_train(create_train())
  end

  def processor_2
    show_created_station(create_station())
  end

  def create_train
    @trains << Train.new
    @trains[-1]
  end

  def show_created_train(train)
    puts "#{train.type_of_train} поезд с номером #{train.number} успешно создан!"
    puts '='*20
  end

  def show_created_station(station)
    puts "Станция #{station.name} успешно создана!"
    puts '='*20
  end

  def create_station
    @stations << Station.new
    @stations[-1]
  end

  def choice
    puts '1 - Создать поезд'
    puts '2 - Создать станцию'
    puts '3 - Выйти'
    print 'Выберите команду: '
    a = gets.chomp.split.map(&:to_i)[0]
  end

end
