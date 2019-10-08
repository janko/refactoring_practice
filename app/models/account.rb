class Account < ApplicationRecord
  has_many :webhooks

  def self.find_or_create_from_omniauth(auth_hash)
    find_by_omniauth(auth_hash) or create_from_omniauth(auth_hash)
  end

  def self.find_by_omniauth(auth_hash)
    by_auth(provider: auth_hash[:provider], uid: auth_hash[:uid]).first
  end

  def self.create_from_omniauth(auth_hash)
    create("#{auth_hash[:provider]}_auth": auth_hash)
  end

  scope :by_auth, -> (provider:, uid:) {
    where("#{provider}_auth ->> 'uid' = ?", uid)
  }
end
