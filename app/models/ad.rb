class Ad < ActiveRecord::Base

  # Constants
  QTT_PER_PAGE = 6

  # Callbacks
  before_save :md_to_html

  # Associations
  belongs_to :member, optional: true
  belongs_to :category, counter_cache: true
  has_many :comments

  # Scopes
  scope :descending_order, -> (page = 1) {
    order(created_at: :desc).page(page).per(QTT_PER_PAGE)
  }
  scope :search, -> (q, page) {
    where("title LIKE ?", "%#{q}%").page(page).per(QTT_PER_PAGE)
  }
  scope :by_category, -> (id, page) {
    where(category: id).page(page).per(QTT_PER_PAGE)
  }
  scope :of_the, -> (member) { where(member: member) }

  # Pictures
  has_attached_file :picture,
          styles: { large: "800x300#", medium: "320x150#", thumb: "100x100>" },
          default_url: "/images/:style/missing.png"

  # Validations
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  validates :title, :description_md, :category, presence: true
  validates :picture, :finish_date, presence: true
  validates :price, numericality: {greater_than: 0}

  # Gem do dinheiro
  monetize :price_cents

  # Gem da avaliação
  ratyrate_rateable "quality"

  private

  def md_to_html
    options = {
      filter_html: true,
      link_attributes: {
        rel: "nofollow",
        target: "_blank"
      }
    }

    extensions = {
      space_after_headers: true,
      autolink: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    self.description = markdown.render(self.description_md)
  end

end
