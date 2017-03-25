class Movie < ApplicationRecord
	belongs_to :user
	has_many :movie_relationships
	has_many :members, :through => :movie_relationships, :source => :user
	validates :title, presence: true
	has_attached_file :avatar, styles: { medium: "300x450>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
