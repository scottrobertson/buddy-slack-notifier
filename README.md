# Buddy Slack Notified

Used to notify Slack about Buddy builds. One Slack message is created per build, and the status is updated throughout the process.

### Example Buddy Action:

```yaml
- action: 'Notify Slack: :building_construction: Started'
    type: BUILD
    working_directory: "/buddy/notify"
    docker_image_name: scottrobertson/buddy-slack-notifier
    docker_image_tag: 0.0.1
    execute_commands:
    - cd /notify
    - 'ruby bin/notify.rb ":building_construction: Started"'
    mount_filesystem_path: "/buddy/notify"
    shell: BASH
    trigger_condition: ALWAYS
    variables:
    - key: APP_NAME
      value: Dashboard
    - key: CHANNEL
      value: "#ops"
    - key: ENVIRONMENT
      value: Production
    - key: TOKEN
      value: "$SLACK_TOKEN"

# Do your stuff

- action: 'Notify Slack: :white_check_mark: Complete'
  type: BUILD
  working_directory: "/buddy/notify"
  docker_image_name: scottrobertson/buddy-slack-notifier
  docker_image_tag: 0.0.1
  execute_commands:
  - cd /notify
  - 'ruby bin/notify.rb ":white_check_mark: Complete"'
  mount_filesystem_path: "/buddy/notify"
  shell: BASH
  trigger_condition: ALWAYS
  variables:
  - key: APP_NAME
    value: Dashboard
  - key: CHANNEL
    value: "#ops"
  - key: ENVIRONMENT
    value: Production
  - key: TOKEN
    value: "$SLACK_TOKEN"

```

*Note*:
