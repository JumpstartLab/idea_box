module IdeaBox

  database_file = 'db/ideabox.sqlite3'

  if ENV["IDEA_BOX_ENV"] == "test"
    database_file = 'db/ideabox-test.sqlite3'
  end

  DB = Sequel.sqlite database_file

end

require 'models/idea'