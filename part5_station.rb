require_relative 'exception_station'
require_relative 'error_printing'

class Station
  include ExceptionStation
  include ErrorPrinting

  attr_reader :name

  def initialize
    input = input()
    validate_station!(input)
    @name = input
  rescue RuntimeError => e
    print_error(e)
    retry if !valid_station?(input)
  end

  private

  def input
    print 'Введите название станции: '
    input = gets.chomp.split[0]
  end


end
