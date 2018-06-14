class Ad < ActiveRecord::Base

  # Callbacks
  before_save :md_to_html

  # Associations
  belongs_to :member, optional: true
  belongs_to :category, counter_cache: true

  # Scopes
  scope :descending_order, -> (qtd = 9) { limit(qtd).order(created_at: :desc) }
  scope :of_the, -> (member) { where(member: member) }
  scope :by_category, -> (id) { where(category: id) }

  # Pictures
  has_attached_file :picture,
          styles: { large: "800x300#", medium: "320x150#", thumb: "100x100>" },
          default_url: "/images/:style/missing.png"

  # Validations
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  validates :title, :description_md, :category, presence: true
  validates :picture, :finish_date, presence: true
  validates :price, numericality: {greater_than: 0}

  monetize :price_cents

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
