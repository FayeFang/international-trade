describe Transaction do
  subject { Transaction.new }

  it { is_expected.to respond_to(:store) }
  it { is_expected.to respond_to(:sku) }
  it { is_expected.to respond_to(:amount) }
  it { is_expected.to respond_to(:currency) }

  before(:all) do
    @sample_data = [
     'Utica', 'DM1759', '84.16 CAD'
    ]
    @transaction = subject.parse_from_result(@sample_data)
  end

  describe :parse_from_result do
    it 'should return a rate object' do
      expect(@transaction).to be_a(subject)
    end

    it 'should return right attributes' do
      expect(@transaction.store).to eq(@sample_data[0])
      expect(@transaction.sku).to eq(@sample_data[1])
      expect(@transaction.amount).to eq(@sample_data[2].split(" ")[0].to_f)
      expect(@transaction.currency).to eq(@sample_data[2].split(" ")[1])
    end
  end
end