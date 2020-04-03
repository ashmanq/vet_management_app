require_relative('../db/sql_runner')
require_relative('../models/animal')
require('date')

class Checking

  attr_reader :id
  attr_accessor :check_in, :check_out, :animal_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @check_in = options['check_in']
    @check_out = options['check_out']
    @animal_id = options['animal_id'].to_i
  end

  def save()
    sql = "INSERT INTO checkings
            (
              check_in,
              check_out,
              animal_id
            )
            VALUES
            (
              $1, $2, $3
            )
            RETURNING id"
    values = [@check_in, @check_out, @animal_id]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def update()
    sql = "UPDATE checkings SET
           (
             check_in,
             check_out,
             animal_id
            )
            =
            (
              $1, $2, $3
            )
            WHERE id = $4"
    values = [@check_in, @check_out, @animal_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM checkings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM checkings"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM checkings
           WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return nil if result == nil
    return Checking.new(result)
  end

  def self.find_all()
    sql = "SELECT * FROM checkings"
    results = SqlRunner.run(sql)
    return nil if results.first == nil
    return results.map {|checking| Checking.new(checking)}
  end

  #Converts date format from YYYY-mm-dd to dd/mm/YY
  def format_date(date)
    date_object = Date.strptime(date)
    format = date_object.strftime('%d/%m/%Y')
    return format.to_s
  end

  def get_check_in()
    return format_date(@check_in)
  end

  def get_check_out()
    return format_date(@check_out)
  end

end
