class User < ActiveRecord::Base

  belongs_to :canton, class_name: 'Canton'
  belongs_to :district, class_name: 'District'
  belongs_to :commune, class_name: 'Commune'

end
