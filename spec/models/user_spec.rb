require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validation tests' do
    User.delete_all
    it 'ensures email presence' do
      user = User.new().save
      expect(user).to eq(false)
    end
    
    it 'should save successfully' do 
      user = User.new(email: 'sample@example.com', password: 'azerty', password_confirmation: 'azerty').save
      expect(user).to eq(true)
    end
  end
  
  context 'scope tests' do
    let (:params) { {email: 'sample00@example.com', password: 'azerty', password_confirmation: 'azerty'} }
    before(:each) do
      User.delete_all
      User.new(params).save
      User.new(params.merge(email: 'sample01@example.com')).save
      User.new(params.merge(email: 'sample02@example.com', admin: false)).save
      User.new(params.merge(email: 'sample03@example.com', admin: true)).save
      User.new(params.merge(email: 'sample04@example.com', admin: true)).save
    end

    it 'should return admin users' do
      expect(User.admin_users.size).to eq(2)
    end

    it 'should return nonadmin users' do
      expect(User.nonadmin_users.size).to eq(3)
    end
  end

end
