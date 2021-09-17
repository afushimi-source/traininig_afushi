module LoginSupport
  def sign_in_as(user)
    allow_any_instance_of(ActionDispatch::Request)
    .to receive(:session){ { user_id: user.id } }
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
