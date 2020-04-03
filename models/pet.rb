require_relative('../db/sql_runner')


class Pet

  attr_reader :id
  attr_accessor :name, :type, :dob, :owner_name,
                :owner_tel_no, :owner_address,
                :treatment_notes, :vet_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @type = options['type']
    @dob = options['dob']
    @owner_name = options['owner_name']
    @owner_tel_no = options['owner_tel_no']
    @owner_address = options['owner_address']
    @treatment_notes = options['treatment_notes']
    @vet_id = options['vet_id']
  end

  def save()
    sql = "INSERT INTO pets
           (
             name,
             type,
             dob,
             owner_name,
             owner_tel_no,
             owner_address,
             treatment_notes,
             vet_id
           )
           VALUES
           (
             $1, $2, $3, $4, $5, $6, $7, $8
           )
           RETURNING id"
    values = [@name, @type, @dob, @owner_name, @owner_tel_no,
              @owner_address, @treatment_notes, @vet_id]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def update()
    sql = "UPDATE pets SET
           (
             name,
             type,
             dob,
             owner_name,
             owner_tel_no,
             owner_address,
             treatment_notes,
             vet_id
            )
            =
            (
              $1, $2, $3, $4, $5, $6, $7, $8
            )
            WHERE id = $9"
      values[@name, @type, @dob, @owner_name, @owner_tel_no,
             @owner_address, @treatment_notes, @vet_id, @id]
      SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM pets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM pets"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM pets WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return nil if result == nil
    return Pet.new(result)
  end

  def self.find_all()
    sql = "SELECT * FROM pets"
    result = SqlRunner.run(sql)
    return nil if result.first == nil
    return result.map {|pet| Pet.new(pet)}
  end

  def vet()
    sql = "SELECT vets.* FROM vets
           INNER JOIN pets
           ON vets.id = pets.vet_id
           WHERE vets.id = $1"
    values = [@vet_id]
    result = SqlRunner.run(sql, values)
    return result.map {|vet| Vet.new(vet)}.first
  end


end
