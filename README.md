# Key Cloak POC
## Dependencies
* docker **(>= 20.10.9)**
* docker-compose **(>= 1.29.2)**
* elixir **(~> 1.12.0-otp-24)**
* erlang/otp **(~> 24.0.2)**

## Development setup
#### Disclaimer
All listed steps here were tested under a Linux (Fedora 34) distribution, and may fail if you are using an MS Windows environment. If that is the case we highly recommend WSL, even if it isn't perfect, it is a stopgap solution.

#### Cloning
```
$ git clone git@github.com:abmBispo/keycloak-poc.git && cd keycloak-poc
```

#### `docker-compose`
_All commands in this section should be entered in the shell at the project's root._

In order to run the application with `docker-compose` you will need to have a `.env` file at the project's root. A template file `.env-sample` can be found in the root, with the variables docker needs to be able to run the application in the production environment. It is not necessary to have all of them when developing.
```
$ cp .env-sample .env
```

Start by pulling up the images to your local docker with:
```
$ docker-compose pull
```

Once you create the `.env` file you should be able to use `docker-compose` without build errors. The next step is to get the elixir dependencies. Run the command below. If no error messages show up, your environment is ready for development.
```
$ docker-compose run --rm phoenix mix do deps.get, deps.compile, compile
```

It's recommended to run the tests before you commit your changes:
```
$ docker-compose run --rm phoenix mix test
```

The command above runs the pending database migrations, so there's no need to run them manually for the test environment. However, for the `dev` environment you must run them yourself:
```
$ docker-compose run --rm phoenix mix ecto.create
$ docker-compose run --rm phoenix mix ecto.migrate
```
For rollbacks you just need to use `mix ecto.rollback`. Instead of `ecto.create` and `ecto.migrate`, you can run `ecto.setup` which will also run the seeds for the development environment. `ecto.reset` will drop, create and migrate the database.


If everything went well so far, you may run the application with:
```
$ docker-compose up
```
You can stop running the server by pressing `ctrl + c`.

You can check all running containers with:
```
$ docker ps
```
And if only `docker-compose` is running you may see something like:
<img align="center" alt="docker ps" src="docs/Screenshot from 2021-10-26 01-41-47.png" />


## Environment

### Phoenix application
The main application `app` runs at `localhost:4000`, with a simple [GraphiQL][graphiql_github] interface at `localhost:4000/graphiql` where you may check documentation, perform queries and mutations and connect to web sockets. GraphiQL is a valuable tool for the development team, both backend and frontend. 
For those who are familiar with the `iex` console to use Elixir specific functionalities or test module functions, you can open another shell window and connect to the already running container entering:
```
$ docker-compose exec app iex -S mix
```

When you need to run only the console, without the web server, you can run the following command:
```
$ docker-compose run --rm app iex -S mix
```

### PostgreSQL database

The PostgreSQL database runs at `localhost:5432`. To access the `psql` command line client the database container needs to be running, so you can use:
```
$ docker-compose exec db psql
```

### pgAdmin

`pgAdmin` plugin runs at `localhost:4001`. For people who aren't familiar with the `psql` client, there is also a graphical web client **pgAdmin**, where you can easily configure a connection using:
```
host=db
user=postgres
port=5432
```
The default username/password to access the **pgAdmin** can be found at the `.env-sample` file.

[graphiql_github]: https://github.com/graphql/graphiql