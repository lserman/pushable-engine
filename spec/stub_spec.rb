describe Pushable::Stub do

  it 'doesnt throw an error when its fine' do
    expect {
      Pushable::Stub.new(nil, test1: :string, test2: :integer)
    }.not_to raise_error
  end

  it 'throws an error if fields arent string or integer' do
    expect {
      Pushable::Stub.new(nil, test1: :string, test2: :invalid)
    }.to raise_error(ArgumentError)
  end

end
