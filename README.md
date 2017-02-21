# Arb::Thread

A simple "thread pool" for parallel tasks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arb-thread'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arb-thread

## Usage

To illustrate, let's take the example of "The Ticket model".

```ruby
 require 'arb/thread'

 #Generate "ticket"s here.
 source=(1..8000).to_a.map{|i| "ticket - #{i}"}

 #Use 30 ticket windows to sell tickets in parallel(30 threads in fact).
 Thread.parallel(30) do |dispatcher|
   10000.times do
     dispatcher.new_task do |lock|
       #The lock is a just a Mutex instance stored in dispatcher for handy usage.
       #You can use an external Mutex to synchronize if you like.
       lock.synchronize do
         #Sell ticket here.
         puts source.pop
       end
       sleep 3+rand(3)
     end
   end

 end
```

For detailed usage, run

    $ gem unpack arb-thread

and dig into the class Arb::Thread::TaskDispatcher.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arybin/arb-thread.

