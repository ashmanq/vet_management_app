require_relative("../db/sql_runner")
require_relative("../models/animal")

class Owner

  attr_reader :id
  attr_accessor :first_name, :last_name, :address, :tel_no, :registered

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @address = options['address']
    @tel_no = options['tel_no']
    @registered = options['registered']
  end

  def save()
    sql = "INSERT INTO owners
           (
             first_name,
             last_name,
             address,
             tel_no,
             registered
           )
           VALUES
           (
             $1, $2, $3, $4, $5
           )
           RETURNING id"
    values = [@first_name, @last_name, @address, @tel_no, @registered]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def update()
    sql = "UPDATE owners SET
           (
             first_name,
             last_name,
             address,
             tel_no,
             registered
            )
            =
            (
              $1, $2, $3, $4, $5
            )
            WHERE id = $6"
      values = [@first_name, @last_name, @address, @tel_no, @registered, @id]
      SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM owners WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM owners"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM owners WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return nil if result == nil
    return Owner.new(result)
  end


  def self.find_all()
    sql = "SELECT * FROM owners
            ORDER BY first_name, last_name"
    result = SqlRunner.run(sql)
    return nil if result.first == nil
    return result.map {|owner| Owner.new(owner)}
  end

  def self.find_registered()
    sql = "SELECT * FROM owners
            WHERE registered = true
            ORDER BY first_name, last_name"
    result = SqlRunner.run(sql)
    return nil if result.first == nil
    return result.map {|owner| Owner.new(owner)}
  end

  def full_name()
    return "#{@first_name} #{@last_name}"
  end

  def animals()
    sql = "SELECT animals.* FROM animals
           INNER JOIN owners
           ON animals.owner_id = owners.id
           WHERE owners.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return nil if result.first == nil
    return result.map {|animal| Animal.new(animal)}
  end

  #method to get total of outstanding bills for an owner
  def total_owed()
    sql = "SELECT SUM(treatments.bill)
          FROM ((treatments
          INNER JOIN animals
          ON animals.id = treatments.animal_id)
          INNER JOIN owners
          ON owners.id = animals.owner_id)
          WHERE owners.id = $1
          AND treatments.paid=false";
    values = [@id]
    result = SqlRunner.run(sql, values)
    return nil if result.first == nil
    return result.first['sum']
  end

end
