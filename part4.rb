module Company
  def company(comp)
    self.comp = comp
  end

  def show_company
    self.comp
  end

protected
  attr_accessor :comp
end


module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    @inst = 0

    def instances
      @inst
    end

    def counter
      @inst += 1
    end
  end

  module InstanceMethods

    protected

    def register_instance
      self.class.counter
    end
  end
end


class Route
  include InstanceCounter
  init()
  def initialize
    register_instance
  end
end


class Train
  include Company
  include InstanceCounter
  attr_reader :number
  @@all = []

  def initialize(number)
    register_instance
    @number = number
    @@all << self
  end

  def self.find(num)
    @@all.find{|x| x.number == num}
  end
end

class Wagon
  include Company
end

class Station
  include InstanceCounter
  @@all = []

  def self.all
    @@all
  end

  def initialize
    register_instance
    @@all << self
  end
end
