require_relative './bank_helper'
require_relative './mail_helper'

def format_transactions(transactions)
  transactions.map do |tx|
    [tx.effective_date.to_s, tx.description, tx.amount, tx.amount.currency.to_s, tx.balance]
  end
end

csvs = {}
accounts = BankReport::BankHelper.new.accounts_last_quarter_transactions
accounts.each do |name, transactions|
  csvs[name] = CSV.generate do |csv|
    format_transactions(transactions).each { |t| csv << t }
  end
end
BankReport::MailHelper.new.send(csvs)
