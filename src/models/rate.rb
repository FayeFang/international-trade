class Rate
  attr_accessor :from, :to, :conversion
  def self.parse_from_result(result)
    rate = Rate.new
    rate.from = result[0][1]
    rate.to = result[1][1]
    rate.conversion = result[2][1] ? result[2][1].to_f : nil
    rate
  end
end
