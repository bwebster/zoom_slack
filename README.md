[![Gem Version](https://badge.fury.io/rb/zoom_slack.svg)](https://badge.fury.io/rb/zoom_slack)
[![Build Status](https://travis-ci.org/bwebster/zoom_slack.svg?branch=master)](https://travis-ci.org/bwebster/zoom_slack)
[![codecov](https://codecov.io/gh/bwebster/zoom_slack/branch/master/graph/badge.svg)](https://codecov.io/gh/bwebster/zoom_slack)

# zoom_slack

**Note: this is alpha quality software, and still under active development!**

This gem provides an easy way to automatically set your Slack status any time you are in a Zoom meeting.  

The current implementation will only work on Mac OS X, but other operating system implementations are welcome!

## Getting Started

Install via Rubygems

    gem install zoom_slack
    
Next, [create a new Slack app](#Creating-a-New-App), and install it in your workspace to get a personal oauth token.

Then add a cron entry via `crontab -e` like this

    * * * * * zoom_slack <oauth_access_token>
   
After `zoom_slack` has run for the first time, you'll likely need to enable an Accessibility setting to make things work:

1. Open up System Preferences and select Security & Privacy
1. Select Accessibility
1. Ensure that `cron` is checked (you might also need to check `terminal` or `iTerm`)
   
    
## Usage

You can see all the various config options by running `zoom_slack -h`

    $ zoom_slack -h
    Usage: zoom_slack [options]

    Authentication options:
        -t, --token TOKEN               Slack token (defaults to $SLACK_API_TOKEN)

    Profile status options:
        --text TEXT                     Status text (defaults to 'In a meeting')
        --emoji EMOJI                   Status emoji (defaults to ':spiral_calendar_pad:')
        --expires N                     Status expires in N minutes (defaults to 0)
        --clear-text TEXT               Clear status text (defaults to '')
        --clear-emoji EMOJI             Clear status emoji (defaults to '')

    Common options:
        -h, --help                      Show this message

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

1. Better documentation
1. Support for additional platforms
