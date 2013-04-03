class BrigadeHomeController < ApplicationController

  def brigade_home
    @brigade = Brigade.find_by(slug: params[:brigade_slug])

    render :brigade_home, layout: "brigades/simple"
  end

end
