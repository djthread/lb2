# Lucidboard

A kanban tool.

**Status:** Lots of board manipulation logic is built; starting to experiment
with frontend things. Hoping [Phoenix
LiveView](https://dockyard.com/blog/2018/12/12/phoenix-liveview-interactive-real-time-apps-no-need-to-write-javascript)
comes soon.

**CI:** [Lucidboard on CircleCI](https://circleci.com/gh/djthread/lucidboard) [![CircleCI](https://circleci.com/gh/djthread/lucidboard.svg?style=svg)](https://circleci.com/gh/djthread/lucidboard)

**Chat:** [Lucidboard on
Zulip](https://z.impulsedetroit.net/#narrow/stream/16-lucidboard)

To start your Phoenix development environment:

```bash
bin/dev
```

**Note:** If you are on the Quicken Loans network, you'll want to invoke this
script with `bin/dev --ql` or you will get errors around HTTPS authentication.

The [script's comments](bin/dev) explain a bit more, but you'll get two
docker containers -- a Postgres database (`lucidboard_dev_db`) and an Elixir
development container (`lucidboard_dev_app`). The script will then run the
fish shell inside the latter, dropping you into `/app` where the project
files reside.

When running this the first time, you'll need to install the dependencies and
initialize the database. (You may also simply type `setup` since it is an alias
for these commands.)

**Note:** the `setup` command is an alias for all of the following scripts
```bash
/setup_secrets.sh
mix deps.get
cd assets; npm install; cd ..
mix ecto.setup
```

Finally, start the application with `imp`. This is an alias for `iex -S mix
phx.server` which will run the app with Elixir's interactive repl, iex. This
will allow you to test lines of Elixir code and interact with the running
application. `imp` is the only command you'll need next time, now that things
are installed.

```bash
imp
```

Now you can visit [`localhost:8800`](http://localhost:8800) from your browser.

To close down and remove the docker containers, run the following script.
Don't worry - all your code and database data will remain intact for next
time.

```bash
bin/down
```

## Shell Aliases

These [recommended few](assets/docker/dev/config.fish) are imported to the
fish shell in the docker-based dev environment.

| Alias   | Full Command          |
| ------- | --------------------- |
| `imp`   | iex -S mix phx.server |
| `im`    | iex -S mix            |
| `mdg`   | iex mix deps.get      |
| `mdu`   | mix deps.update --all |
| `mt`    | mix test              |
| `mtw`   | mix test.watch        |
| `ml`    | mix lint              |
| `mer`   | mix ecto.reset        |
| `setup` | /setup_secrets.sh<br>mix deps.get<br>cd assets; npm install; cd ..<br> mix ecto.setup | 

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
