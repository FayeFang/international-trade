class Transaction
  attr_accessor :store, :sku, :amount, :currency
  def self.parse_from_result(result)
    transaction = Transaction.new
    transaction.store = result[0]
    transaction.sku = result[1]
    transaction.amount = result[2].split(" ")[0].to_f
    transaction.currency = result[2].split(" ")[1] ? result[2].split(" ")[1] : nil
    transaction
  end


  def convert_currency(rates, from_currency, to_currency)
    matching_rate = rates.select { |r| r.to == to_currency && r.from == from_currency}
    if matching_rate.any?
      return matching_rate.first.conversion
    else
      updated_from_currencies = rates.select { |r| r.from == from_currency }.compact
      updated_from_currencies.each do |from_currency|
        if !convert_currency(rates, from_currency.to, to_currency).nil?
          return from_currency.conversion * convert_currency(rates, from_currency.to, to_currency)
        end
      end
    end
  end
end