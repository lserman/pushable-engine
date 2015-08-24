describe DevicesController do
  let!(:user) { User.create email: 'test@testerson.com' }

  it 'creates a new device for a user' do
    post :create, device: { token: 'token123', platform: 'android' }
    expect(user.reload.devices.size).to eq 1
    expect(user.devices[0].token).to eq 'token123'
    expect(user.devices[0].platform).to eq 'android'
  end

  it 'doesnt create a device without a token' do
    post :create, device: { token: '', platform: 'android' }
    expect(user.reload.devices.size).to eq 0
    expect(assigns(:device).errors[:token]).to be_present
  end

  it 'updates the expiration time whenever POSTing the same device token for a user' do
    post :create, device: { token: 'token123', platform: 'android' }
    expiry1 = Pushable::Device.last.token_expires_at.to_s(:nsec)
    post :create, device: { token: 'token123', platform: 'android' }
    expiry2 = Pushable::Device.last.token_expires_at.to_s(:nsec)
    expect(expiry2).to be > expiry1
  end

end
