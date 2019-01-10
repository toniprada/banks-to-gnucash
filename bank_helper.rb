require 'bankscrap-ing'
require 'bankscrap-bbva'
require_relative './config'

module BankReport
  # :nodoc:
  class BankHelper

    def accounts_last_quarter_transactions
      bbva = bbva_accounts_last_quarter_transactions
      ing = ing_accounts_last_quarter_transactions
      bbva.merge(ing)
    end

    private

    def ing_accounts_last_quarter_transactions
      bank = Bankscrap::ING::Bank.new(dni: Config::ING_USER,
                                password: Config::ING_PASSWORD,
                                birthday: Config::ING_BIRTHDATE)
      bank_accounts_last_quarter_transactions(bank)
    end

    def bbva_accounts_last_quarter_transactions
      bank = Bankscrap::BBVA::Bank.new(user: Config::BBVA_USER,
                                          password: Config::BBVA_PASSWORD)
      bank_accounts_last_quarter_transactions(bank)
    end

    def bank_accounts_last_quarter_transactions(bank)
      from = 3.months.ago.beginning_of_month
      to = 1.months.ago.end_of_month
      bank_accounts_transactions(bank, from, to)
    end

    def bank_accounts_transactions(bank, from, to)
      txs = {}
      bank.accounts.each do |account|
        txs[account.name] = account.fetch_transactions(start_date: from, end_date: to)
      end
      txs
    end

  end
end
