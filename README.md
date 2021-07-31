# BnmRates

Gem for get exchange rates from BNM.md

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bnm_rates'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bnm_rates

## Usage
To return char_codes array
```ruby
bnm = BnmRates.new(date: :'12.12.2012', lang: :en)
char_codes = bnm.char_codes #=>[:EUR, :MDL, :USD, .......]
```
By default 
```ruby 
date = Time.now.strftime("%d.%m.%Y")```, ```lang = :en```

Get hashed information about certain valute, use:
```valute = BnmRates.new.USD  #=> {:id=>44, :num_code=>"840", :char_code=>"USD", :nominal=>1, :name=>"US Dollar", :value=>17.9234, :rate=>17.9234} 
```

Use keys for valute instance to get needed info:
```ruby
valute = BnmRates.new.USD[:rate]```

Disponible keys: 
```ruby
:num_code```,```:char_code```, ```:nominal```, ```:name```, ```:value```, ```:rate```.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ritartha017/bnm_rates.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
