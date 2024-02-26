# The Organic Software Directory

[How it started](https://posts.cv/taras/7ucKVJsa11hDeMxGjqn7)

### Status: Busted Beta

This thing is just taking it's first steps. We are still missing a few crucial features, and the frontend is not gorgeous. Enjoy!

## What is "Organic Sofware"?

[Coined by @pketh](https://pketh.org/organic-software.html), Organic Software is software that:
1. Is not funded in such a way where the primary obligation of the company is to 🎡 chase funding rounds or get acquired (so bootstrapping, crowdfunding, grants, and angel investment are okay)
2. Have a clear pricing page
3. Disclose their sources of funding and sources of revenue

## OSD Strives to be organic software

It currently doesn't meet the criteria because we haven't figured out sustainable funding. At the moment, the bills are covered by Miniware.

There are a few ideas floating around in discussions though, please weigh in!

## Contributing

Pull requests are welcome and encouraged! Once we have a fair source of revenue, bounties will be posted as well.

In order to keep this project focused and maintainable, not all PRs will be merged.

### Pull requests should...

- Include tests
- Introduce minimal dependencies
- Conform to [standard.rb](https://github.com/standardrb/standard-rails)
- Be excited about discussion

## Running locally:
```
# assuming ruby is installed and up to date, and you've cloned the repo somewhere

$ bundle
$ rails db:setup
$ ./bin/dev
$ open localhost:3000
```

```