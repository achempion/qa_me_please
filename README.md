# QaMePlease

This tool created to automate process of shipping PRs to QA team.

### How it works

You need to modify configuration on your own needs and run

```ruby
QaMePlease.publish!
```

You can run it manually via console or employ custom rake task on it.


After that this tool fulfill next steps

1) forking current branch to `testing`

2) merge all PRs with `testing` label to `testing` branch

3) force push `testing` branch to the origin

That's all, happy coding.

### Configuration

```ruby
QaMePlease.configure do |config|
 #
 # required
 # :username is github username
 # :token is github access token for that user
 #

 config.repo_access_key = ':username/:token'
 config.repo = 'achempion/qa_me_please'

 #
 # optional
 #

 config.qa_branch = 'testing' # testing by default
 config.qa_label = 'testing' # testing by default

end
```

Please, be sure that your current branch haven't unstaged changes.
Push them to origin before start.

### Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/achempion/qa_me_please.


### License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

