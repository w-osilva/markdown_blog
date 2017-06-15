class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.without_callback(*args, &block)
    skip_callback(*args)
    yield
    set_callback(*args)
  end
end
