[![Gem Version](https://badge.fury.io/rb/zoom_slack.svg)](https://badge.fury.io/rb/zoom_slack)

# zoom_slack

**Note: this is alpha quality software, and still under active development!**

This gem provides an easy way to automatically set your Slack status any time you are in a Zoom meeting.  

The current implementation will only work on Mac OS X, but other operating system implementations are welcome!

## Getting Started

Install via Rubygems

    gem install zoom_slack
    
Next, [create a new Slack app](#Creating-a-New-App), and install it in your workspace to get a oauth token.

Then add a cron entry via `crontab -e` like this

    * * * * * zoom_slack <oauth_access_token>

## Creating a New App

You can obtain an oauth token by creating a new app and installing it into your workspace with these directions:

1. Go to https://api.slack.com/apps
1. Click "Create New App"
1. Give it an App Name (like "zoom_slack"), and assign it to your Workspace
1. Click "Create App"
1. Click "Permissions"
1. Add the "Modify user's profile" scope
1. Click "Save Changes"
1. Under the "Settings" sidebar, click "Install App", then click "Install App to Workspace"
1. Click "Authorize"
1. Copy you OAuth Access Token

## Todo

1. Tests!
1. Customizable text, emoji, and expiration
1. Documentation
1. Support for additional platforms
