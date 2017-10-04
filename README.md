# HPD Server

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

