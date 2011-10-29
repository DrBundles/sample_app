require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do
    
      it "should not make a new user" do
        lambda do # Use lambda to wrap all the user signup steps
                  # into a single test block to check that the failed
                  # signup test does not add a user to the database
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Password Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
      
    end #describe "failure"

    describe "success" do

      it "should make a new user" do
        lambda do # Use lambda to wrap all the user signup steps
                  # into a single test block to check that the successful 
                  # signup test adds a user to the database
          visit signup_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Password Confirmation", :with => "foobar"
          click_button
          response.should render_template('users/show')
          response.should have_selector("div.flash.success",
                                        :content => "Welcome")
        end.should change(User, :count).by(1)
      end

    end #describe "success"
  
  end #describe "signup"

end #decribe Users
