class Brigade

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :slug, type: String

  field :meetup_url, type: String
  field :github_url, type: String
  field :google_group_url, type: String
  field :irc_hashtag, type: String
  field :irc_url, type: String
  field :twitter_screen_name, type: String
  field :twitter_hashtag, type: String

  # Simple theme fields.
  field :simple_banner_img_url, type: String
  field :simple_banner_header, type: String
  field :simple_banner_text, type: String
  field :simple_project_list, type: String
  field :simple_contact_text, type: String

  validates_presence_of :name, :slug
  validates_uniqueness_of :slug

  def simple_projects
    @_simple_projects ||= simple_project_list.split("\n")
  end

end
