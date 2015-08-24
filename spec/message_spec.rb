describe 'Messaging' do
  let(:user) { users(:logan) }

  before do
    Mercurius::Testing::Base.reset
  end

  it 'sends the message via GCM' do
    TestMessage.new.send_to user
    delivery = Mercurius::Testing::Base.deliveries[0]
    expect(delivery.notification.data['notification']['body']).to eq 'This is an alert'
    expect(delivery.notification.data['data']).to eq Hash['data' => 123]
    expect(delivery.device_tokens[0]).to eq 'logan123'
  end

  it 'sends the message with content-available set to 1' do
    message = TestMessage.new
    allow(message).to receive(:content_available?) { true }
    message.send_to user
    delivery = Mercurius::Testing::Base.deliveries[0]
    expect(delivery.notification.data['content-available']).to eq true
  end

  it 'does not include content-available by default' do
    TestMessage.new.send_to user
    delivery = Mercurius::Testing::Base.deliveries[0]
    expect(delivery.notification.data['content-available']).to be_nil
  end
end
