class User < ActiveRecord::Base

  belongs_to :canton, class_name: 'Canton'
  belongs_to :district, class_name: 'District'
  belongs_to :municipality, class_name: 'Municipality'
  belongs_to :political_party, class_name: 'PoliticalParty'

  has_many :comments

end
