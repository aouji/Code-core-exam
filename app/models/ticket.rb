class Ticket < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title

  belongs_to :resolver,class_name: "User"
end
