

class ShortenedURL < ApplicationRecord
    validates :short_url, presence: true, uniqueness: true 
    validates :long_url, user_id, presence: true

    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    def self.random_code
        short = SecureRandom::urlsafe_base64
        until !ShortenedURL.exists?(short)
            short = SecureRandom.urlsafe_base64
        end
        short
    end

    def self.add_entry(user, long_url)
        short_url = ShortenedURL.random_code
        ShortenedURL.new(user_id: user.id, long_url: long_url, short_url: short_url)
    end
end