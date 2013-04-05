
module BrigadeHomeHelper

  def brigade_home_path(brigade)
    if brigade.is_a? Brigade
      super(brigade.slug)
    else
      super(brigade)
    end
  end

  # Href to an anchor on the simple themed brigade home page.
  def brigade_home_anchor(brigade, id)
    brigade_home_path(brigade) + "##{id}"
  end

end