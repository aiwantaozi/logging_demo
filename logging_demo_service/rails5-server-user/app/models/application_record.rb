ActiveRecord::Base.establish_connection(:development)

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end