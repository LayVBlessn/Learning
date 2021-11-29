module ErrorPrinting
  
  def print_error(e)
    puts "Ошибка при создании объекта: #{e.message}. Попробуйте снова"
    puts '='*20
  end


end
