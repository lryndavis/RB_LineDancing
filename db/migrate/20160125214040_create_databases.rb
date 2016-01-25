class CreateDatabases < ActiveRecord::Migration
  def change
    create_table(:teams) do |t|
      t.column(:name, :string)
      t.column(:slogan, :string)

      t.timestamps()
    end

    create_table(:dancers) do |t|
      t.column(:name, :string)
      t.column(:rating, :float)

      t.timestamps()
    end
  end
end
