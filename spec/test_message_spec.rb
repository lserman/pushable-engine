describe 'Sending a test message' do
  let(:user) { users(:logan) }

  before do
    Mercurius::Testing::Base.reset
  end

  context 'GCM' do
    it 'sends the message via GCM' do
      Pushable::TestMessage.new.send_to user
      delivery = Mercurius::Testing::Base.deliveries[0]
      expect(delivery.notification.data['alert']).to eq 'This is a test push from Pushable'
      expect(delivery.notification.data['data']).to eq Hash.new
      expect(delivery.device_tokens[0]).to eq 'logan123'
    end
  end

  context 'APNS' do
    before do
      Pushable::Device.all.each { |d| d.update platform: 'ios' }
    end

    it 'sends the message via APNS' do
      Pushable::TestMessage.new.send_to user
      delivery = Mercurius::Testing::Base.deliveries[0]
      expect(delivery.notification.alert).to eq 'This is a test push from Pushable'
      expect(delivery.notification.other).to eq Hash.new
      expect(delivery.notification.payload.keys).to_not include 'content-available'
      expect(delivery.device_tokens[0]).to eq 'logan123'
    end
  end
end
