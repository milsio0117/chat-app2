class RoomUser < ApplicationRecord
    belongs_to :room
    belongs_to :user
    has_many :messages
  end
