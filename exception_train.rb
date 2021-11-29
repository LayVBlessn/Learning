module ExceptionTrain
  NUMBER_FORMAT = /^.{3}-*.{2}$/i
  TYPES = ['Пассажирский', 'Грузовой']


  def valid_train?(num, type)
    validate_train!(num, type)
    true
  rescue
    false
  end

  def validate_train!(num, type)
    raise "невалидный номер: '#{num}'" if num !~ NUMBER_FORMAT
    raise "неверно указанный тип поезда: '#{type}'" if !TYPES.include? type
  end


end
