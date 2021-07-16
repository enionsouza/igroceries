require 'uri'
require 'net/http'

class Group < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :groceries

  validates :user_id, presence: true
  validates :name, uniqueness: true, presence: true
  validate :icon_is_image?

  private

  def icon_is_image?
    return true if icon.nil?

    url = URI.parse(icon)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    http.start do |session|
      errors.add(:icon, 'is not a valid image') unless session.head(url.request_uri)['Content-Type'].start_with? 'image'
    end
  end
end
