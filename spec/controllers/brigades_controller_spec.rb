require 'spec_helper'

describe BrigadesController do

  describe "#index" do
    let(:action) { get :index }

    it_behaves_like :requires_auth
  end

end