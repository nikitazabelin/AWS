#!/bin/bash

# Install Datadog Agent
DD_API_KEY="00000000000000000" DD_SITE="datadoghq.eu" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"


# Enable logs in Datadog
echo 'logs_enabled: true' | sudo tee -a /etc/datadog-agent/datadog.yaml > /dev/null

# Add Apache log config to Datadog
sudo tee /etc/datadog-agent/conf.d/apache.d/conf.yaml << EOF
## All options defined here are available to all instances.
init_config:

instances:

  - apache_status_url: http://localhost/server-status?auto

    
    disable_generic_tags: true

logs:
  - type: file
    path: /var/log/httpd/access_log
    source: apache
    service: apache
EOF

# Set read access for Datadog Agent user
sudo setfacl -Rm u:dd-agent:rx /var/log/httpd

# Restart Datadog Agent
sudo restart datadog-agent
