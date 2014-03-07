require 'spec_helper'

feature User do
  feature "should be able to authenticate" do
    scenario "signs up successfully" do
      visit '/'
      click_on 'Sign up'
      fill_in 'Email', with: "arash@ouji.com"
      fill_in "Password", with: "aaaaaaaa"
      fill_in "confirmation", with: "aaaaaaaa"
      click_on "Sign up"
      expect(page).to have_text("arash@ouji.com")
      expect(User).to have(1).record
    end

    scenario "signs in successfully" do
      create_and_sign_in("arash@ouji.com",'aaaaaaaa')
      expect(page).to have_text("arash@ouji.com")
    end

  end
  
  feature "when user is signed in" do

    before do
      create_and_sign_in("arash@ouji.com",'aaaaaaaa')
    end

    scenario "should have his user's email" do
      visit "/"
      expect(page).to have_text("arash@ouji.com")
    end

    scenario "should be able to sign out" do
      visit "/"
      click_on "Sign out"
      expect(page).to have_text("Sign up")
    end

  end
  
end