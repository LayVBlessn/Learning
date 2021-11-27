module ExceptionStation
  NAME_FORMAT = /^[А-Я].+[а-я]$/

  def valid_station?(name)
    validate_station!(name)
    true
  rescue
    false
  end

  def validate_station!(name)
    raise "невалидное имя '#{name}'" if name !~ NAME_FORMAT
  end

end
