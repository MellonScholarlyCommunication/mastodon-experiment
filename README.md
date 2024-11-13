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

```
yarn fetch-all
```

## Run the experiment

```
yarn run-experiment
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

## Clean all

```
yarn real-clean
```

Optional clean the cache database

```
npx eventlog-server remove-all
```

Clean the wiki page of the DEMO_PROFILE too:

```
./bin/clean_wiki.sh
```