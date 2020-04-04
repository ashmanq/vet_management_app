require_relative('../db/sql_runner')
require_relative('../models/animal')
require('date')

class Checking

  attr_reader :id
  attr_accessor :check_in, :check_out

  def initialize(options)
    @id = options['id'].to_i
    @check_in = options['check_in']
    @check_out = options['check_out']
  end

  def save()
    # Check if check out is after check in otherwise don't save
    if check_dates == true
      sql = "INSERT INTO checkings
              (
                id,
                check_in,
                check_out
              )
              VALUES
              (
                $1, $2, $3
              )"
      values = [@id, @check_in, @check_out]
      SqlRunner.run(sql, values)
    end
  end

  def update()
    # Check if check out is after check in otherwise don't update
    if check_dates == true
      sql = "UPDATE checkings SET
             (
               check_in,
               check_out
              )
              =
              (
                $1, $2
              )
              WHERE id = $3"
      values = [@check_in, @check_out, @id]
      SqlRunner.run(sql, values)
    end
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

  def check_dates()
    return true if @check_out > @check_in
    return false
  end

end
