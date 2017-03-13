require_relative './bank_helper'
require_relative './mail_helper'

def format_transactions(transactions)
  transactions.map do |t|
    [t[1].effective_date.to_s, t[1].description, t[1].amount,
     t[1].amount.currency.to_s, t[0], t[1].balance]
  end
end

month = Date.today.prev_month
transactions = BankReport::BankHelper.new.month_transactions(month)
csv_string = CSV.generate do |csv|
  csv << %w(effective_date description amount currency account_name balance)
  format_transactions(transactions).each { |t| csv << t }
end
BankReport::MailHelper.new.send(month.strftime('%B'), csv_string)
