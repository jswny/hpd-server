# HPD Server [![Build Status](https://travis-ci.org/jswny/hpd-server.svg?branch=master)](https://travis-ci.org/jswny/hpd-server) [![Coverage Status](https://coveralls.io/repos/github/jswny/hpd-server/badge.svg?branch=master)](https://coveralls.io/github/jswny/hpd-server?branch=master) 

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
    * Create and migrate your database with `mix ecto.setup`
    * Start Phoenix endpoint with `mix phoenix.server`

Now the server should be running on [`localhost:4000`](http://localhost:4000).

## Testing & Documentation

### Tests
The tests are written using the default Elixir testing framework called [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html). ExUnit has solid [integration with Phoenix](https://hexdocs.pm/phoenix/testing.html#content) as well as many helpful tools for [testing](https://hexdocs.pm/plug/Plug.Test.html) [Plug](https://github.com/elixir-plug/plug), an Elixir standard web connection implementation which handles the interface for a request to the server.

To run the tests, you can run `mix test`. If you want to see which tests are running instead of just which tests are failing (which none should be), you can run `mix test --trace`.

### Documentation
Documentation is written inline primarily using `@doc` and `@moduledoc` module attributes. You can read more about Elixir documentation [here](https://hexdocs.pm/elixir/writing-documentation.html#content). To generate the documentation for HPD Server locally, run `mix docs`. Then, the documentation will be generated into the `/doc` folder, which you can view with your browser.

There is not much documentation required because this is a web application, however modules like the `Hpd.Import` module for importing CSV data into the database are well documented.

## API Overview

### Users
| Endpoint | Auth? | Usage |
| -------- | ----- | ----- |
| `POST /api/users` | False | Creates a new user and returns the `user_id`. |

### Sessions (Token authentication)
| Endpoint | Auth? | Usage |
| -------- | ----- | ----- |
| `POST /api/sessions` | False | Creates a new session and returns a token. |

### Systems
| Endpoint | Auth? | Usage |
| -------- | ----- | ----- |
| `GET /api/systems?token={token}` | True | Gets a list of all systems. |
| `GET /api/systems/{id}?token={token}` | True | Gets the details for the system specified by `{id}` in the route. |

## API Examples

All API routes return JSON results.

### Create a user

#### Endpoint
`POST /api/users`

#### Request
```
curl -H "Content-Type: application/json" -X POST -d '{"user": {"username":"john_doe","password":"abc123"}}' http://localhost:4000/api/users
```

#### Response
Status: `201`
```
{
  "data":{
    "username":"john_doe",
    "id":1
  }
}
```

#### Errors
Validation errors such as no username provided or no password provided.

### Create a session (token)

#### Endpoint
`POST /api/sessions`

#### Request
```
curl -H "Content-Type: application/json" -X POST -d '{"user": {"username":"john_doe","password":"abc123"}}' http://localhost:4000/api/sessions
```

#### Response
Status: `201`
```
{
  "token": "SFMyNTY.g3QAAAACZAAEZGF0YWEBZAAGc2lnbmVkbgYA9DCv8V4B.7NpcBsw0yWngXRJllOGjtuc-CohROT93W8mWQckEih4"
}
```

#### Errors
| Status | Description | Response |
| ------ | ----------- | -------- |
| `401`  | User does not exist | `{"errors": {"detail": "Specified user does not exist"}}` |
| `401`  | Invalid credentials | `{"errors": {"detail": "Invalid username or password"}}` |

### Get all systems

#### Endpoint
`GET /api/systems?token={token}`

#### Request
```
curl http://localhost:4000/api/systems?token=SFMyNTY.g3QAAAACZAAEZGF0YWEBZAAGc2lnbmVkbgYA9DCv8V4B.7NpcBsw0yWngXRJllOGjtuc-CohROT93W8mWQckEih4
```

#### Response
Status: `201`
```
{
  "data":[
    {
      "capacity_total_sizeTiB":67.06875,
      "performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis":0.0,
      "cpgCount":45,
      "capacity_total_freeTiB":36.0158203125,
      "capacity_byType_nl_sizeTiB":39.4625,
      "location_country":"US",
      "nodes_cpuAvgMax":1,
      "performance_summary_delAckPct":0.0,
      "performance_summary_portInfo_writeServiceTimeMillis":0.3076309263706207,
      "capacity_total_compactionRatio":6.599999904632568,
      "performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS":0.0,
      "capacity_total_freePct":53.699851989746094,
      "capacity_byType_fc_freeTiB":10.299023437499999,
      "systemName":"Ricadonna",
      "disks_total_diskCountFailed":0,
      "performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis":0.0,
      "capacity_byType_ssd_sizeTiB":9.75625,
      "disks_total_diskCount":192,
      "recommended_osVersion":"-",
      "performance_portBandwidthData_total_iopsMax":1454.2,
      "performance_summary_portInfo_readServiceTimeMillis":1.4700697481632232,
      "capacity_byType_fc_sizeTiB":17.849999999999998,
      "serialNumber":1,
      "performance_portBandwidthData_total_dataRateKBPSAvg":20597.5,
      "vvCount":36,
      "performance_summary_portInfo_totalServiceTimeMillis":0.8935664623975753,
      "performance_portBandwidthData_total_iopsAvg":978.0,
      "disksState":"normal",
      "updated":"2017-09-20T09:30:13.000000",
      "disks_total_diskCountNormal":192,
      "capacity_total_compressionRatio":0.0,
      "model":"7200",
      "disks_total_diskCountDegraded":0,
      "productFamily":7000,
      "osVersion":"3.2.2.612 (MU4)",
      "companyName":"Frenzy",
      "nodes_nodeCountOffline":0,
      "capacity_byType_ssd_freeTiB":7.4976562499999995,
      "location_region":"Americas",
      "performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS":0.0,
      "id":1,
      "capacity_total_dedupeRatio":0.0,
      "capacity_byType_nl_freeTiB":18.219140624999998,
      "installDate":"2014-03-12T16:45:27.000000",
      "tpvvCount":30,
      "nodes_nodeCount":6
    },
    {
      "capacity_total_sizeTiB":26.873437499999998,
      "performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis":0.0,
      "cpgCount":6,
      "capacity_total_freeTiB":16.6072265625,
      "capacity_byType_nl_sizeTiB":0.0,
      "location_country":"MX",
      "nodes_cpuAvgMax":1,
      "performance_summary_delAckPct":0.0,
      "performance_summary_portInfo_writeServiceTimeMillis":2.0,
      "capacity_total_compactionRatio":4.300000190734863,
      "performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS":0.0,
      "capacity_total_freePct":61.79792404174805,
      "capacity_byType_fc_freeTiB":16.6072265625,
      "systemName":"Brainchild",
      "disks_total_diskCountFailed":0,
      "performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis":0.0,
      "capacity_byType_ssd_sizeTiB":0.0,
      "disks_total_diskCount":72,
      "recommended_osVersion":"3.2.2(EMU4)",
      "performance_portBandwidthData_total_iopsMax":679.8000000000001,
      "performance_summary_portInfo_readServiceTimeMillis":1.738500040769577,
      "capacity_byType_fc_sizeTiB":26.873437499999998,
      "serialNumber":2,
      "performance_portBandwidthData_total_dataRateKBPSAvg":98430.5,
      "vvCount":24,
      "performance_summary_portInfo_totalServiceTimeMillis":2.3,
      "performance_portBandwidthData_total_iopsAvg":546.0,
      "disksState":"normal",
      "updated":"2017-09-20T09:22:16.000000",
      "disks_total_diskCountNormal":72,
      "capacity_total_compressionRatio":0.0,
      "model":"8200",
      "disks_total_diskCountDegraded":0,
      "productFamily":8000,
      "osVersion":"3.2.2.530 (MU3)",
      "companyName":"Shanga",
      "nodes_nodeCountOffline":0,
      "capacity_byType_ssd_freeTiB":0.0,
      "location_region":"Americas",
      "performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS":0.0,
      "id":2,
      "capacity_total_dedupeRatio":0.0,
      "capacity_byType_nl_freeTiB":0.0,
      "installDate":"2016-07-25T17:07:37.000000",
      "tpvvCount":18,
      "nodes_nodeCount":6
    }
  ]
}
```

#### Errors
| Status | Description | Response |
| ------ | ----------- | -------- |
| `401`  | Missing token | `{"errors": {"detail": "No token provided"}}` |
| `401`  | Invalid token | `{"errors": {"detail": "Invalid token"}}` |

### Get a system

#### Endpoint
`GET /api/systems/{id}?token={token}`

#### Request
```
curl http://localhost:4000/api/systems/1?token=SFMyNTY.g3QAAAACZAAEZGF0YWEBZAAGc2lnbmVkbgYA9DCv8V4B.7NpcBsw0yWngXRJllOGjtuc-CohROT93W8mWQckEih4
```

#### Response
Status: `201`
```
{
  "data":{
    "capacity_total_sizeTiB":67.06875,
    "performance_summary_vvInfo_vvsByType_ssd_readServiceTimeMillis":0.0,
    "cpgCount":45,
    "capacity_total_freeTiB":36.0158203125,
    "capacity_byType_nl_sizeTiB":39.4625,
    "location_country":"US",
    "nodes_cpuAvgMax":1,
    "performance_summary_delAckPct":0.0,
    "performance_summary_portInfo_writeServiceTimeMillis":0.3076309263706207,
    "capacity_total_compactionRatio":6.599999904632568,
    "performance_summary_vvInfo_vvsByType_ssd_writeBandwidthMBPS":0.0,
    "capacity_total_freePct":53.699851989746094,
    "capacity_byType_fc_freeTiB":10.299023437499999,
    "systemName":"Ricadonna",
    "disks_total_diskCountFailed":0,
    "performance_summary_vvInfo_vvsByType_ssd_writeServiceTimeMillis":0.0,
    "capacity_byType_ssd_sizeTiB":9.75625,
    "disks_total_diskCount":192,
    "recommended_osVersion":"-",
    "performance_portBandwidthData_total_iopsMax":1454.2,
    "performance_summary_portInfo_readServiceTimeMillis":1.4700697481632232,
    "capacity_byType_fc_sizeTiB":17.849999999999998,
    "serialNumber":1,
    "performance_portBandwidthData_total_dataRateKBPSAvg":20597.5,
    "vvCount":36,
    "performance_summary_portInfo_totalServiceTimeMillis":0.8935664623975753,
    "performance_portBandwidthData_total_iopsAvg":978.0,
    "disksState":"normal",
    "updated":"2017-09-20T09:30:13.000000",
    "disks_total_diskCountNormal":192,
    "capacity_total_compressionRatio":0.0,
    "model":"7200",
    "disks_total_diskCountDegraded":0,
    "productFamily":7000,
    "osVersion":"3.2.2.612 (MU4)",
    "companyName":"Frenzy",
    "nodes_nodeCountOffline":0,
    "capacity_byType_ssd_freeTiB":7.4976562499999995,
    "location_region":"Americas",
    "performance_summary_vvInfo_vvsByType_ssd_readBandwidthMBPS":0.0,
    "id":1,
    "capacity_total_dedupeRatio":0.0,
    "capacity_byType_nl_freeTiB":18.219140624999998,
    "installDate":"2014-03-12T16:45:27.000000",
    "tpvvCount":30,
    "nodes_nodeCount":6
  }
}
```

#### Errors
| Status | Description | Response |
| ------ | ----------- | -------- |
| `401`  | Missing token | `{"errors": {"detail": "No token provided"}}` |
| `401`  | Invalid token | `{"errors": {"detail": "Invalid token"}}` |


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

