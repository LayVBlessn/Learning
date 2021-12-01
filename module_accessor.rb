module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|

      name_history = "@#{name}_history".to_sym
      var_name = "@#{name}".to_sym
      define_method(name){instance_variable_get(var_name)}

      define_method("#{name}=".to_sym) do |value|

        instance_variable_set(var_name, value)
        value_of_var = instance_variable_get(name_history)
        if value_of_var.nil?
          instance_variable_set(name_history, [value])
        else
          value_of_var << value
          instance_variable_set(name_history, value_of_var)
        end
      end

      define_method("#{name}_history"){instance_variable_get(name_history)}

    end
  end

  def strong_attr_accessor(name, class_name)
    name_of_var = "@#{name}".to_sym
    name_of_var_class = class_name
    define_method(name){instance_variable_get(name_of_var)}
    define_method("#{name}=") do |value|
      raise TypeError, "Несовпадение типов переменной!" unless if value.is_a?(name_of_var_class)
      instance_variable_set(name_of_var, value)
    end
  end
end
end
