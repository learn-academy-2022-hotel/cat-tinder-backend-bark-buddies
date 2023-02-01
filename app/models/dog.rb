class Dog < ApplicationRecord
    validates :name, :enjoys, :age, :image, presence: true
    validates :enjoys, length: { minimum: 10 }
end
