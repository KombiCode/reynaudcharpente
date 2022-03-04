require 'rails_helper'

RSpec.describe Activity, type: :model do

  context 'validation tests' do
    Activity.delete_all
    it 'ensures name presence' do
      activity = Activity.new().save
      expect(activity).to eq(false)
    end
    
    it 'should save successfully' do 
      activity = Activity.new(name: 'Construction').save
      expect(activity).to eq(true)
    end
  end

end
