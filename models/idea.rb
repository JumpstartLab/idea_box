class Idea
  attr_reader :id, :title, :description

  def initialize(input)
    @id          = input[:id]
    @title       = input[:title]
    @description = input[:description]
  end

  def save
    Idea.data.insert(:title       => title,
                     :description => description)
  end

  def self.database
    @database ||= Sequel.sqlite('./db/idea_box.sqlite3')
  end

  def self.data
    verify_table_exists
    database[:ideas]
  end

  def self.verify_table_exists
    @table_exists ||= (create_table || true)
  end

  def self.create_table
    database.create_table? :ideas do
      primary_key :id
      String      :title, :size => 255
      Text        :description
    end
  end

  def self.all
    data.order(Sequel.desc(:id)).collect do |row| 
      Idea.new(row)
    end
  end
end
