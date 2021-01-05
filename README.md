# PairingMatrix

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/ajitsing/pairing_matrix/graphs/commit-activity)
[![Gem Version](https://badge.fury.io/rb/pairing_matrix.svg)](https://badge.fury.io/rb/pairing_matrix)
[![HitCount](http://hits.dwyl.io/ajitsing/pairing_matrix.svg)](http://hits.dwyl.io/ajitsing/pairing_matrix)
![Gem Downloads](http://ruby-gem-downloads-badge.herokuapp.com/pairing_matrix?type=total)
[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/MIT)
[![Twitter Follow](https://img.shields.io/twitter/follow/Ajit5ingh.svg?style=social)](https://twitter.com/Ajit5ingh)

<img src="https://github.com/ajitsing/ScreenShots/blob/master/pairing_matrix/pairing_mat.png" width="900" height="550" />

## How to read this matrix?
    1. This matrix is purely based on commits.
    2. Darker the line more the pair has worked together.
    3. If you see a dark red circle around a name that means the person has worked alone

## Installation

Add this line to your application's Gemfile:

    gem 'pairing_matrix'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pairing_matrix

## Usage

First of all you need to decide a format for your commit messages e.g.
#Feature [Dev1/Dev2] Your commit message

You can choose any format as long as you are able to extract dev names from the message using a regex.
Once you have decided on the commit message format, create a ```pairing_matrix.yml``` file.

```yml
authors_regex: ^.*\[([\w]*)(?:\/)?([\w]*)\].*$

github:
  url: https://api.github.com/
  access_token: 000324cgf89weq56132f32c345hn679c0knh501c
  repositories:
    - org1/repo1
    - org1/repo2
    - github_username/my_private_repo
```

#### authors_regex:
This regex is used to extract dev names from the commit message. You can verify your regex in irb console using the below command. If your regex is correct it will return an array of dev names.

e.g
```ruby
"#4324 [Ajit/Abhishek] My commit message".scan(/^.*\[([\w]*)(?:\/)?([\w]*)\].*$/).flatten
=> ["Ajit", "Abhishek"]
```

#### access_token:
If you want to use private repos for matrix, then create a access token and give it the repo read permission. Here is how you can create the token: 

**Github:** https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/

**Gitlab:** https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html

#### repositories:
List your repos which you want to use for matrix. If you have your repos inside organization then follow the ```org/repo``` format else just mention ```username/repo```.


Now after installing the pairing matrix gem, simply run the ```pairing_matrix``` command in the repo where you have ```pairing_matrix.yml``` file. This command will start a web server.
Then hit the url [localhost:4567/matrix](http://localhost:4567/matrix) or [localhost:4567](http://localhost:4567) in the browser. In case you want to use the json data, hit [http://localhost:4567/data/:days](http://localhost:4567/data/30)

# Supported code hosting platforms

Pairing matrix gem supports below platforms:
* Github
* Gitlab
* Local

Support for bitbucket is coming soon!

### Github sample configuration

```yaml
authors_regex: ^.*\[([\w]*)(?:\/)?([\w]*)\].*$

github:
  url: https://api.github.com/
  access_token: 000324cff69wes5613f732c345hn679c0knt509c
  repositories:
    - org1/repo1
    - org1/repo2
    - github_username/my_private_repo
```

**Note: Access token is optional if you are using public repositories.**

### Gitlab sample configuration

```yaml
authors_regex: ^.*\[([\w]*)(?:\/)?([\w]*)\].*$

gitlab:
  url: https://gitlab.com/api/v4
  access_token: G7EmKQs4swhadZn2sd0T
  repositories:
    - username/repo1
    - username/repo2
```

**Note: Add your custom urls if you are using enterprise version of Github or Gitlab.**

### For local repositories

```yaml
authors_regex: ^.*\[([\w]*)(?:\/)?([\w]*)\].*$
local:
  repositories:
    - /Users/Ajit/projects/project1
    - /Users/Ajit/projects/project2
    - /Users/Ajit/projects/project3
```

## Contributing

1. Fork it ( https://github.com/ajitsing/pairing_matrix/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## License
```LICENSE
Copyright (c) 2021 Ajit Singh

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
