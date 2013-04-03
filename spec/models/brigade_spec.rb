require 'spec_helper'

describe Brigade do

  [
    :name,
    :slug,
    :meetup_url,
    :github_url,
    :twitter_screen_name,
    :twitter_hashtag,
    :simple_banner_img_url,
    :simple_banner_header,
    :simple_banner_text
  ].each do |field|
    it { should allow_mass_assignment_of(:field) }
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }

  it { should validate_uniqueness_of(:slug) }

end