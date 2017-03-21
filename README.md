# PairingMatrix

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'pairing_matrix'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pairing_matrix

## Usage

Once you have installed the pairing matrix gem, simply run the pairing_matrix command as shown below and the gem will start the web server. Then hit the url ```localhost:4567/matrix``` in the browser.

```pairing_matrix```

To run the web server successfully, it needs a configuration file with name ```pairing_matrix.yml``` in the same directory where you are running the command.

### Here is a sample pairing_matrix.yml file

```yml
authors_regex: ^.*\[([\w]*)(?:\/)?([\w]*)\].*$
repos:
  - /Users/Ajit/projects/project1
  - /Users/Ajit/projects/project2
  - /Users/Ajit/projects/project3
```

authors_regex is the regex which extracts developers name from the commit message. This regex will depend on the commit message format that you follow in your project.

## Contributing

1. Fork it ( https://github.com/ajitsing/pairing_matrix/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
