module LoginUser
  def sign_in(user)
    visit root_path
    click_link "Sign in"
    fill_in "Email address", with: user.email_address
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end

RSpec.configure do |config|
  config.include LoginUser
end
