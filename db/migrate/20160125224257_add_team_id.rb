class AddTeamId < ActiveRecord::Migration
  def change
    change_table(:dancers) do |t|
      t.column(:team_id, :integer)
    end
  end
end
