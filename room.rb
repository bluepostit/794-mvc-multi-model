class Room
  # State
  # - name
  # - patients
  # - capacity
  # Behavior
  # - full?
  # - add patient
  # - remove patient

  class RoomFullException < Exception
  end

  attr_reader :name, :capacity, :patients
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @capacity = attributes[:capacity] || 0
    @patients = attributes[:patients] || []
  end

  def full?
    @patients.length >= @capacity
  end

  def add_patient(patient)
    raise RoomFullException, 'The room is full' if full?

    @patients << patient
    patient.room = self
  end
end
