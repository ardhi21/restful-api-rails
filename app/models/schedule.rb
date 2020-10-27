class Schedule < ApplicationRecord
  # model assocation
  belongs_to :doctor
  belongs_to :hospital

  # validation
  validates_presence_of :date, :start_time, :end_time
end
