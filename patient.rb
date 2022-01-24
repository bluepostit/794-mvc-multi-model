class Patient
  # State
  # - condition
  # - name
  # - id number
  # - blood type
  # - age
  # - cured
  # Behavior
  # - cure!

  attr_reader :name, :condition
  attr_accessor :room, :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @condition = attributes[:condition]
    @cured = attributes[:cured] || false
    @room = attributes[:room]
  end

  def cured?
    @cured
  end

  def cure!
    @cured = true
  end
end
