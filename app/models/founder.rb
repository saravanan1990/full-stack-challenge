class Founder < ApplicationRecord
	validates :name, :title, presence: true
	validates :name, uniqueness: {message: " is already a founder of a company "}
	belongs_to :company
end
