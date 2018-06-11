class Ad < ActiveRecord::Base
  belongs_to :member, optional: true
  belongs_to :category

  has_attached_file :picture, styles: { medium: "700x400#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  monetize :price_cents

  scope :last_six, -> { limit(6).order(created_at: :desc) }
end
