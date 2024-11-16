# frozen_string_literal: true

require 'selenium-webdriver'
require 'capybara/rspec'
require_relative 'spec_helper'

RSpec.describe 'Add items to cart on SauceDemo' do
  include Capybara::DSL

  before(:each) do
    visit 'https://www.saucedemo.com'
  end

  it 'adds two items to the cart and verifies the count' do
    # Вхід в систему
    fill_in 'user-name', with: 'standard_user'
    fill_in 'password', with: 'secret_sauce'
    click_button 'Login'

    # Додавання першого товару
    find('.inventory_item:nth-child(1) .btn_inventory').click

    # Додавання другого товару
    find('.inventory_item:nth-child(2) .btn_inventory').click

    # Перевірка лічильника кошика
    cart_badge = find('.shopping_cart_badge')
    expect(cart_badge.text).to eql '2'
  end
end
