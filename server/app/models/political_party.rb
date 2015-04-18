class PoliticalParty < ActiveRecord::Base
  has_many :users
end
