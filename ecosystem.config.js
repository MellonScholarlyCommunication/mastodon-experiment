module.exports = {
    apps : [
     {
      name   : "exp-server",
      script : "cd ../mastodon-bot ; LOG4JS=error yarn run server"
     },
     {
      name   : "exp-accepted",
      script : "cd ../mastodon-bot ; LOG4JS=info npx ldn-inbox-server handler ./accepted --config ./config/accepted_config.json5 -hn @handler/notification_handler/multi.js" ,
      cron: '*/1 * * * *',
      autorestart: false,
      env: {
        DEMO_MODE: 'NO_TOOTS',
        DEMO_PROFILE: 'https://wiki.mycontributions.info/en/researcher/orcid/0000-0000-0000-0010'
      }
     },
     {
      name   : "exp-inbox",
      script : "cd ../mastodon-bot ; LOG4JS=info npx ldn-inbox-server handler @inbox -hn @handler/notification_handler/multi.js" ,
      cron: '*/1 * * * *',
      autorestart: false ,
      env: {
        DEMO_MODE: 'NO_TOOTS',
        DEMO_PROFILE: 'https://wiki.mycontributions.info/en/researcher/orcid/0000-0000-0000-0010'
      }
     },
     {
      name   : "exp-outbox",
      script : "cd ../mastodon-bot ; LOG4JS=info npx ldn-inbox-server handler @outbox -hn @handler/notification_handler/multi.js" ,
      cron: '*/1 * * * *',
      autorestart: false,
      env: {
        DEMO_MODE: 'NO_TOOTS',
        DEMO_PROFILE: 'https://wiki.mycontributions.info/en/researcher/orcid/0000-0000-0000-0010'
      }
     }
    ]
  }