module ActiveSupportCallbacks

  module_function
  def without_callback(*args, &block)
    skip_callback(*args)
    yield
    set_callback(*args)
  end

end
