module Validation
  NUMBER_FORMAT = /^.{3}-*.{2}$/i
  TYPES = ['Пассажирский', 'Грузовой']

  def valid?(num, type)
    validate!(num, type)
    true
  rescue
    false
  end

  def validate!(num, type)
    raise "невалидный номер: '#{num}'" if num !~ NUMBER_FORMAT
    raise "неверно указанный тип поезда: '#{type}'" if !TYPES.include? type
  end

end
