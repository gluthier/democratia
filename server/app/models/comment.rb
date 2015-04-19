class Comment < ActiveRecord::Base
  belongs_to :commenter
  acts_as_votable
end
