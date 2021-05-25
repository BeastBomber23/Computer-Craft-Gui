os.loadAPI("gui.lua")

lastSelectedPage = -1
currentPage = 0

function backP()

	currentPage = lastSelectedPage - 1

end

function nextP()

	currentPage = lastSelectedPage + 1

end

while true do
    gui.screenCheck()

    if currentPage == 0 then

    	gui.screenReset()
    	gui.addLabel("Page 1|3", 1)
    	gui.addSpacer()
    	gui.addButton("Next", nextP)

    	lastSelectedPage = 0
    	currentPage = -1

    elseif currentPage == 1 then

    	gui.screenReset()
    	gui.addLabel("Page 2|3", 1)
    	gui.addSpacer()
    	gui.addButton("Next", nextP)
    	gui.addButton("Back", backP)

    	lastSelectedPage = 1
    	currentPage = -1

    elseif currentPage == 2 then

    	gui.screenReset()
    	gui.addLabel("Page 3|3", 1)
    	gui.addSpacer()
    	gui.addButton("Back", backP)

    	lastSelectedPage = 2
    	currentPage = -1

    end

end
