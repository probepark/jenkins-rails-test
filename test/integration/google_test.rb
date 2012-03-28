require 'rubygems'
require 'capybara/dsl'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'http://www.google.com'

module MyCapybaraTest
  class Test
    include Capybara
    def test_google
      visit('/')
      input "hello"
    end
  end
end

t = MyCapybaraTest::Test.new
t.test_google
