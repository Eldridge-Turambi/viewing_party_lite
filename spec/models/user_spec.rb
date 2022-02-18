# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  before :each do
    @eldridge = User.create!(name: 'Eldridge', email: 'eldridge@gmail.com', password: 'pass123', password_confirmation: 'pass123')
    @kevin = User.create!(name: 'Kevin', email: 'kevin@gmail.com', password: 'pass123', password_confirmation: 'pass123')
    @suzie = User.create!(name: 'Suzie', email: 'suzieq@gmail.com', password: 'pass123', password_confirmation: 'pass123')
  end

  describe 'relationships' do
    it { should have_many(:party_users) }
    it { should have_many(:parties).through(:party_users) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email) }
    it { should have_secure_password }
    it { should validate_presence_of(:password_digest)}
  end

  describe '#methods' do
    it 'except_user' do
      users = User.except_user(@kevin.id)

      expect(users).to eq([@eldridge, @suzie])
    end
  end
end
