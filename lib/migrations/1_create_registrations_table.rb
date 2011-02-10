class CreateRegistrationsTable < ActiveRecord::Migration
  def self.up
    create_table(:registrations) do |t|  
      t.string :name
      t.string :email
      t.string :availability
      t.string :subject
      t.timestamps
    end  
  end

  def self.down
    drop_table :registrations
  end
end
