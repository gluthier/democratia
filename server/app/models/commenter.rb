class Commenter < ActiveRecord::Base

    has_many :comments

    def self.from_omniauth(auth)
        where(auth.slice(:provider,
        :uid)).first_or_initialize.tap do |commenter|
            commenter.provider = auth.provider
            commenter.uid = auth.uid
            commenter.name = auth.info.name
            commenter.oauth_token = auth.credentials.token
            commenter.oauth_expires_at = Time.at(auth.credentials.expires_at)
            commenter.save!
        end
    end
end
