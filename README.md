# Mastodon experiment

## Install

```
yarn install
npm link eventlog-server
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
export DEMO_PROFILE=https://wiki.mycontributions.info/en/researcher/orcid/0000-0000-0000-0010
```

## Optional preparation

#### Create a backup of the cache database

```
npx eventlog-server export > ./export-2024-11-04.json
```

#### Import a cache database export

```
npx eventlog-server import ./export-2024-11-04.json
```

## Start the demos

In three separate windows start the `bot-accepted`, `bot-inbox` and `bot-outbox` handlers:

```
yarn bot-accepted
```

```
yarn bot-inbox
```

```
yarn bot-outbox
```

## Fetch toots for the configured accounts

```
yarn fetch-all
```

## Run the experiment

```
yarn run-experiment
```

## Clean all

```
yarn real-clean
```

Optional clean the cache database

```
npx eventlog-server remove-all
```