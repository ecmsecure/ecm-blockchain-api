# ECM Blockchain API

Client library to connect and transact with your [ECM Blockchain network](https://www.ecmsecure.com) and Certificate Authorities.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ecm_blockchain_api'
```

And then execute:

    $ bundle install

Or install through a CLI with:

    $ gem install ecm_blockchain_api

## Usage
Configure the library by initializing it with your access token.

```ruby
ECMBlockchain.access_token = 'abc'
```

Or create a Rails initializer file `ecm_api.rb`

```ruby
# file: config/initializers/ecm_api.rb

require 'ecm_blockchain_api'

ECMBlockchain.access_token = ENV['ECM_ACCESS_TOKEN']
```

Change the default production base_url
```ruby
ECMBlockchain.base_url = "https://sandbox.ecmsecure.com/v1"
```

## Interact with your Certificate Authority

```ruby
# Register and enroll member on the Certificate Authority
@member = ECMBlockchain::CA.create(
  uuid: "user@org1.example.com",
  secret: "s3cr3t!",
  customAttributes: [
    {
      name: "verified",
      value: "true"
    }
  ]
)

# Retrieve a member by UUID
member = ECMBlockchain::CA.retrieve("user@org1.example.com")
member.custom_attributes

# Update a member
custom_attributes = [{ name: "verified", value: "false" }]
ECMBlockchain::CA.update(identity, custom_attributes)

# Delete a member
ECMBlockchain::CA.delete("user@org1.example.com")
```

```ruby
# Create an Asset on the blockchain
@asset = ECMBlockchain::Asset.create(
  'creator_identity',
  {
    uuid: "823737e4-bdc4-401a-b309-ef4c4d4f4733",
    groupId: "contract-bdc4-401a",
    title: "signable contract",
    summary: "updated asset",
    owner: "owner_identity",
    file: {
      identifier: "fb77d3e2-03a7-4de0-b571-957dd146edf8",
      base64: "data:@file/pdf;base64,JVBERi0xLjQKJdPr6eEKMSAwIG9iago8PC9D...",
      storage: true,
      digitallySigned: {
        standard: "simple",
        signatureType: "certification",
      } 
    },
    content: {
      unit_type: 'PU',
      unit_id: 'TY23737e4-bdc4-401a-b309-ef4c4d4f4733',
      date_purchased: '10th Jan 2025 09:02:41'
    }
  }
)

# Retrieve an Asset by UUID
@asset = ECMBlockchain::Asset.retrieve("823737e4-bdc4-401a-b309-ef4c4d4f4733")
@asset.title
```

```ruby
# mint tokens
@tokens = ECMBlockchain::Tokens.create(
  'creator_identity',
  {
    kind: "CarbonCoins",
    quantity: 100
  }
)

# Burn tokens
@tokens = ECMBlockchain::Tokens.burn(
  'owner_identity',
  {
    kind: "CarbonCoins",
    quantity: 100
  }
)


# Retrieve tokens
@tokens = ECMBlockchain::Tokens.retrieve(
  'owner_identity',
  kind # defaults to 'all'
)

# returns ECMBlockchain::TokensCollection

@tokens.first.kind
@tokens.first.quanitity
@tokens.first.owner
@tokens.first.transferee
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ecm_blockchain_api.
