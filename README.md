[![Gem Version](https://badge.fury.io/rb/zoom_slack.svg)](https://badge.fury.io/rb/zoom_slack)
[![Build Status](https://travis-ci.org/bwebster/zoom_slack.svg?branch=master)](https://travis-ci.org/bwebster/zoom_slack)
[![Maintainability](https://api.codeclimate.com/v1/badges/16072bb9fca7ac37115c/maintainability)](https://codeclimate.com/github/bwebster/zoom_slack/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/16072bb9fca7ac37115c/test_coverage)](https://codeclimate.com/github/bwebster/zoom_slack/test_coverage)

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
