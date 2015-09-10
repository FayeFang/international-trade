%w(nokogiri csv bigdecimal).each { |gem| require gem }

%w(helpers models).each do |folder|
  Dir[File.join(Dir.pwd, folder, '/*.rb')].each do |file|
    require_relative file
  end
end

trans_csv_path = File.join(Dir.pwd, '../data/trans/TRANS.csv')
transactions = TransactionsReader.read_transactions(trans_csv_path)
targeted_transactions = transactions.select { |transaction| transaction.sku == 'DM1182'}

rates_xml_path = File.join(Dir.pwd, '../data/rates/RATES.xml')
rates = RatesReader.read_rates(rates_xml_path)

grand_total = targeted_transactions.inject(0.00) do |sum, t|
  if t.currency = "USD"
    sum += t.amount
  else
    sum += (t.amount * t.convert_currency(rates, t.currency, 'USD')).round(2)
  end
  sum.round(2)
end

puts grand_total.inspect