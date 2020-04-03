require_relative('../db/sql_runner')
require_relative('../models/owner')


class Animal
  attr_reader :id
  attr_accessor :name, :type, :dob, :treatment_notes,
                :owner_id, :vet_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @type = options['type']
    @dob = options['dob']
    @treatment_notes = options['treatment_notes']
    @owner_id = options['owner_id'].to_i
    @vet_id = options['vet_id'].to_i
  end

  def save()
    sql = "INSERT INTO animals
           (
             name,
             type,
             dob,
             treatment_notes,
             owner_id,
             vet_id
           )
           VALUES
           (
             $1, $2, $3, $4, $5, $6
           )
           RETURNING id"
    values = [@name, @type, @dob, @treatment_notes,
              @owner_id, @vet_id]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def update()
    sql = "UPDATE animals SET
           (
             name,
             type,
             dob,
             treatment_notes,
             owner_id,
             vet_id
            )
            =
            (
              $1, $2, $3, $4, $5, $6
            )
            WHERE id = $7"
      values = [@name, @type, @dob, @treatment_notes,
                @owner_id, @vet_id, @id]
      SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM animals WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM animals"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM animals WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return nil if result == nil
    return Animal.new(result)
  end

  def self.find_all()
    sql = "SELECT * FROM animals ORDER BY name"
    result = SqlRunner.run(sql)
    return nil if result.first == nil
    return result.map {|animal| Animal.new(animal)}
  end

  def vet()
    sql = "SELECT vets.* FROM vets
           INNER JOIN animals
           ON vets.id = animals.vet_id
           WHERE vets.id = $1"
    values = [@vet_id]
    result = SqlRunner.run(sql, values)
    return result.map {|vet| Vet.new(vet)}.first
  end

  def owner()
    sql = "SELECT owners.* FROM owners
           INNER JOIN animals
           ON owners.id = animals.vet_id
           WHERE owners.id = $1"
    values = [@owner_id]
    result = SqlRunner.run(sql, values)
    return result.map {|owner| Owner.new(owner)}.first
  end


end
