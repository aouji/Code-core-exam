require 'spec_helper'

def create_and_sign_in(email,pass)
  create :user, email: email, password: pass
  visit '/'
  click_on 'Sign in'
  fill_in "Email", with: email
  fill_in "Password", with: pass
  click_on "Sign in"
end