module LoginSupport
  def sign_in_as(user)
    visit root_path
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_button 'ログイン'
    all('body').map(&:text)
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
