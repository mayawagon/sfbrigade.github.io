class Brigade

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :slug, type: String

  validates_presence_of :name, :slug
end
