class Api::V1::Memory < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :prompt, presence: true
  validates :story, presence: true
  validates :title, presence: true
  validates :public, inclusion: { in: [true, false] }
  validates :favorite, inclusion: { in: [true, false] }

  after_destroy :purge_image

  def image_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end

  private

  def purge_image
    image.purge
  end
end
