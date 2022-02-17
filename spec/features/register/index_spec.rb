require 'rails_helper'

RSpec.describe 'register index page' do

  it 'sees a form to register a user account' do
    visit '/register'
  end
end
