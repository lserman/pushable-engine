describe Pushable::Console do
  let(:console) { Pushable::Console }

  it 'adds the stubs to the console' do
    expect(console.stubs).to be_empty
    console << Pushable::Stub.new(nil, test1: :string, test2: :integer)
    expect(console.stubs.size).to eq 1
  end

end
