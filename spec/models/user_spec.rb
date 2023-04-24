require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user)  }

  it "check if the user is valid" do
    expect(user).to be_valid
  end

  it "check presence of name" do
    expect(user.name).not_to eq(nil)
  end

  it "checks the presence of email" do
    expect(user.email).not_to eq(nil)
  end
end
