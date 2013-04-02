
module ExpectHelpers

  def expect_difference base, method, diff = 1, &block
    (expect &block).to change(base, method).by(diff)
  end

  def expect_no_difference base, method, &block
    expect_difference base, method, 0, &block
  end

  def expect_change base, method, options = {}, &block
    if options[:from] and options[:to]
      (expect &block).to change(base, method).from(options[:from]).to(options[:to])
    else
      (expect &block).to change(base, method)
    end
  end

  def expect_no_change base, method, &block
    (expect &block).not_to change(base, method)
  end

end