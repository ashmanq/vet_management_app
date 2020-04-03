require_relative("../db/sql_runner")
require_relative("../models/animal")

class Owner

  attr_reader :id
  attr_accessor :first_name, :last_name, :address, :tel_no
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @address = options['address']
    @tel_no = options['tel_no']
  end


    def save()
      sql = "INSERT INTO owners
             (
               first_name,
               last_name,
               address,
               tel_no
             )
             VALUES
             (
               $1, $2, $3, $4
             )
             RETURNING id"
      values = [@first_name, @last_name, @address, @tel_no]
      @id = SqlRunner.run(sql, values).first['id']
    end

    def update()
      sql = "UPDATE owners SET
             (
               first_name,
               last_name,
               address,
               tel_no
              )
              =
              (
                $1, $2, $3, $4
              )
              WHERE id = $5"
        values = [@first_name, @last_name, @address, @tel_no, @id]
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
      return Animal.new(result)
    end

    def self.find_all()
      sql = "SELECT * FROM owners ORDER BY name"
      result = SqlRunner.run(sql)
      return nil if result.first == nil
      return result.map {|animal| Animal.new(animal)}
    end

    def pets()
      sql = "SELECT animals.* FROM animals
             INNER JOIN owners
             ON animals.owner_id = owners.id
             WHERE owners.id = $1"
      values = [@id]
      result = SqlRunner.run(sql, values)
      return result.map {|animal| Animal.new(animal)}.first
    end

end
