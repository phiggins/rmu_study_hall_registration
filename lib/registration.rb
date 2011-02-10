class Registration < ActiveRecord::Base 
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :availability
  validates_presence_of :subject
end  
