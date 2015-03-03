# Pushable

This project maintains a `Pushable::Device` model and facilitates the delivery of push notifications for iOS and Android.

## Installation

```
gem 'pushable-engine'
bundle
bin/rails g pushable:install:migrations
bin/rake db:migrate
```

This will copy the `pushable_devices` table into your project.

## Setup

Include `Pushable::Model` into your User model. This will attach the `has_many` relationship you need with `Pushable::Device`:

```ruby
class User
  include Pushable::Model
  # ...
end
```

Create a Devices controller where you need it, most likely an API. The controller itself will be generated within your application so that
Pushable does not make any assumptions about your method of authentication, `respond_with` mimetypes, etc. The only requirement is that `current_user`
exists.

Here's an example of getting setup with an API Devices controller that mobile apps can register with:

`bin/rails g controller api/devices`

After the controller is generated, include `Pushable::Controller`:

```ruby
class Api::DevicesController
  include Pushable::Controller
  # ...
```

Pushable provides the `create` method for you, so devices can now register themselves by POSTing to that controller.

## Device Registration

Devices can register with your application by submitting a POST to your devices controller with these params:

```
{ "device": { "token": "<TOKEN>", "platform": "<PLATFORM>" } }
```

`<TOKEN>` will be the device token and `<PLATFORM>` should be "ios" or "android".

## Expiration

Devices will expire after 14 days. This is to ensure user's who sell or otherwise give away their device will not be tied to that device forever. Each
time a POST to Devices is received, the token expiration will be refreshed.

## Defining Messages

Pushable provides a `Pushable::Message` class that provides an interface for defining push messages and sending them. The methods for defining a push are
`alert`, `badge`, `sound`, and `other`.

For example:

```ruby
class ExampleMessage < Pushable::Message
  def alert
    'This is an example'
  end

  def other
    { foo: :bar }
  end
end
```

Will generate the following structures:

- iOS: `{ alert: 'This is an example', badge: 1, sound: 'default', other: { foo: :bar } }`
- Android: `{ alert: 'This is an example', data: { foo: :bar } }`

`Pushable::Message` does not define a constructor so you can construct your message however you want.

## Sending messages

Pushable relies on ActiveJob to enqueue messages. Ensure your application is properly setup with ActiveJob!

`Pushable::Message` provides a `send_to` that pushes the message out to a user (or collection of users). The argument to `send_to` should be a
single record or relation.

For example:

```ruby
ExampleMessage.send_to User.first

# or

ExampleMessage.send_to User.where(beta: true)
```

## Push Console

Mounting `Pushable::Engine` gives you access to a test push console which makes it easier for the iOS/Android team to test their integration with Pushable.
You can

## Mercurius

Under the hood, Pushable uses the [Mercurius](https://github.com/jrbeck/mercurius) gem to send pushes.
