require 'rails_helper'

RSpec.describe do
  it "has a valid factory" do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it "by default isn't admin" do
    expect(User.new).to_not be_admin
  end
end