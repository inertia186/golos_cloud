# GolosCloud

[![Gem Version](https://badge.fury.io/rb/golos_cloud.svg)](https://badge.fury.io/rb/golos_cloud)

### How To Use (Rails 4+)
- Add Gem to Gemfile
	*	`gem 'golos_cloud', '~> 1.0'`
- Bundle Install Gems
	* `bundle install`

### How To Use (Standalone)
- `gem install golos_cloud`
- `irb`
- `require 'golos_cloud'`
- `GolosCloud::Comment.last`

### Models
- Account
- Block
- Comment
- Token
- Transaction

### Followers

How to query today's followers:

```ruby
followers = GolosCloud::Tx::Custom::Follow
followers.following(:ned).today.count
```

### Resteem

How to query today's "resteems":

```ruby
reblogs = GolosCloud::Tx::Custom::Reblog
reblogs.author(:netuoso).today.count
```

### Account Witness Proxy

How to query current accounts that are actively using a proxy:

```ruby
proxied = GolosCloud::Tx::AccountWitnessProxy.active('netuoso')
proxied.pluck(:account)
```

### Appiations

How to query comments by application:

```ruby
comments = GolosCloud::Comment.app('esteem').where(author: 'good-karma')
```

### How To Contribute
- Fork this repo
- Branch off Master and make your changes
- Submit a PR to this repo's Master branch

### License
- [WTFPL](LICENSE.txt)
