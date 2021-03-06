require_relative('../db/sql_runner')
require_relative('../models/appointment')


class Vet
  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def full_name()
    return "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def save()
    sql = "INSERT INTO vets
           (
             first_name,
             last_name
           )
           VALUES
           (
             LOWER($1), LOWER($2)
           )
           RETURNING id"
    values = [@first_name, @last_name]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def update()
    sql = "UPDATE vets SET
           (
             first_name,
             last_name
            )
            =
            (
              LOWER($1), LOWER($2)
            )
            WHERE id = $3"
      values = [@first_name, @last_name, @id]
      SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM vets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM vets"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM vets WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return nil if result.first == nil
    return result.map {|vet| Vet.new(vet)}.first
  end

  def self.find_all()
    sql = "SELECT * FROM vets ORDER BY last_name, first_name"
    result = SqlRunner.run(sql)
    return nil if result.first == nil
    return result.map {|vet| Vet.new(vet)}
  end

  def animals()
    sql = "SELECT animals.* FROM animals
           INNER JOIN vets
           ON animals.vet_id = vets.id
           WHERE vets.id = $1"
    values=[@id]
    results = SqlRunner.run(sql, values)
    return nil if results.first == nil
    return results.map {|animal| Animal.new(animal)}
  end

  def appointments()
    sql = "SELECT appointments.* FROM appointments
           INNER JOIN vets
           ON appointments.vet_id = vets.id
           WHERE vets.id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return nil if results.first == nil
    return results.map {|appointment| Appointment.new(appointment)}
  end

end
