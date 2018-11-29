tell application "System Events"
    try
        if exists (window 2 of process "zoom.us") then
            #do shell script "~/bin/update_slack_status meeting"
            return true 
        else
            #do shell script "~/bin/update_slack_status clear"
            return false
        end if
    end try
end tell
