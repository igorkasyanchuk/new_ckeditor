class User < ApplicationRecord
  validates :first_name, :last_name, :about, presence: true
end
