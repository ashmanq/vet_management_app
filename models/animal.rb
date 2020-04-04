require_relative('../db/sql_runner')
require_relative('../models/owner')
require_relative('../models/checking')
require('date')


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

  def get_dob()
    date_object = Date.strptime(@dob, '%Y-%m-%d')
    format = date_object.strftime('%d/%m/%Y')
    return format.to_s
  end

  def save()
    # Code for checking if owner is registered with practice or not.
    # If not registered then the new pet won't be saved.
    owner = Owner.find(@owner_id)
    if owner.registered == 't'
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
    else
      return nil
    end
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
           ON owners.id = animals.owner_id
           WHERE owners.id = $1"
    values = [@owner_id]
    result = SqlRunner.run(sql, values)
    return result.map {|owner| Owner.new(owner)}.first
  end

  def checking()
    sql = "SELECT checkings.* FROM checkings
           INNER JOIN animals
           ON checkings.id = animals.id
           WHERE animals. id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return nil if result.first == nil
    return result.map {|checking| Checking.new(checking)}.first
  end

  def treatments()
    sql = "SELECT treatments.* FROM treatments
           INNER JOIN animals
           ON animals.id = treatments.animal_id
           WHERE animals.id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return nil if results.first == nil
    return results.map {|treatment| Treatment.new(treatment)}
  end


end
