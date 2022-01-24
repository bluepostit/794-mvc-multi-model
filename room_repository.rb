require 'csv'

class RoomRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @rooms = []
    @next_id = 1
    load_csv
  end

  def add_room(room)
    room.id = @next_id
    @next_id += 1
    @rooms << room
    save_csv
  end

  def find(id)
    # find and return the Room instance which has this id!
    @rooms.find { |room| room.id == id }
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:capacity] = row[:capacity].to_i
      room = Room.new(row)
      @rooms << room
      @next_id = room.id + 1
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << %w[id name capacity]
      @rooms.each do |room|
        csv << [room.id, room.name, room.capacity]
      end
    end
  end
end
