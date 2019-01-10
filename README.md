# banks-to-gnucash

This is a simple script to send me by email a CSV of last quarter transactions. Such CSV is [GnuCash](https://www.gnucash.org/) friendly and can be easily imported to self-manage your personal finances.

The motivation for this project is the need of 1) knowing more about my personal expenses and 2) a better process to organize my freelance taxes (that's the reason for quaterly reports) and 3) mistrust of services that import your bank data and then sell it to other financial providers.

## Customization

This is a personal project so it gets data from the two banks I use: BBVA and ING. Nevertheless it should be really easy to customize, just modify the _BankHelper_ and _Config_ classes to include your choices.

And I use Mailgun as mail provider because they have a free plan <3.

## Thanks

Thanks to the creators of the [bankscrap](https://github.com/bankscrap/bankscrap) gem.
