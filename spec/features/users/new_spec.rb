# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New User' do
  before :each do
    @eldridge = User.create!(name: 'Eldridge', email: 'eldridge@gmail.com', password: 'pass123', password_confirmation: 'pass123')
    @kevin = User.create!(name: 'Kevin', email: 'kevin@gmail.com', password: 'pass123', password_confirmation: 'pass123')
    @suzie = User.create!(name: 'Suzie', email: 'suzieq@gmail.com', password: 'pass123', password_confirmation: 'pass123')
  end

  it 'should be have a button from the landing page' do
    visit root_path

    click_link 'Create New User'

    expect(current_path).to eq(new_user_path)
  end

  it 'can create a new user with valid input' do
    visit new_user_path

    fill_in(:user_name, with: 'John')
    fill_in(:user_email, with: 'john@gmail.com')
    fill_in(:user_password, with: 'pass123')
    fill_in(:user_password_confirmation, with: 'pass123')
    click_button 'Create User'

    user = User.find_by(name: 'John')
    expect(current_path).to eq(user_path(user))
    expect(page).to have_content(user.name)
  end

  it 'has a sad path for invalid data' do
    visit new_user_path

    fill_in(:user_name, with: 'John')
    fill_in(:user_email, with: 'johnnyboy')
    fill_in(:user_password, with: 'pass123')
    fill_in(:user_password_confirmation, with: 'pass123')
    click_button 'Create User'

    user = User.find_by(name: 'John')

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content(['Email is invalid'])
  end

  it 'has a link to the landing page' do
    visit new_user_path

    click_link 'Home'

    expect(current_path).to eq(root_path)
  end

  it 'sees a form to register a user account' do
    visit '/'

    click_on 'Create New User'

    fill_in(:user_name, with: 'richie')
    fill_in(:user_email, with: 'richieboy@gmail.com')
    fill_in(:user_password, with: 'pass123')
    fill_in(:user_password_confirmation, with: 'pass123')
    click_button 'Create User'

    user = User.find_by(name: 'richie')

    expect(current_path).to eq(user_path(user))
  end

  describe 'sad paths' do
    it 'has a sad path for invalid email' do
      visit new_user_path

      fill_in(:user_name, with: 'richie')
      fill_in(:user_email, with: 'richieman')
      fill_in(:user_password, with: 'pass123')
      fill_in(:user_password_confirmation, with: 'pass123')
      click_button 'Create User'


      expect(current_path).to eq(new_user_path)
      expect(page).to have_content(['Email is invalid'])
    end

    it 'has a sad path for a non unique email' do
      visit new_user_path

      fill_in(:user_name, with: 'richie')
      fill_in(:user_email, with: 'eldridge@gmail.com')
      fill_in(:user_password, with: 'pass123')
      fill_in(:user_password_confirmation, with: 'pass123')
      click_button 'Create User'


      expect(current_path).to eq(new_user_path)
      expect(page).to have_content(['Email has already been taken'])
    end

    it 'has sad path for mismatched passwords' do
      visit new_user_path

      fill_in(:user_name, with: 'richie')
      fill_in(:user_email, with: 'richieman@gmail.com')
      fill_in(:user_password, with: 'pass123')
      fill_in(:user_password_confirmation, with: 'pass12')
      click_button 'Create User'


      expect(current_path).to eq(new_user_path)
      expect(page).to have_content(["Password confirmation doesn't match Password"])
    end

    it 'has sad path for the name being blank' do
      visit new_user_path

      fill_in(:user_name, with: '')
      fill_in(:user_email, with: 'richieman@gmail.com')
      fill_in(:user_password, with: 'pass123')
      fill_in(:user_password_confirmation, with: 'pass12')
      click_button 'Create User'

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Name can't be blank")
    end

    it 'has sad path for name missing' do
      visit new_user_path

      fill_in(:user_email, with: 'richieman@gmail.com')
      fill_in(:user_password, with: 'pass123')
      fill_in(:user_password_confirmation, with: 'pass12')
      click_button 'Create User'

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Name can't be blank")
    end
  end

  it 'sees a form to login a user account' do
    visit '/'

    click_on 'Log In'
    expect(current_path).to eq('/login')
    fill_in :email, with: 'eldridge@gmail.com'
    fill_in(:password, with: 'pass123')
    click_button 'Log In'

    user = User.find_by(name: 'Eldridge')

    expect(current_path).to eq(user_path(user))
  end
end
