class Route
  attr_reader :stations

  def initialize(starting_st, end_st)
    @stations = [starting_st, end_st]
  end

  def add_inter(station)
    @stations.insert(-2, station)
  end

  def remove_inter(station)
    @stations.delete(station)
  end
end
