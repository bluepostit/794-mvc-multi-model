require 'csv'

class PatientRepository
  def initialize(csv_file_path, room_repository)
    @csv_file_path = csv_file_path
    @room_repo = room_repository
    @patients = []
    @next_id = 1
    load_csv
  end

  def add_patient(patient)
    patient.id = @next_id
    @next_id += 1
    @patients << patient
    save_csv
  end

  def all
    @patients
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:room] = @room_repo.find(row[:room_id].to_i)
      patient = Patient.new(row)
      @patients << patient
      @next_id = patient.id + 1
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << %w[id name condition cured room_id]
      @patients.each do |patient|
        csv << [patient.id, patient.name, patient.condition, patient.cured?, patient.room.id]
      end
    end
  end
end
