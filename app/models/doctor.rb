class Doctor < ApplicationRecord
    # model assocation
    has_many :schedules, dependent: :destroy

    # validations
    validates_presence_of :name, :email, :address, :phone
end
