class TestMessage < Pushable::Message

  def alert
    'This is an alert'
  end

  def badge
    2
  end

  def sound
    'test'
  end

  def data
    { data: 123 }
  end

end
