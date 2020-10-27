require 'rails_helper'

RSpec.describe Schedule, type: :model do
  # Association test
  # ensure an schedule record belong to a single doctor record
  it { should belong_to(:doctor) }
  # Validation test
  # ensure column date, start_time and end_time are present before saving
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }
end
