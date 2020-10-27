class Hospital < ApplicationRecord
    # model assocation
    has_many :schedules, dependent: :destroy

    # validations
    validates_presence_of :name, :address, :phone, :location
end
