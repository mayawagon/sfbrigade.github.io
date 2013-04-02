require 'spec_helper'

describe HomeController do

  describe "#index" do
    it "does not require authentication" do
      get :index
      response.should be_success
    end
  end

end