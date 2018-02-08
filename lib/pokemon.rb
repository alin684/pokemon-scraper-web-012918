class Pokemon

  attr_accessor :name, :db, :type, :hp
  attr_reader :id

  def initialize(id:nil, name:, type:, db:, hp:nil)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
      SQL
    db.execute(sql, name, type)

    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    @found_poke = db.execute("SELECT * FROM pokemon WHERE pokemon.id = ?", id)[0]
    new_poke = Pokemon.new(id: @found_poke[0], name: @found_poke[1], type:@found_poke[2], db: db, hp: nil)
    new_poke
  end
end
