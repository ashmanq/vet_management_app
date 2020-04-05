require_relative("../db/sql_runner")

class Appointment

  attr_reader :id
  attr_accessor :app_date, :app_time, :animal_id, :vet_it

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @app_date = options['app_date']
    @app_time = options['app_time']
    @animal_id = options['animal_id']
    @vet_id = options['vet_id']
  end

  def save()
    sql = "INSERT INTO appointments
          (
            app_date,
            app_time,
            animal_id,
            vet_id
          )
          VALUES
          (
            $1, $2, $3, $4
          )
          RETURNING id"
    values = [@app_date, @app_time, @animal_id, @vet_id]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def update()
    sql = "UPDATE appointments SET
           (
             app_date,
             app_time,
             animal_id,
             vet_id
            )
            =
            (
              $1, $2, $3, $4
            )
            WHERE id = $5"
    values = [@app_date, @app_time, @animal_id, @vet_id, @id]
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
    sql = "SELECT * FROM appointments"
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

end
