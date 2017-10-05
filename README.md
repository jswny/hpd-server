# HPD Server [![Build Status](https://travis-ci.org/jswny/hpd-server.svg?branch=master)](https://travis-ci.org/jswny/hpd-server) 

## Installation

1. Install [Elixir](https://elixir-lang.org/install.html), the language which the HPD Server is written in. Elixir runs on the Erlang VM (BEAM) and will require you to install Erlang as well. Make sure you have installed **at least** the following:
    * Erlang/OTP 20
    * Elixir v1.5.0
2. Install [Phoenix](https://hexdocs.pm/phoenix/installation.html#content), the Rails-like web framework for Elixir which provides most of HPD Server's functionality.
     * Note: HPD Server uses the older version of Phoenix (v1.2.x) instead of the newer version (v1.3.x). Thus, do not worry about the deprication warnings related to using the older version. In addition, the commands used will be in the form `mix phoenix.<command>` instead of `mix phx.<something>` for newer versions. Make note of these differences when referencing documentation or other resources.
3. Install [Postgres](https://www.postgresql.org/), the SQL database which HPD server uses.
4. Create a Postgres user with the following details:
    * Username: `postgres`
    * Password: `postgres`
    * Role: superuser (recommended)
5. Start the Postgres server and verify that you can login with the above user.
6. Start the server:
    * Install dependencies with `mix deps.get`
    * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
    * Start Phoenix endpoint with `mix phoenix.server`

Now the server should be running on [`localhost:4000`](http://localhost:4000).

## Testing & Documentation

### Tests
The tests are written using the default Elixir testing framework called [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html). ExUnit has solid [integration with Phoenix](https://hexdocs.pm/phoenix/testing.html#content) as well as many helpful tools for [testing](https://hexdocs.pm/plug/Plug.Test.html) [Plug](https://github.com/elixir-plug/plug), an Elixir standard web connection implementation which handles the interface for a request to the server.

To run the tests, you can run `mix test`. If you want to see which tests are running instead of just which tests are failing (which none should be), you can run `mix test --trace`.

## Documentation
Documentation is written inline primarily using `@doc` and `@moduledoc` module attributes. You can read more about Elixir documentation [here](https://hexdocs.pm/elixir/writing-documentation.html#content). To generate the documentation for HPD Server locally, run `mix docs`. Then, the documentation will be generated into the `/doc` folder, which you can view with your browser.

There is not much documentation required because this is a web application, however modules like the `Hpd.Import` module for importing CSV data into the database are well documented.

## API

### Users
| Method | Route | Auth? | Description |
| ------ | ----- | ----- | ----------- |
| `POST` | `/api/users` | False | Creates a new user and returns the `user_id`. |

### Sessions (Token authentication)
| Method | Route | Auth? | Description |
| ------ | ----- | ----- | ----------- |
| `POST` | `/api/sessions` | False | Creates a new session and returns a token. |

### Systems
| Method | Route | Auth? | Description |
| ------ | ----- | ----- | ----------- |
| `GET` | `/api/systems?token=<token>` | True | Gets a list of all systems. |
| `GET` | `/api/systems/:id?token=<token>` | True | Gets the details for the system specified by `:id` in the route. |

## Resources

### Elixir
  * Official website: http://www.elixir-lang.org/
  * Guides: https://elixir-lang.org/getting-started/introduction.html
  * Docs: https://hexdocs.pm/elixir/
  * Mailing list: https://groups.google.com/forum/#!forum/elixir-lang-core
  * Forum: https://elixirforum.com/
  * Source: https://github.com/elixir-lang/elixir

### Phoenix
  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

