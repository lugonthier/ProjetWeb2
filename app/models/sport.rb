class Sport < ApplicationRecord
  belongs_to :user
  belongs_to :sport_categorie

  
  validates :name, :date_begin, :frequence, presence: true
  validate :date_begin_not_future
  validates :photo_file, presence: true, on: :create

  has_image :photo
  def date_begin_not_future

    if date_begin.present? && date_begin.future?
      errors.add(:date_begin, 'ne peut être dans le futur')
    end
  
  end
end
