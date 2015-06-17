require 'rails_helper'

feature 'User signs in' do
  
  before(:each) do
    create(:user)
  end

  scenario 'with valid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: 'hsaini734@gmail.com'
    fill_in 'Password', with: '12345678' 
    click_on 'Sign in'

    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'with invalid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: 'abc@gmail.com'
    fill_in 'Password', with: '12345678' 
    click_on 'Sign in'

    expect(page).to have_content('Invalid email or password.')
  end
end
