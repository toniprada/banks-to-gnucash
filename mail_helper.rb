require 'mailgun'
require_relative './config'

module BankReport
  # :nodoc:
  class MailHelper
    def initialize
      @client = Mailgun::Client.new Config::MAILGUN_API_KEY
    end

    def send(month, attachment_str)
      send_mail(Config::EMAIL_FROM, Config::EMAIL_TO, attachment_str, month)
    end

    private

    def send_mail(from, to, attachment_str, month)
      file = Tempfile.new('temp-file')
      file.write(attachment_str)
      file.rewind
      mb = message_builder(from, to, file.path, month)
      @client.send_message Config::EMAIL_DOMAIN, mb
      file.unlink
    end

    def message_builder(from, to, file_path, month)
      mb = Mailgun::MessageBuilder.new
      mb.from(from)
      mb.add_recipient(:to, to)
      mb.subject("Bank report - #{month}")
      mb.body_text('CSV attached')
      mb.add_attachment(file_path, "bank-report-#{month}.csv")
      mb
    end
  end
end
