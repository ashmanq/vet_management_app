require_relative("../db/sql_runner")

class Appointment

  attr_reader :id
  attr_accessor :app_date, :app_time,  :notes, :animal_id, :vet_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @app_date = options['app_date']
    @app_time = options['app_time']
    @notes = options['notes']
    @animal_id = options['animal_id'].to_i
    @vet_id = options['vet_id'].to_i
  end

  def save()
    # We check that there isnt an existing appointment
    # for vet at same date/time
    # if check_app_clash !=nil
      sql = "INSERT INTO appointments
            (
              app_date,
              app_time,
              notes,
              animal_id,
              vet_id
            )
            VALUES
            (
              $1, $2, $3, $4, $5
            )
            RETURNING id"
      values = [@app_date, @app_time, @notes, @animal_id, @vet_id]
      @id = SqlRunner.run(sql, values).first['id']
    # end
  end

  def update()
    sql = "UPDATE appointments SET
           (
             app_date,
             app_time,
             notes,
             animal_id,
             vet_id
            )
            =
            (
              $1, $2, $3, $4, $5
            )
            WHERE id = $6"
    values = [@app_date, @app_time, @notes, @animal_id, @vet_id, @id]
    SqlRunner.run(sql, values)
  end



  def delete()
    sql = "DELETE FROM appointments WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM appointments"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM appointments WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return nil if result == nil
    return Appointment.new(result)
  end

  def self.find_all()
    sql = "SELECT * FROM appointments ORDER BY app_date, app_time"
    results = SqlRunner.run(sql)
    return nil if results.first == nil
    return results.map {|appointment| Appointment.new(appointment)}
  end

  # Find animal details for appointment
  def animal()
    sql = "SELECT animals.* FROM animals
            INNER JOIN appointments
            ON animals.id = appointments.animal_id
            WHERE appointments.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first
    return nil if result == nil
    return Animal.new(result)
  end

  # Find vet details for appointment
  def vet()
    sql = "SELECT vets.* FROM vets
            INNER JOIN appointments
            ON vets.id = appointments.vet_id
            WHERE appointments.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first
    return nil if result == nil
    return Vet.new(result)
  end

  # Change date format to UK format when displaying on site
  def get_app_date()
    date_object = Date.strptime(@app_date, '%Y-%m-%d')
    format = date_object.strftime('%d/%m/%Y')
    return format.to_s
  end

  def check_app_clash()
    # We search for dates and time for specific vet
    # in database and check if there is a clash
    sql = "SELECT COUNT(*) FROM appointments
          WHERE appointments.vet_id = $1
          AND appointments.app_time = $2
          AND appointments.app_date = $3"
    values = [@vet_id, @app_time, @app_date]
    result = SqlRunner.run(sql, values).first['count'].to_i
    return nil if result == 0
    return true
  end

end
