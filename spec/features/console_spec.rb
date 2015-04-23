describe 'Console' do

  class TestPush < Pushable::Message
    attr_accessor :string, :integer, :record

    def initialize(string, integer, record)
      @string, @integer, @record = string, integer, record
    end

    def alert
      'TEST'
    end

    def other
      { string: string, integer: integer, record: record.id }
    end
  end

  before do
    Pushable::Console.reset
    Pushable::Console << Pushable::Stub.new(TestPush, string: :string, integer: :integer, record: :activerecord)
  end

  it 'sends a push to the token specified' do
    visit pushable_path
    fill_in 'console_push_device_token', with: 'logan123'
    fill_in 'console_push_TestPush_data_string_value', with: 'string'
    fill_in 'console_push_TestPush_data_integer_value', with: '123'
    select 'TestPush', from: 'console_push_klass'
    click_button 'Push'
    expect(page).to have_content 'Push delivered'
    expect(page).to have_content 'sent to 1 recipient'
    delivery = Mercurius::Testing::Base.deliveries[0]
    expect(delivery.notification.data['alert']).to eq 'TEST'
    expect(delivery.notification.data['data']['string']).to eq 'string'
    expect(delivery.notification.data['data']['integer']).to eq 123
  end

  it 'shows an error when device token is blank' do
    visit pushable_path
    select 'TestPush', from: 'console_push_klass'
    click_button 'Push'
    expect(page).to have_content "Push failed! Device token can't be blank"
  end

  it 'shows an error when message isnt chosen' do
    visit pushable_path
    fill_in 'console_push_device_token', with: 'logan123'
    click_button 'Push'
    expect(page).to have_content "Push failed! Klass can't be blank."
  end
end
