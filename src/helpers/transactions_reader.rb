module TransactionsReader
  def self.read_transactions(trans_csv_path)
    transactions = CSV.read(trans_csv_path)

    results = transactions.inject([]) do |sum, transaction|
      sum << Transaction.parse_from_result(transaction)
    end

    results
  end
end