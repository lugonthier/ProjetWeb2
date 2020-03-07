class SportCategorie < ApplicationRecord
    validates :name, :slug, presence: true
    has_many :sports
end
