class Article < ApplicationRecord
	validates :title, presence: true, length: { minimum: 5}
	# ensures that all articles have a title that is at least 5 char long
end
