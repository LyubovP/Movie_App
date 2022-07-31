class Review < ApplicationRecord
    belongs_to :user
    belongs_to :movie

    #def averege_review
    #    reviews.average(:rating)
    #end
end
