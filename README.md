# PairingMatrix

[![Gem Version](https://badge.fury.io/rb/pairing_matrix.svg)](https://badge.fury.io/rb/pairing_matrix)

![Alt text](https://github.com/ajitsing/ScreenShots/blob/master/pairing_matrix/pairing_mat.png)

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

The above config will fetch data directly from your local repositories.

### Want to fetch private repos data directly from github?

```yml
authors_regex: ^.*\[([\w]*)(?:\/)?([\w]*)\].*$
github_access_token: 000324cff69wes5613f732c345hn679c0knt509c
github_repos:
  - org1/repo1
  - org1/repo2
  - github_username/my_private_repo
```

### Fetching data from public github repos

```yml
authors_regex: ^.*\[([\w]*)(?:\/)?([\w]*)\].*$
github_repos:
  - github_username/my_public_repo1
  - github_username/my_public_repo2
```

authors_regex is the regex which extracts developers name from the commit message. This regex will depend on the commit message format that you follow in your project.

## Contributing

1. Fork it ( https://github.com/ajitsing/pairing_matrix/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## License
```LICENSE
Copyright (c) 2017 Ajit Singh

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
