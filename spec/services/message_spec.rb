describe 'Messaging' do
  let(:user) { users(:logan) }

  before do
    Mercurius::Testing::Base.reset
  end

  context 'GCM' do
    it 'sends the message via GCM' do
      TestMessage.new.send_to user
      delivery = Mercurius::Testing::Base.deliveries[0]
      expect(delivery.notification.data['alert']).to eq 'This is an alert'
      expect(delivery.notification.data['data']).to eq Hash['data' => 123]
      expect(delivery.device_tokens[0]).to eq 'logan123'
    end

    it 'sends the message via GCM and ActiveRecord::Relation' do
      TestMessage.new.send_to User.all
      delivery = Mercurius::Testing::Base.deliveries[0]
      expect(delivery.device_tokens[0]).to eq 'logan123'
    end
  end

  context 'APNS' do
    before do
      Pushable::Device.all.each { |d| d.update platform: 'ios' }
    end

    it 'sends the message via APNS' do
      TestMessage.new.send_to user
      delivery = Mercurius::Testing::Base.deliveries[0]
      expect(delivery.notification.alert).to eq 'This is an alert'
      expect(delivery.notification.other).to eq Hash['data' => 123]
      expect(delivery.device_tokens[0]).to eq 'logan123'
    end

    it 'sends the message via APNS and ActiveRecord::Relation' do
      TestMessage.new.send_to User.where(email: 'loganserman@gmail.com')
      delivery = Mercurius::Testing::Base.deliveries[0]
      expect(delivery.device_tokens.size).to eq 1
      expect(delivery.device_tokens[0]).to eq 'logan123'
    end

    it 'sends the message via APNS and ActiveRecord::Relation (multiple)' do
      TestMessage.new.send_to User.all
      delivery = Mercurius::Testing::Base.deliveries[0]
      expect(delivery.device_tokens.size).to eq 2
      expect(delivery.device_tokens[0]).to eq 'logan123'
      expect(delivery.device_tokens[1]).to eq 'john123'
    end
  end

  context 'Both' do
    it 'sends one message to APNS and another to GCM' do
      pushable_devices(:logan).update! platform: 'ios'
      pushable_devices(:john).update! platform: 'android'
      TestMessage.new.send_to User.all
      expect(Mercurius::Testing::Base.deliveries[0].device_tokens[0]).to eq 'john123'
      expect(Mercurius::Testing::Base.deliveries[1].device_tokens[0]).to eq 'logan123'
    end
  end
end
