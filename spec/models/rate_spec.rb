describe Rate do
  subject { Rate.new }

  it { is_expected.to respond_to(:from) }
  it { is_expected.to respond_to(:to) }
  it { is_expected.to respond_to(:conversion) }

  before(:all) do
    @sample_data = [
     ['from', "AUD"],
     ['to', "USD"],
     ['currency', '1.029']
    ]
    @rate = subject.parse_from_result(@sample_data)
  end

  describe :parse_from_result do
    it 'should return a rate object' do
      expect(@rate).to be_a(subject)
    end

    it 'should return right attributes' do
      expect(@rate.from).to eq(@sample_data[0][1])
      expect(@rate.to).to eq(@sample_data[1][1])
      expect(@rate.conversion).to eq(@sample_data[2][1])
    end
  end
end