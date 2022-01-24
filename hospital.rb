require_relative 'patient'
require_relative 'room'
require_relative 'room_repository'
require_relative 'patient_repository'

# Patient.new('sally', 'migraines', '987987-abc', 24, 'A')
sally = Patient.new(
  name: 'sally',
  condition: 'migraines',
  id_number: '987987-abc',
  age: 24,
  blood_type: 'A'
)
# p sally

billy = Patient.new(name: 'billy', condition: 'diabetes')
# p billy

mike = Patient.new
# p mike


florence = Room.new(name: 'Florence Nightingale', capacity: 2)
p florence

begin
  florence.add_patient(sally)
  florence.add_patient(billy)
  puts "Is it full? #{florence.full?}"
  p florence

  florence.add_patient(mike)
  p florence
rescue Room::RoomFullException
  puts 'Sorry, the room is full. Try another room'
end

puts florence.name
florence.patients.each do |patient|
  puts "- #{patient.name}"
end

puts "Billy is in room #{billy.room.name}"

puts "------------------\n\n\n"



room_repo = RoomRepository.new('rooms.csv')
einstein = Room.new(name: 'Einstein', capacity: 4)
cactus = Room.new(name: 'Cactus', capacity: 6)
room_repo.add_room(einstein)
room_repo.add_room(cactus)


patient_repo = PatientRepository.new('patients.csv', room_repo)
patient_repo.all.each do |patient|
  puts "- #{patient.name} is in #{patient.room.name}"
end
