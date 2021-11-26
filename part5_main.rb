require_relative 'part5_class_train'
require_relative 'part5_validations'

class Interface
  include Validation

  def initialize
    @trains = []
  end

  def start
    while true
      case choice()
      when 1
        puts '='*20
        processor()
      when 2
        puts '='*20
        puts 'До свидания!'
        puts '~'*20
        break
      end
    end
  end

private

  def processor
    input = input()
    validate!(input[0], input[1])
    show_created(create_train(input[0], input[1]))
  rescue RuntimeError => e
    print_error(e)
    retry if !valid?(input[0], input[1])
  end

  def print_error(e)
    puts "Ошибка при создании объекта: #{e.message}. Попробуйте снова"
    puts '='*20
  end

  def create_train(num, type)
    @trains << Train.new(num, type)
    @trains[-1]
  end

  def input
    print 'Введите номер и тип поезда через пробел: '
    input = gets.chomp.split
  end


  def show_created(train)
    puts "#{train.type_of_train} поезд с номером #{train.number} успешно создан!"
    puts '='*20
  end

  def choice
    puts '1 - Создать поезд'
    puts '2 - Выйти'
    print 'Выберите команду: '
    a = gets.chomp.split.map(&:to_i)[0]
  end

end
