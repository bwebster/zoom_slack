tell application "System Events"
	set openWindows to item 1 of (get the {title} of every window of (every process whose visible is true))

	repeat with theCurrentListItem in openWindows
		if (theCurrentListItem as string) starts with "Zoom Meeting ID" then return true
	end repeat
end tell

return false
