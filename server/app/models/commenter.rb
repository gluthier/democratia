class Commenter < ActiveRecord::Base

    has_many :comments

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.provider = auth.provider
            user.uid      = auth.uid
            user.name     = auth.info.name
            user.save
        end
    end
end
