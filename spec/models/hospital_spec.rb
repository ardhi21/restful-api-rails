require 'rails_helper'

# Test suite for the Hospital model
RSpec.describe Hospital, type: :model do
  # Association test
  # ensure Hospital model has a 1:m relationship with the schedule model
  it { should have_many(:schedules).dependent(:destroy) }
  # Validation test
  # ensure columns name, email, address and phone are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:location) }
end
