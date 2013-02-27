Sequel.migration do
  change do
    create_table(:ideas) do
      primary_key   :id
      String        :title
      Text          :description
    end
  end
end
