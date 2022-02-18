# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do
    @eldridge = User.create!(name: 'Eldridge', email: 'eldridge@gmail.com', password_digest: 'pass123')
    @kevin = User.create!(name: 'Kevin', email: 'kevin@gmail.com', password_digest: 'pass123')
    @suzie = User.create!(name: 'Suzie', email: 'suzieq@gmail.com', password_digest: 'pass123')
  end

  it 'should list out all users' do
    visit root_path

    expect(page).to have_content(@eldridge.name)
    expect(page).to have_content(@kevin.name)
    expect(page).to have_content(@suzie.name)
  end

  it 'has a link to the landing page' do
    visit root_path

    click_link 'Home'

    expect(current_path).to eq(root_path)
  end
end
