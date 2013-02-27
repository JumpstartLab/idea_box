module IdeaBox
  class Idea

    def self.count
      DB["SELECT count(*) FROM ideas"].first[:"count(*)"]
    end

    def self.all
      results = DB.fetch "SELECT * FROM ideas"
      results.map do |result|
        Idea.new id: result[:id], title: result[:title], description: result[:description]
      end
    end

    def self.find(id)
      results = DB.fetch "SELECT * FROM ideas WHERE id=#{id.to_i}"
      results.map do |result|
        Idea.new id: result[:id], title: result[:title], description: result[:description]
      end.first
    end

    attr_accessor :id, :title, :description

    def initialize(params={})
      @id = params[:id]
      @title = params[:title]
      @description = params[:description]
    end

    def save
      insert_statement = DB["INSERT INTO ideas (title,description) VALUES (?,?)",title,description]
      insert_statement.insert
    end

  end
end