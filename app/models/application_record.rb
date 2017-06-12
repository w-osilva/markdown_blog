class ApplicationRecord < ActiveRecord::Base
  include ActiveSupportCallbacks
  self.abstract_class = true
end
