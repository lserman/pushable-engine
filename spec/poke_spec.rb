describe 'Sending a test message' do
  let(:user) { users(:logan) }

  before do
    Mercurius::Testing::Base.reset
  end

  context 'GCM' do
    it 'sends the message via GCM' do
      Pushable::Poke.new.send_to user
      delivery = Mercurius::Testing::Base.deliveries[0]
      expect(delivery.notification.data['alert']).to eq 'This is a test push from Pushable'
      expect(delivery.notification.data['data']).to eq Hash.new
      expect(delivery.device_tokens[0]).to eq 'logan123'
    end
  end
end
