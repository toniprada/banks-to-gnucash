require 'mailgun'
require_relative './config'

module BankReport
  # :nodoc:
  class MailHelper
    def initialize
      @client = Mailgun::Client.new Config::MAILGUN_API_KEY
    end

    def send(csvs)
      send_mail(Config::EMAIL_FROM, Config::EMAIL_TO, csvs)
    end

    private

    def send_mail(from, to, csvs)
      mb = Mailgun::MessageBuilder.new
      mb.from(from)
      mb.add_recipient(:to, to)
      mb.subject("Bank report - #{Date.today.strftime('%B')}")
      mb.body_text('CSVs attached')
      csvs.each do |name, csv|
        add_attachment(mb, name, csv)
      end
      @client.send_message Config::EMAIL_DOMAIN, mb
    end

    def add_attachment(mb, name, content)
      file = Tempfile.new(name)
      file.write(content)
      file.rewind
      mb.add_attachment(file.path, "bank-report-#{name}.csv") # !! name to file friendly
    end
  end
end
