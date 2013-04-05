require 'spec_helper'

describe Brigade do

  [
    :name,
    :slug,
    :meetup_url,
    :github_url,
    :google_group_url,
    :irc_hashtag,
    :irc_url,
    :twitter_screen_name,
    :twitter_hashtag,
    :simple_banner_img_url,
    :simple_banner_header,
    :simple_banner_text,
    :simple_project_list,
    :simple_contact_text
  ].each do |field|
    it { should allow_mass_assignment_of(:field) }
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }

  it { should validate_uniqueness_of(:slug) }

  describe "#simple_projects" do
    let(:brigade) { Brigade.new(simple_project_list: "1\n2\n3") }

    it "splits the simple project list" do
      brigade.simple_projects.should == [ "1", "2", "3" ]
    end

    it "is memoized" do
      brigade.simple_projects
      brigade.simple_project_list == ""
      brigade.simple_projects.should == [ "1", "2", "3" ]
    end
  end

end