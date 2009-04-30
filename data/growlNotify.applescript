-- growlNotify.applescript
--
-- Created by Mike Hagedorn on 2007-10-31.
-- Copyright (c) 2007 Silverchair Solutions. All rights reserved. http://www.silverchairsolutions.com
-- based on script from the growl website
-- works around the fact that growlnotify doesnt work on leopard

-- pass in like osascript growlNotify.applescript
on run argv
	set rspectitle to item 1 of argv
	set rspecmessage to item 2 of argv
	set rspecimage to item 3 of argv
	set rspecsticky to item 4 of argv
	
	tell application "GrowlHelperApp"
		-- Make a list of all the notification types
		-- that this script will ever send:
		set the allNotificationsList to {"RSpec Notification"}
		
		-- Make a list of the notifications
		-- that will be enabled by default.
		-- Those not enabled by default can be enabled later
		-- in the 'Applications' tab of the growl prefpane.
		set the enabledNotificationsList to {"RSpec Notification"}
		
		-- Register our script with growl.
		-- You can optionally (as here) set a default icon
		-- for this script's notifications.
		register as application "Growl-RSpec AppleScript Notifications" all notifications allNotificationsList default notifications enabledNotificationsList icon of application "Script Editor"
		
		-- Send a Notification...
		notify with name "RSpec Notification" title rspectitle description rspecmessage application name "Growl-RSpec AppleScript Notifications" image from location rspecimage sticky rspecsticky
	end tell
	
end run
