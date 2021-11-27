require_relative 'exception_train'
require_relative 'error_printing'


class Train
  include ExceptionTrain
  include ErrorPrinting

  attr_reader :number, :type_of_train

  def initialize()
    input = input()
    validate_train!(input[0], input[1])
    @number = input[0]
    @type_of_train = input[1]
  rescue RuntimeError => e
    print_error(e)
    retry if !valid_train?(input[0], input[1])
  end

  private

  def input
    print 'Введите номер и тип поезда через пробел: '
    input = gets.chomp.split
  end

end
