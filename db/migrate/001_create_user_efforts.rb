class CreateUserEfforts < ActiveRecord::Migration
  def self.up
    create_table :user_efforts do |t|
      t.column :user_id, :integer
      t.column :issue_id, :integer
      t.column :start_time, :datetime
      t.column :active, :boolean
    end
  end

  def self.down
    drop_table :user_efforts
  end
end
