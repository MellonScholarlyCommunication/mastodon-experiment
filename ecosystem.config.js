module.exports = {
    apps : [
     {
      name   : "exp-server",
      script : "cd ../mastodon-bot ; LOG4JS=error yarn run server"
     },
     {
      name   : "exp-accepted",
      script : "cd ../mastodon-bot ; LOG4JS=info npx ldn-inbox-server handler ./accepted --config ./config/accepted_config.json5 -hn @handler/notification_handler/multi.js --loop"
     },
     {
      name   : "exp-inbox",
      script : "cd ../mastodon-bot ; LOG4JS=info npx ldn-inbox-server handler @inbox -hn @handler/notification_handler/multi.js --loop"
     },
     {
      name   : "exp-outbox",
      script : "cd ../mastodon-bot ; LOG4JS=info npx ldn-inbox-server handler @outbox -hn @handler/notification_handler/multi.js --loop"
     }
    ]
  }