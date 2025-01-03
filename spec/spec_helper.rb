# frozen_string_literal: true

require 'capybara'
require 'rspec'

RSpec.configure do |config|
  config.add_formatter 'documentation'
  config.add_formatter 'html', 'results.html'

  config.after(:each) do |example|
    if example.exception
      Dir.mkdir('screenshots') unless Dir.exist?('screenshots')

      time = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
      filename = "screenshots/#{time}_#{example.description.gsub(' ', '_')}.png"
      page.save_screenshot(filename) # для збереження скріншотів у разі помилок
    end
  end
end

Capybara.default_driver = :selenium
