require 'rails_helper'

# Test suite for the Doctor model
RSpec.describe Doctor, type: :model do
  # Association test
  # ensure Doctor model has a 1:m relationship with the Schedule model
  it { should have_many(:schedules).dependent(:destroy) }
  # Validation test
  # ensure columns name, email, address and phone are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:phone) }
end
