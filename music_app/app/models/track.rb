class Track < ApplicationRecord
  validates :title, :ord, presence: true
  validates :bonus, inclusion: { in: [true, false] }

  belongs_to :album,
  primary_key: :id,
  foreign_key: :album_id,
  class_name: :Album

  has_one :band,
  through: :album,
  source: :band

  has_many :notes,
  primary_key: :id,
  foreign_key: :track_id,
  class_name: :Note,
  dependent: :destroy
end
