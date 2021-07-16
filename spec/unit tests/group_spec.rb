require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'checks if the group arguments are valid before creating a new record' do
    it 'rejects the an empty name for group creation' do
      user1 = User.create!(name: 'John Doe')
      group1 = Group.new(name: '', user_id: user1.id)
      expect(group1.valid?).to eq(false)
    end

    it 'validates a new group with a valid name' do
      user1 = User.create!(name: 'John Doe')
      group1 = Group.new(name: 'Beverages', user_id: user1.id)
      expect(group1.valid?).to eq(true)
    end

    it 'rejects the creation of a new group with a repeated name' do
      user1 = User.create!(name: 'John Doe')
      Group.create(name: 'Beverages', user_id: user1.id)
      group1 = Group.new(name: 'Beverages', user_id: user1.id)
      group1.valid?
      expect(group1.errors.full_messages).to eq(['Name has already been taken'])
    end

    it 'rejects the creation of a new group without an assigned user' do
      group1 = Group.new(name: 'Beverages')
      expect(group1.valid?).to eq(false)
    end

    it 'rejects the creation of a new group if the icon url is not an image' do
      user1 = User.create!(name: 'John Doe')
      group1 = Group.new(name: 'Test', user_id: user1.id, icon: 'https://www.google.com/')
      group1.valid?
      expect(group1.errors.full_messages).to eq(['Icon is not a valid image'])
    end

    it 'validates the creation of a new group if the icon url is a valid image' do
      user1 = User.create!(name: 'John Doe')
      group1 = Group.new(name: 'Test', user_id: user1.id, icon: 'https://cdn.iconscout.com/icon/free/png-256/ruby-226055.png')
      expect(group1.valid?).to eq(true)
    end
  end

  it 'deletes a group' do
    user1 = User.create!(name: 'John Doe')
    group1 = Group.create!(name: 'Test', user_id: user1.id)
    group1.delete
    expect(Group.all.count).to eq(0)
  end

  describe 'checks if the group arguments are valid before updating an existing record' do
    it 'rejects the an empty name for group updating' do
      user1 = User.create!(name: 'John Doe')
      group1 = Group.create!(name: 'Test', user_id: user1.id)
      group1.update(name: '')
      expect(group1.valid?).to eq(false)
    end

    it 'rejects the an empty user_id for group updating' do
      user1 = User.create!(name: 'John Doe')
      group1 = Group.create!(name: 'Test', user_id: user1.id)
      group1.update(user_id: '')
      expect(group1.valid?).to eq(false)
    end

    it 'rejects the an invalid icon url for group updating' do
      user1 = User.create!(name: 'John Doe')
      group1 = Group.create!(name: 'Test', user_id: user1.id)
      group1.update(icon: 'https://www.google.com/')
      expect(group1.errors.full_messages).to eq(['Icon is not a valid image'])
    end

    it 'validates a group updating with valid inputs' do
      user1 = User.create!(name: 'John Doe')
      group1 = Group.create!(name: 'Test', user_id: user1.id)
      user2 = User.create!(name: 'John Smith')
      group1.update(name: 'Another Test', user_id: user2.id, icon: 'https://cdn.iconscout.com/icon/free/png-256/ruby-226055.png')
      expect(group1.valid?).to eq(true)
    end
  end

  context 'as a collection for User model' do
    describe 'checks if the group arguments are valid before creating a new record' do
      it 'rejects the an empty name for group creation' do
        user1 = User.create!(name: 'John Doe')
        group1 = user1.groups.build(name: '')
        expect(group1.valid?).to eq(false)
      end

      it 'validates a new group with a valid name' do
        user1 = User.create!(name: 'John Doe')
        group1 = user1.groups.build(name: 'Beverages')
        expect(group1.valid?).to eq(true)
      end

      it 'rejects the creation of a new group with a repeated name' do
        user1 = User.create!(name: 'John Doe')
        user1.groups.create(name: 'Beverages')
        group1 = user1.groups.build(name: 'Beverages')
        group1.valid?
        expect(group1.errors.full_messages).to eq(['Name has already been taken'])
      end
    end

    it 'accesses all the groups associated to a user' do
      user1 = User.create!(name: 'John Doe')
      user1.groups.create(name: 'Beverages')
      user1.groups.create(name: 'Dairy')
      expect(user1.groups.count).to eq(2)
    end
  end

  context 'as a collection for Grocery model' do
    describe 'checks if the group arguments are valid before creating a new record' do
      it 'rejects the an empty name for group creation' do
        user1 = User.create!(name: 'John Doe')
        grocery1 = user1.groceries.create(name: 'Tomatoes', amount: 4, unit: 'kg')
        group1 = grocery1.groups.build(user_id: user1.id)
        expect(group1.valid?).to eq(false)
      end

      it 'validates a new group with a valid name' do
        user1 = User.create!(name: 'John Doe')
        grocery1 = user1.groceries.create(name: 'Tomatoes', amount: 4, unit: 'kg')
        group1 = grocery1.groups.build(name: 'Vegetables', user_id: user1.id)
        expect(group1.valid?).to eq(true)
      end

      it 'rejects the creation of a new group with a repeated name' do
        user1 = User.create!(name: 'John Doe')
        user1.groups.create(name: 'Vegetables')
        grocery1 = user1.groceries.create(name: 'Tomatoes', amount: 4, unit: 'kg')
        group1 = grocery1.groups.build(name: 'Vegetables', user_id: user1.id)
        group1.valid?
        expect(group1.errors.full_messages).to eq(['Name has already been taken'])
      end
    end
  end
end
