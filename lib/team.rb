class Team < ActiveRecord::Base
  has_many(:dancers)
end
