class Brigade

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :slug, type: String

  field :meetup_url, type: String
  field :github_url, type: String
  field :twitter_screen_name, type: String
  field :twitter_hashtag, type: String

  # Simple theme fields.
  field :simple_banner_img_url, type: String
  field :simple_banner_header, type: String
  field :simple_banner_text, type: String

  validates_presence_of :name, :slug
  validates_uniqueness_of :slug

end
