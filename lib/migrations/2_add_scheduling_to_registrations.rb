class AddSchedulingToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :scheduled, :boolean, :default => false
    add_column :registrations, :mentor, :string
    add_column :registrations, :appointment_at, :datetime
  end

  def self.down
    drop_column :registrations, :scheduled
    drop_column :registrations, :mentor
    drop_column :registrations, :appointment_at
  end
end
