class SportCategorie < ApplicationRecord
    validates :name, :slug, presence: true
end
