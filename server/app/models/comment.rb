class Comment < ActiveRecord::Base
  belongs_to :commenter
  belongs_to :user
  acts_as_votable
end
