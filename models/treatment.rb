require_relative("../db/sql_runner")

class Treatment

  attr_reader :id
  attr_accessor :details, :bill, :animal_id, :tr_date, :paid

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @details = options['details']
    @bill = options['bill']
    @tr_date = options['tr_date']
    @paid = options['paid']
    @animal_id = options['animal_id'].to_i
  end

  def save()
    sql = "INSERT INTO treatments
          (
            details,
            bill,
            animal_id,
            paid,
            tr_date
          )
          VALUES
          (
            $1, $2, $3, $4, $5
          )
          RETURNING id"
    values = [@details, @bill, @animal_id, @paid, @tr_date]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def update()
    sql = "UPDATE treatments SET
           (
             details,
             bill,
             animal_id,
             paid,
             tr_date
            )
            =
            (
              $1, $2, $3, $4, $5
            )
            WHERE id = $6"
    values = [@details, @bill, @animal_id, @paid, @tr_date, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM treatments WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM treatments"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM treatments WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return nil if result == nil
    return Treatment.new(result)
  end

  def self.find_all()
    sql = "SELECT * FROM treatments"
    results = SqlRunner.run(sql)
    return nil if results.first == nil
    return results.map {|treatment| Treatment.new(treatment)}
  end

  def animal()
    sql="SELECT animals.* FROM animals
         INNER JOIN treatments
         ON animals.id = treatments.animal_id
         WHERE treatments.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first
    return nil if result == nil
    return Animal.new(result)
  end
end
