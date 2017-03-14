# personal-bank-report

This project sends me a **monthly email with a CSV of all my bank transactions**, no matter the bank they come from.

The motivation for this project is to be able to manage my personal economy without having to put up with multiple bank accounts, disastrous webpages, unusable apps and infamius file types. Now I get a monthly email with all my expenses and income sources together. That's a win!

## Customization

Because it is a personal project it gets data from the two banks I use: BBVA and ING. Nevertheless it should be really easy to customize, just modify the _BankHelper_ and _Config_ classes to include your choices.

And I use Mailgun as mail provider because they have a free plan.

## Heroku

If you decide to host this project at Heroku (I do) you will face the inflexibility of the _Heroku Scheduler_ add-on.
But [there is a cool trick to set monthly tasks](https://blog.dbrgn.ch/2013/10/4/heroku-schedule-weekly-monthly-tasks/):

```if [ "$(date +%d)" = 01 ]; then ruby script.rb; fi```

## Thanks

Thanks to [Javier Cuevas](https://github.com/javiercr) and [Raúl Marcos](https://github.com/raulmarcosl) for their awesome [bankscrap](https://github.com/bankscrap/bankscrap) gem.
