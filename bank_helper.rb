require 'bankscrap-ing'
require 'bankscrap-bbva'
require_relative './config'

module BankReport
  # :nodoc:
  class BankHelper
    def month_transactions(month)
      all_banks_month_transactions(month)
    end

    private

    def all_banks_month_transactions(month)
      txs = bbva_month_transactions(month) + ing_month_transactions(month)
      sort_transactions(txs)
    end

    def bbva_month_transactions(month)
      bank = Bankscrap::BBVA::Bank.new(user: Config::BBVA_USER,
                                       password: Config::BBVA_PASSWORD)
      bank_month_transactions(bank, month)
    end

    def ing_month_transactions(month)
      bank = Bankscrap::ING::Bank.new(dni: Config::ING_USER,
                                      password: Config::ING_PASSWORD,
                                      birthday: Config::ING_BIRTHDATE)
      bank_month_transactions(bank, month)
    end

    def bank_month_transactions(bank, month)
      transactions = []
      bank.accounts.each do |account|
        ts = account.fetch_transactions(start_date: month.at_beginning_of_month,
                                        end_date:   month.at_end_of_month)
        transactions += ts.map { |t| [account.name, t] }
      end
      transactions
    end

    def sort_transactions(transactions)
      transactions.sort { |a, b| a[1].effective_date <=> b[1].effective_date }
    end
  end
end
