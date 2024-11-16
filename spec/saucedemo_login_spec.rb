# frozen_string_literal: true

require 'selenium-webdriver'
require 'capybara/rspec'
require_relative 'spec_helper'

RSpec.describe 'Login error checks on SauceDemo' do
  include Capybara::DSL

  before(:each) do
    visit 'https://www.saucedemo.com'
  end

  users = [
    { username: 'error_user', password: 'secret_sauce' },
    { username: 'locked_out_user', password: 'secret_sauce' }
  ]

  users.each do |user|
    it "should not allow #{user[:username]} to log in" do
      fill_in 'user-name', with: user[:username]
      fill_in 'password', with: user[:password]
      click_button 'Login'

      # Перевірка повідомлення про помилку
      error_message = find('.error-message-container')
      expect(error_message.text).to include 'Epic sadface:'
    end
  end
end
