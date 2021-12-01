module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validation_params
#Я создал массив хешей, который будет хранить все параметры, переданный в validate
    def validate(var_name, val_type, val_arg = nil)
      @validation_params ||= []
      @validation_params << {name: var_name, type: val_type, arg: val_arg}
    end

  end

  module InstanceMethods

    def valid?
      validate!
      true
    rescue
      false
    end

    def validate!
      self.class.validation_params.each do |param|
        name = instance_variable_get "@#{param[:name]}"
        type = param[:type]
        arg = param[:arg]
        send("#{type}_validation", name, arg)
      end
    end

    def presence_validation(name, arg)
      raise 'У атрибута не должно быть пустых значений!' if name.nil? or name==''
    end

    def format_validation(name, arg)
      raise 'Значение атрибута не соответтвует шаблону!' if name.to_s !~ arg
    end

    def type_validation(name, arg)
      raise 'Несоответствие типов!'  unless if name.instance_of?(arg)
    end

  end
end
end
