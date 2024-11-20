# Mastodon experiment

## Install

```
yarn install
npm link eventlog-server
npm link wikijs-cli
```

We assume a working installation of [mastodon-bot](https://github.com/MellonScholarlyCommunication/mastodon-bot) is available at the path `../mastodon-bot`.

## Config

Set the mastodon instances and mastodon account identifiers to track in `./config/accounts.txt`.

Format:

```
<mastodon host>;<account id>
```

The account id for a user can be found with the `npx mastodon-cli account` command:

```
$ npx mastodon-cli account --url https://mathstodon.xyz hochstenbach | jq '.id'
112881408245106756
```

## Set a demonstrator researcher profile page

```
export DEMO_MODE=NO_TOOTS
export DEMO_PROFILE=https://wiki.mycontributions.info/en/researcher/orcid/0000-0000-0000-0010
```

## Optional preparation

#### Create a backup of the cache database

```
npx eventlog-server export > ./export-2024-11-04.json
```

#### Import a cache database export

```
npx eventlog-server remove-all
npx eventlog-server import ./export-2024-11-04.json
```

## Start the daemons

```
pm2 start ecosystem.config.js
```

## Fetch toots for the configured accounts

Fetch some toots for the configured accounts. By default, 20 toots will be gathered per account. Using a `MASTODON_HANDLER` configuration handler we create and count only the toots that reference at least one URL.

The default account file to be processed is `./config/account.txt`.

The values in brackets `[...]` show optional arguments with their default values.

```
yarn fetch-all [max-toots-per-account:-20] [account_file:-./config/accounts.txt]
```

## Run the experiment

Running the experiment means moving all accepted toots to the mastodon bot environment and starting all handlers to find metadata for the URLs mentioned in the toots and updating the Wiki.js page.

```
yarn run-experiment
```

We can also test the workflow moving only one file to the mastodon bot environment.

```
yarn run-one
```

## Monitor the daemons

```
pm2 ps
```

```
pm2 logs exp-accepted
```

## Statistics

```
./bin/stats.sh
```

## Stop the daemons

```
pm2 stop ecosystem.config.js
```

## Export all experiment data

```
./bin/end_experiment.sh
```

## Clean all

```
./bin/clean_experiment.sh
```