class AddCoordinator < ActiveRecord::Migration
  def change
    change_table(:teams) do |t|
      t.column(:coordinator, :integer)
    end

    change_table(:dancers) do |t|
      t.column(:coordinator, :boolean)
    end
  end
end
