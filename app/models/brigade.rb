class Brigade < ActiveRecord::Base
  attr_accessible :name, :slug

  validates_presence_of :name, :slug
end
