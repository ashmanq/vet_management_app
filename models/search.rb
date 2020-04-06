require_relative('../db/sql_runner')

# Class for searching the database for owners, animals or vets
class Search

  attr_accessor :type, :query

  # def initialize(options)
  #   @type = options['type']
  #   @query = options['query']
  # end

  def self.search_by_name(query, type)
    case type
    when 'owner'
      return search_owner(query)
    when 'animal'
      return search_animal(query)
    when 'vet'
      return search_vet(query)
    else
      "Invalid search type"
    end
  end

  def self.search_owner(query)
    sql = "SELECT * FROM owners
           WHERE CONCAT(first_name, last_name)
           LIKE $1"
    search_query = "%#{query.downcase}%"
    values = [search_query]
    results = SqlRunner.run(sql, values)
    return nil if results.first == nil
    return results.map{|owner| Owner.new(owner)}
  end

  def self.search_animal(query)
    sql = "SELECT * FROM animals
           WHERE CONCAT(name, type)
           LIKE $1"
    search_query = "%#{query.downcase}%"
    values = [search_query]
    results = SqlRunner.run(sql, values)
    return nil if results.first == nil
    return results.map{|owner| Animal.new(owner)}
  end

  def self.search_vet(query)
    sql = "SELECT * FROM vets
           WHERE CONCAT(first_name, last_name)
           LIKE $1"
    search_query = "%#{query.downcase}%"
    values = [search_query]
    results = SqlRunner.run(sql, values)
    return nil if results.first == nil
    return results.map{|vet| Vet.new(vet)}
  end



end
