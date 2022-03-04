require 'rails_helper'

# For User we don't allow index neither show
# so test here the routing

RSpec.describe "Users", type: :routing do
  describe "GET /index" do
    it 'should not be routable' do
      expect(get("/index")).not_to be_routable
    end
  end

  describe "GET /show" do
    it 'should not be routable' do
      user = User.create!(email: 'first.last@example.com', password: 'azerty', password_confirmation: 'azerty')
      expect(get("/show/#{user.to_param}")).not_to be_routable
    end
  end
end
