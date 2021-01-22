loadLuaFile(scriptPath .. "/editor/menus/Page.lua", "")
loadLuaFile(scriptPath .. "/editor/menus/OverlayPage.lua", "")
loadLuaFile(scriptPath .. "/editor/menus/EditorJointPage.lua", "")
loadLuaFile(scriptPath .. "/editor/ui_components/Item.lua", "")
loadLuaFile(scriptPath .. "/editor/ui_components/RectItem.lua", "")
loadLuaFile(scriptPath .. "/editor/ui_components/SpriteItem.lua", "")
loadLuaFile(scriptPath .. "/editor/ui_components/TextItem.lua", "")

g_editLevelPacks = 50
g_levelsPerFolder = 21
g_levelsPerFolderRow = 7

Editor = {}

function Editor:new(o)
	local o = o or {}
	self.__index = self
	_G.setmetatable(o, self)
	return o
end

function Editor:eventTriggered(event)
	if event.id == events.EID_LEVEL_ENDED then
		if startedFromEditor then
			returnToEditor()
		end
	end
end

EditorPage = ui.Frame:new()

function EditorPage:init()

	self.backgroundColour = { r = 0, g = 0, b = 0, a = 1 }

	local bw, bh = _G.res.getSpriteBounds("LS_LEVEL_BG_NORMAL_OPEN_1")

	local epsCaption = ui.Text:new()
	epsCaption.font = fontBasic
	epsCaption.text = "Worlds"
	epsCaption.x = bw * 0.3
	epsCaption.y = bh * 0.3
	epsCaption.hanchor = "LEFT"
	self:addChild(epsCaption)
	
	local offs = 0
	for i = 1, #g_episodeIds do
		for j = 1, #g_episodes[g_episodeIds[i]].pages do
			offs = offs + 1
			local ep = ui.ImageButton:new()
			ep.name = "ep" .. i .. "_" .. j
			ep.scaleX = 0.35
			ep.scaleY = 0.35
			ep.x = bw * offs * 0.4
			ep.y = bh * 0.8
			ep:setImage("LS_LEVEL_BG_NORMAL_OPEN_1")
			ep.returnValue = "EDITOR_MENU_WORLD"
			ep.meta = { ep = g_episodeIds[i], page = j }
			local epNumber = ui.Text:new()
			epNumber.font = "FONT_BIG_NUMBERS"
			epNumber.text = "" .. g_episodes[g_episodeIds[i]].pages[j].display_number
			ep:addChild(epNumber)
			self:addChild(ep)
		end
	end
	
	local foldersCaption = ui.Text:new()
	foldersCaption.font = fontBasic
	foldersCaption.text = "Folders"
	foldersCaption.x = bw * 0.3
	foldersCaption.y = bh * 1.2
	foldersCaption.hanchor = "LEFT"
	self:addChild(foldersCaption)
	
	for i = 1, g_editLevelPacks do
		local col = (i - 1) % 20
		local row = (i - 1 - col) / 20
		
		local folder = ui.ImageButton:new()
		folder.scaleX = 0.35
		folder.scaleY = 0.35
		folder.x = bw * (col + 1) * 0.4
		folder.y = bh * (1.2 + (row + 1) * 0.4)
		folder:setImage("LS_LEVEL_BG_NORMAL_OPEN_1")
		folder.returnValue = "EDITOR_MENU_FOLDER"
		folder.meta = i
		local epNumber = ui.Text:new()
		epNumber.font = "FONT_BIG_NUMBERS"
		epNumber.text = "" .. i
		folder:addChild(epNumber)
		self:addChild(folder)
	end
	
	local exitButton = ui.ImageButton:new()
	exitButton:setImage("LS_BACK_BUTTON")
	exitButton.x = 0
	exitButton.y = screenHeight
	exitButton.returnValue = "EDITOR_EXIT"
	self:addChild(exitButton)
	
	local nextPage = ui.ImageButton:new()
	nextPage:setImage("LS_BACK_BUTTON")
	nextPage.scaleX = -1
	local w, _ = _G.res.getSpriteBounds("LS_BACK_BUTTON")
	nextPage.x = screenWidth
	nextPage.y = screenHeight
	nextPage.returnValue = "EDITOR_MENU_WORLD"
	nextPage.meta = { ep = g_episodeIds[1], page = 1 }
	self:addChild(nextPage)
end

EditorEpPage = ui.Frame:new()

function EditorEpPage:new(e, p)
	local o = {}
	o.ep = e
	o.page = p
	return ui.Frame.new(self, o)
end

function EditorEpPage:init()

	self.backgroundColour = { r = 0, g = 0, b = 0, a = 1 }
	
	local world = -1
	
	local world_index = 1
	for i = 1, #g_episodeIds do
		for j = 1, #g_episodes[g_episodeIds[i]].pages do
			if i == self.ep and j == self.page then
				world = world_index
			end
			world_index = world_index + 1
		end
	end

	local exitButton = ui.ImageButton:new()
	exitButton:setImage("LS_BACK_BUTTON")
	exitButton.x = 0
	exitButton.y = screenHeight
	exitButton.returnValue = "EDITOR_MENU"
	self:addChild(exitButton)
	
	local nextPage = ui.ImageButton:new()
	nextPage:setImage("LS_BACK_BUTTON")
	nextPage.scaleX = -1
	local w, _ = _G.res.getSpriteBounds("LS_BACK_BUTTON")
	nextPage.x = screenWidth
	nextPage.y = screenHeight
	local e = self.ep
	local p = self.page
	p = p + 1
	if p > #g_episodes[e].pages then
		p = 1
		for i = 1, #g_episodeIds do
			if e == g_episodeIds[i] then
				if i < #g_episodeIds then
					e = g_episodeIds[i + 1]
					break
				else
					e = nil
				end
			end
		end
	end

	if e ~= nil then
		nextPage.returnValue = "EDITOR_MENU_WORLD"
		nextPage.meta = { ep = e, page = p }
	else
		nextPage.returnValue = "EDITOR_MENU_FOLDER"
		nextPage.meta = 1
	end
	self:addChild(nextPage)
	
	local bw, bh = _G.res.getSpriteBounds("LS_LEVEL_BG_NORMAL_OPEN_1")
	
	local epsCaption = ui.Text:new()
	epsCaption.font = fontBasic
	epsCaption.text = "World"
	epsCaption.x = bw * 0.3
	epsCaption.y = bh * 0.3
	epsCaption.hanchor = "LEFT"
	self:addChild(epsCaption)
	
	local epsCaption2 = ui.Text:new()
	epsCaption2.font = "FONT_BIG_NUMBERS"
	epsCaption2.text = "" .. g_episodes[self.ep].pages[self.page].display_number or "0"
	epsCaption2.x = screenWidth * 0.11
	epsCaption2.y = bh * 0.3
	epsCaption2.hanchor = "LEFT"
	self:addChild(epsCaption2)
	
	local ln = 1
	local pg = g_episodes[self.ep].pages[self.page]
	local folder = pg.folder_name
	if pg.layout == "grid" or pg.layout == "facebook" then
		local rows
		local cols
		if pg.layout == "grid" then
			cols = pg.layout_params.cols
			rows = pg.layout_params.rows
		else
			cols = 3
			rows = 1
		end
		local idx = 1
		for i = 1, rows do
			for j = 1, cols do
				local lvl = ui.ImageButton:new()
				lvl.scaleX = 1
				lvl.scaleY = 1
				lvl.x = bw * j * 1.1
				lvl.y = bh * i * 1.1
				lvl:setImage("LS_LEVEL_BG_NORMAL_OPEN_1")
				local epNumber = ui.Text:new()
				epNumber.font = "FONT_BIG_NUMBERS"
				local level_index = getLevelIndexInEpisode(pg.levels[ln].name)
				if g_episodes[self.ep].per_page_level_numbering then
					epNumber.text = "" .. ln
				else
					epNumber.text = "" .. level_index
				end
				
				lvl.returnValue = "EDITOR_GOTO_LEVEL"
				lvl.meta =
				{
					index = ln,
					index_in_theme = level_index,
					theme = self.ep,
					world = world,
					page = self.page,
					level_name = pg.levels[ln].name,
					level_folder = levelPath .. "/" .. folder .. "/",
					editor_page = "pack",
				}
				
				lvl:addChild(epNumber)
				self:addChild(lvl)
				ln = ln + 1
			end
		end
	elseif pg.layout == "goldeneggs" then
		for k, v in _G.ipairs(pg.levels) do
			local lvl = ui.ImageButton:new()
			lvl.scaleX = 1
			lvl.scaleY = 1
			lvl.x = bw + v.x * bw * 1.1 * 7
			lvl.y = bh + v.y * bh * 1.1 * 3
			lvl:setImage("LS_LEVEL_BG_NORMAL_OPEN_1")
			local epNumber = ui.Text:new()
			epNumber.font = "FONT_BIG_NUMBERS"
			local level_index = getLevelIndexInEpisode(v.name)
			if g_episodes[self.ep].per_page_level_numbering then
				epNumber.text = "" .. ln
			else
				epNumber.text = "" .. level_index
			end
			
			lvl.returnValue = "EDITOR_GOTO_LEVEL"
			lvl.meta =
			{
				index = k,
				index_in_theme = level_index,
				theme = self.ep,
				world = world,
				page = self.page,
				level_name = v.name,
				level_folder = levelPath .. "/" .. folder .. "/",
				editor_page = "pack",
			}
			
			lvl:addChild(epNumber)
			self:addChild(lvl)
			ln = ln + 1
		end
	end
end

EditorFolderPage = ui.Frame:new()

function EditorFolderPage:new(f)
	local o = {}
	o.folder = f
	return ui.Frame.new(self, o)
end

function EditorFolderPage:init()

	self.backgroundColour = { r = 0, g = 0, b = 0, a = 1 }

	local exitButton = ui.ImageButton:new()
	exitButton:setImage("LS_BACK_BUTTON")
	exitButton.x = 0
	exitButton.y = screenHeight
	exitButton.returnValue = "EDITOR_MENU"
	self:addChild(exitButton)
	
	local nextPage = ui.ImageButton:new()
	nextPage:setImage("LS_BACK_BUTTON")
	nextPage.scaleX = -1
	local w, _ = _G.res.getSpriteBounds("LS_BACK_BUTTON")
	nextPage.x = screenWidth
	nextPage.y = screenHeight
	if self.folder < g_editLevelPacks then
		nextPage.returnValue = "EDITOR_MENU_FOLDER"
		nextPage.meta = self.folder + 1
	else
		nextPage.visible = false
	end
	self:addChild(nextPage)
	
	local bw, bh = _G.res.getSpriteBounds("LS_LEVEL_BG_NORMAL_OPEN_1")
	
	local epsCaption = ui.Text:new()
	epsCaption.font = fontBasic
	epsCaption.text = "folder \"pack" .. self.folder .. "\""
	epsCaption.x = bw * 0.3
	epsCaption.y = bh * 0.3
	epsCaption.hanchor = "LEFT"
	self:addChild(epsCaption)
	
	local ln = (self.folder - 1) * g_levelsPerFolder + 1
	local idx = 1
	local rows = g_levelsPerFolder / g_levelsPerFolderRow
	local cols = g_levelsPerFolderRow
	for i = 1, rows do
		for j = 1, cols do
			local lvl = ui.ImageButton:new()
			lvl.scaleX = 1
			lvl.scaleY = 1
			lvl.x = bw * j * 1.1
			lvl.y = bh * i * 1.1
			lvl:setImage("LS_LEVEL_BG_NORMAL_OPEN_1")
			local epNumber = ui.Text:new()
			epNumber.font = "FONT_BIG_NUMBERS"
			epNumber.text = "" .. ln
			lvl:addChild(epNumber)
			self:addChild(lvl)
			if ln >= 1000 then
				epNumber.scaleX = 0.5
				epNumber.scaleY = 0.5
			elseif ln >= 100 then
				epNumber.scaleX = 0.67
				epNumber.scaleY = 0.67
			end
			
			if checkForLuaFile(levelPath .. "/pack" .. self.folder .. "/Level" .. ln .. ".lua") then
				--lvl:setImage("LS_LEVEL_BG_NORMAL_OPEN_1")
			else
				--lvl:setImage("LS_LEVEL_BG_NORMAL_OPEN_1")
				lvl.alpha = 0.3
			end
			
			lvl.returnValue = "EDITOR_GOTO_LEVEL"
			lvl.meta =
			{
				index = idx,
				index_in_theme = idx,
				theme = 1,
				world = -1,
				page = self.folder,
				level_name = "Level" .. ln,
				level_folder = levelPath .. "/pack" .. self.folder .. "/",
				editor_page = "folder",
			}
			
			ln = ln + 1
			idx = idx + 1
		end
	end
end

function editor_pointer_event(o, eventType, x, y)
	local result, meta = ui.Frame.onPointerEvent(o, eventType, x, y)
	
	if result == "EDITOR_MENU_WORLD" then
		menuManager:changeRoot(EditorEpPage:new(meta.ep, meta.page))
	elseif result == "EDITOR_EXIT" then
		startedFromEditor = false
		eventManager:notify({ id = events.EID_CHANGE_SCENE, target = "MAIN_MENU", from = "EPISODE_SELECTION" })
	elseif result == "EDITOR_MENU" then
		menuManager:changeRoot(EditorPage:new())
	elseif result == "EDITOR_MENU_FOLDER" then
		menuManager:changeRoot(EditorFolderPage:new(meta))
	elseif result == "EDITOR_GOTO_LEVEL" then
		editLevel(meta.level_folder, meta.level_name, meta.index, meta.index_in_theme, meta.theme, meta.world, meta.page, meta.editor_page)
	end
	
	if eventType == "BACK" then
		if o.init == EditorPage.init then
			startedFromEditor = false
			eventManager:notify({ id = events.EID_CHANGE_SCENE, target = "MAIN_MENU", from = "EPISODE_SELECTION" })
		else
			menuManager:changeRoot(EditorPage:new())
		end
	end
end

EditorPage.onPointerEvent = editor_pointer_event
EditorEpPage.onPointerEvent = editor_pointer_event
EditorFolderPage.onPointerEvent = editor_pointer_event

function editLevel(folder, level, index, index_in_theme, theme, world, page, editor_page)
	startedFromEditor = true
	_G.res.stopAudio(currentMainMenuSong)
	levelName = level
	levelFolder = folder
	setEditing(true)
	setPhysicsEnabled(physicsEnabled)
	currentLevelNumberInTheme = index
	currentLevelNumber = index_in_theme
	currentThemeNumber = theme
	currentWorldNumber = world
	currentPageNumber = page
	loadLevelInternal(folder .. level)
	currentGameMode = updateEditor

	--local hud = ui.GameHud:new()
	--menuManager:changeRoot(hud)
	--hud.visible = false
	menuManager:changeRoot(nil)
	
	g_editorPage = editor_page
end

function levelCrypt(levelFolder, levelName)
	local levelFolderWin = _G.string.gsub(levelFolder, "/", "\\")
	print (levelFolderWin .. levelName)
	_G.os.execute("buildLevelEditor.bat " .. levelFolderWin .. " " .. levelName .. ".lua")
end

function updateEditor(dt, time)
	
	if not editorJointPage then
		editorJointPage = EditorJointPage:new()
		editorJointPage:onEntry()
	end

	if oldZoomLevel ~= zoomLevel then
		worldScale = worldScale + zoomLevel - oldZoomLevel
		setWorldScale(worldScale)
		oldZoomLevel = zoomLevel
	end	

	updateScale()
	cursorPhysics.x, cursorPhysics.y = screenToPhysicsTransform(cursor.x, cursor.y)
	cursorWorld.x, cursorWorld.y = screenToWorldTransform(cursor.x, cursor.y)
	
	

	-- XXX: ADD TO OTHERS
	if(selectedObjects ~= nil and #selectedObjects == 1) then
		initCollisionDummy(selectedObjects[1])	
	end
	
	if(keyReleased["LBUTTON"] or keyReleased["RBUTTON"]) then
		
	end
	
	if(keyHold["RETURN"] and keyPressed["DOWN"]) then
		alignObjects("DOWN")
	end
	
	if(keyHold["RETURN"] and keyPressed["UP"]) then
		alignObjects("UP")
	end

	if(keyHold["RETURN"] and keyPressed["RIGHT"]) then
		alignObjects("RIGHT")
	end
	
	if(keyHold["RETURN"] and keyPressed["LEFT"]) then
		alignObjects("LEFT")
	end

	-- XXX: ADD TO OTHERS
	if (keyHold["SHIFT"] or keyHold["CONTROL"]) and (keyPressed["W"] or keyPressed["E"]) and showSleepingObjects == true then
		if  #selectedObjects == 1 then
			local name = selectedObjects[1].name
			local selected = objects.world[name]
			local blockDef = blockTable.blocks[selected.definition]
			local dir = 1

			if(keyHold["CONTROL"]) then dir = -1 end

			if(blockDef.radius) then
				adjustedBlockDef.objectNames[name].radius = adjustedBlockDef.objectNames[name].radius + 0.1 * dir
				
				if(adjustedBlockDef.objectNames[name].radius < 0) then
					adjustedBlockDef.objectNames[name].radius = 0
				end
				
			elseif(blockDef.width and blockDef.height) then
				if(keyPressed["W"]) then
					adjustedBlockDef.objectNames[name].width = adjustedBlockDef.objectNames[name].width + 0.1 * dir
					if(adjustedBlockDef.objectNames[name].width < 0) then
						adjustedBlockDef.objectNames[name].width = 0
					end			

				else
					adjustedBlockDef.objectNames[name].height = adjustedBlockDef.objectNames[name].height + 0.1 * dir
					if(adjustedBlockDef.objectNames[name].height < 0) then
						adjustedBlockDef.objectNames[name].height = 0
					end			
				end
			elseif(blockDef.vertices ~= nil) then
				for k,v in _G.pairs(blockDef.vertices) do
					local vert = adjustedBlockDef.objectNames[name].vertices[k]
					if(keyPressed["W"]) then
						if(vert.x > 0.5) then
							vert.x = vert.x + 0.05 * dir
						elseif(vert.x < 0.5) then
							vert.x = vert.x - 0.05 * dir
						end
					else
						if(vert.y > 0.5) then
							vert.y = vert.y + 0.05 * dir										
						elseif(vert.y < 0.5) then
							vert.y = vert.y - 0.05 * dir
						end
					end
				end
			end
		end		
	end
	
	
	--the m_cursorWorldDownX will keep the values of the cursor in world coordinates when 
	--the RMB was pressed on the screen, will be used for scaling sprites on the background
	if(keyHold["RBUTTON"]) then
		if editor.m_cursorWorldDownX == nil and editor.m_cursorWorldDownY == nil then
			editor.m_cursorWorldDownX = cursorWorld.x
			editor.m_cursorWorldDownY = cursorWorld.y
		end
	else
		editor.m_cursorWorldDownX = nil
		editor.m_cursorWorldDownY = nil
	end

	if keyReleased["ESCAPE"] or touchcount == 3 then

		--setGameMode(updateMenu)
		setPhysicsEnabled(false)
		physicsEnabled = false
		--setActiveMenuPage(levelSelectionEdit[currentThemeNumber])
		currentGameMode = function() end
		if g_editorPage == "folder" then
			menuManager:changeRoot(EditorFolderPage:new(currentPageNumber))
		elseif g_editorPage == "pack" then
			menuManager:changeRoot(EditorEpPage:new(currentThemeNumber, currentPageNumber))
		end
		editorJointPage:onExit()
		editorJointPage = nil
		return
	end

	if keyHold["CONTROL"] and keyPressed["S"] then
		print("derp\n")
		print("levelFolder: " .. _G.tostring(levelFolder) .. "\n")
		print("levelName: " .. _G.tostring(levelName) .. "\n")
		checkDirectories()
		saveLevel(levelFolder .. levelName)
		--levelCrypt(levelFolder, levelName)
		saveLevel(levelFolder .. "temp/" .. levelName .. ".temp")
		levelCrypt(levelFolder .. "temp/", levelName .. ".temp")
		levelSaved = true
	end

	if not keyHold["CONTROL"] and keyHold["SHIFT"] and keyPressed["C"] then
		if objects.castleCameraData == nil then
			objects.castleCameraData = {}
		end
		
		objects.castleCameraData.version = "0.02"
		objects.castleCameraData[deviceModel] = { px = screen.x,
												  py = screen.y,
												  sx = worldScale,
												  sy = worldScale,
												  screenWidth = screenWidth,
												  screenHeight = screenHeight }
		levelSaved = false
	end

	if not keyHold["CONTROL"] and keyHold["SHIFT"] and keyPressed["B"] then
		if objects.birdCameraData == nil then
			objects.birdCameraData = {}
		end
		
		objects.birdCameraData.version = "0.02"
		objects.birdCameraData[deviceModel] = { px = screen.x,
												py = screen.y,
												sx = worldScale,
												sy = worldScale,
												screenWidth = screenWidth,
												screenHeight = screenHeight }
		levelSaved = false
	end

	if (keyHold["SHIFT"] and keyPressed["P"]) or touchcount == 2 then
		setEditing(false)
		setPhysicsEnabled(false)

		local folder = levelFolder .. "temp/"
		local name = levelName .. ".temp.playtest"
		
		if(touchcount == 2) then
			folder = levelFolder
			name = levelName
		end
		
		if(touchcount ~= 2) then
			checkDirectories()
			saveLevel(folder .. name)
			levelCrypt(folder, name)
		end
		
		loadLevelInternal(folder .. name)		
		setGameMode(updateGame)
		levelSelectionPageNumber = currentThemeNumber
		currentThemeNumber = currentThemeIndex
		menuManager:changeRoot(ui.GameHud:new())
	end

	if keyPressed["TAB"] then
		physicsEnabled = not physicsEnabled
		if physicsEnabled then
			checkDirectories()
			saveLevel(levelFolder .. "temp/" .. levelName .. ".temp")
			levelCrypt(levelFolder .. "temp/", levelName .. ".temp")
		else
			loadLevelInternal(levelFolder .. "temp/" .. levelName .. ".temp")
		end
		setPhysicsEnabled(physicsEnabled)
	end

	if keyPressed["MBUTTON"] then
		if keyPressed["SHIFT"] then
			setWorldScale(1)
			worldScale = 1
		else
			setWorldScale(1)
			worldScale = 1
			screen.x = 0
			screen.y = 0
		end
	end

	-- set active theme
	if keyHold["SHIFT"] and keyPressed[blockTable.themes.settings.keyCode] and not editor.edit_particles then
		currentThemeIndex = currentThemeIndex + 1
		if currentThemeIndex > blockTable.themes.settings.themeAmount then
			currentThemeIndex = 1
		end

		for k0, v0 in _G.pairs(blockTable.themes) do
			if v0.index ~= nil and v0.index == currentThemeIndex then
				currentTheme = k0
				setTheme(currentTheme)
				-- replace all blocks that are theme dependent
				for k1, v1 in _G.pairs(objects.world) do
					v1def = blockTable.blocks[v1.definition]
					if v1def.theme ~= nil and v1def.theme ~= currentTheme then
						-- go through all block definitions to find the correct block to replace this one
						for k2, v2 in _G.pairs(blockTable.blocks) do
							-- if this block definition's group is the same as the one on the current block and the group indexes match then check the theme
							if v2.group == v1def.group and v2.groupIndex == v1def.groupIndex then
								-- does the theme match to the current theme requirements
								if v2.theme == nil or v2.theme == currentTheme then
									-- we found a replacement, update values accordingly
									v1.definition = k2
									v1.sprite = v2.sprite
									v1.damageSprite = v1.sprite
									setSprite(k1, v1.sprite)
									levelSaved = false
								end
							end
						end
					end
				end

				-- update the cursor object
				if objectToAdd ~= nil then
					updateCursorObjectAccordingToTheme()
				end
				-- replace level defines
				objects.theme = currentTheme

			end
		end
	end

	birdSelected = false
	if selectedObjects[1] ~= nil then
		if selectedObjects[1].controllable then
			birdSelected = true
			for i = 1, #numberKeys do
				if keyPressed[numberKeys[i]] then
					selectedObjects[1].startNumber = i
				end
			end
		end
	end


	-- create blocks from the blocks.lua definitions
	if keyHold["CONTROL"] == false and keyHold["SHIFT"] == false and birdSelected == false and not editor.edit_particles then
		for k, v in _G.pairs(blockTable.groups) do
			local groupDataUpdate = false
			if keyPressed[v.keyUp] then
				-- update group information
				if currentGroup == k then
					currentGroupIndex = currentGroupIndex + 1
				else
					currentGroup = k
				end
				groupDataUpdate = true
			end
			if keyPressed[v.keyDown] then
				-- update group information
				if currentGroup == k then
					currentGroupIndex = currentGroupIndex - 1
				else
					currentGroup = k
				end
				groupDataUpdate = true
			end
			-- find the next object to add based on group information
			if groupDataUpdate then
				if currentGroupIndex > blockTable.groups[currentGroup].lastIndex then
					currentGroupIndex = blockTable.groups[currentGroup].firstIndex
				end
				if currentGroupIndex < blockTable.groups[currentGroup].firstIndex then
					currentGroupIndex = blockTable.groups[currentGroup].lastIndex
				end

				--print("Searching for group " .. currentGroup .. " " .. currentGroupIndex .. "\n")
				updateCursorObjectAccordingToTheme()
			end
		end
	end

	if keyPressed["RBUTTON"] then
		if copiedObjects ~= nil then
			copiedObjects = nil
		end
		
		if objectToAdd ~= nil then
			objectToAdd = nil
		else
			if not keyHold["SHIFT"] and not keyHold["ALT"] then
				selectedObjects = { }
			end
			selectedObjectPos.x = 0
			selectedObjectPos.y = 0

			draggingStartPosWorld.x = cursorWorld.x
			draggingStartPosWorld.y = cursorWorld.y
			
			if editor.drawOneLayer then
				--find object that was clicked
				for k, v in _G.pairs(themeSpriteObjects) do
					object = v
					if object.type == "polygon" then						
						if checkPolygonObjectBounds(object.x, object.y, object.width * object.scale.x, object.height * object.scale.y, object.angle, object.vertices, cursorPhysics.x, cursorPhysics.y) then
							addObjectToSelection(object, true)
						end
					end
					if object.type == "box" then
						if checkObjectBounds( object.x, object.y, object.width * object.scale.x, object.height * object.scale.y, object.angle, cursorPhysics.x, cursorPhysics.y) then
							addObjectToSelection(object, true)
						end
					end
					if object.type == "circle" then
						local t_scale = _G.math.max(object.scale.x, object.scale.y)
						if distance(object.x, object.y, cursorPhysics.x, cursorPhysics.y) < (object.radius * t_scale) then
							addObjectToSelection(object, true)
						end
					end
				end
			else
				--find object that was clicked
				for k, v in _G.pairs(objects.world) do
					object = v
					if object.type == "polygon" then
						x = object.x
						y = object.y
						--print(object.name .. " ")
						if checkPolygonObjectBounds(x, y, object.width, object.height, object.angle, getObjectDefinition(k).vertices, cursorPhysics.x, cursorPhysics.y) then
							addObjectToSelection(object, true)
						end
					end
					if object.type == "box" then
						x = object.x
						y = object.y
						--print(object.name .. " ")
						if checkObjectBounds(x, y, object.width, object.height, object.angle, cursorPhysics.x, cursorPhysics.y) then
							addObjectToSelection(object, true)
						end
					end
					if object.type == "circle" then
						if distance(object.x, object.y, cursorPhysics.x, cursorPhysics.y) < object.radius then
							addObjectToSelection(object, true)
						end
					end
				end
			end
		end
	end

	if keyHold["RBUTTON"] and (not keyHold["CONTROL"]) then
		selectionRectActive = true
	end
	
	--scales backgrond sprites
	if keyHold["RBUTTON"] and keyHold["CONTROL"] and editor.drawOneLayer and (#selectedObjects > 0) then
		
		for k, v in _G.pairs(selectedObjects) do
			object = v
			
			local t_scaleX = 1
			local t_scaleY = 1
			
			--if the user is pressing shif, we scale both axis equally
			if(keyHold["SHIFT"]) then
				local t_oldCursorPhysicsX, t_oldCursorPhysicsY = worldToPhysicsTransform(editor.m_cursorWorldDownX, editor.m_cursorWorldDownY)
									
				local t_originalDistance = distance(v.x, v.y, t_oldCursorPhysicsX, t_oldCursorPhysicsY)
				
				local t_newDistance = distance(v.x, v.y, cursorPhysics.x, cursorPhysics.y)
				
				local t_scale = t_newDistance / t_originalDistance
				
				t_scaleX = t_scale
				t_scaleY = t_scale
			else
				local t_oldCursorPhysicsX, t_oldCursorPhysicsY = worldToPhysicsTransform(editor.m_cursorWorldDownX, editor.m_cursorWorldDownY)
									
				local t_oldDistanceX = t_oldCursorPhysicsX - v.x
				local t_oldDistanceY = t_oldCursorPhysicsY - v.y
				
				local t_newDistanceX = cursorPhysics.x - v.x
				local t_newDistanceY = cursorPhysics.y - v.y
								
				t_scaleX = t_newDistanceX / t_oldDistanceX
				t_scaleY = t_newDistanceY / t_oldDistanceY
			end
			
			modifyThemeSprite(object.name, object.x, object.y, t_scaleX, t_scaleY, object.angle, object.layer)
			
			object.scale = {x = t_scaleX, y = t_scaleY}			
			objects.themeSprites[object.name].scale = { x =  t_scaleX, y = t_scaleY}			
			
		end
		
	end
	
	-- this is here so that the dragging position is not set on this frame if LBUTTON is released
	if keyReleased["RBUTTON"] then
		if objectToAdd ~= nil and selectedObjects == nil or #selectedObjects < 1 then
			if editor.drawOneLayer then
				selectedObjects = getThemeObjectsInsideRect(draggingStartPosWorld.x, draggingStartPosWorld.y, cursorWorld.x, cursorWorld.y, editor.currentLayer)
			else 
				selectedObjects = getObjectsInsideRect(draggingStartPosWorld.x, draggingStartPosWorld.y, cursorWorld.x, cursorWorld.y)
				
			end
		else
			if keyHold["SHIFT"] then
				local tempObjects = getObjectsInsideRect(draggingStartPosWorld.x, draggingStartPosWorld.y, cursorWorld.x, cursorWorld.y)
				for k, v in _G.pairs(tempObjects) do
					addObjectToSelection(object, false)
				end
			end
			if keyHold["ALT"] then
				local tempObjects = getObjectsInsideRect(draggingStartPosWorld.x, draggingStartPosWorld.y, cursorWorld.x, cursorWorld.y)
				for k, v in _G.pairs(tempObjects) do
					for soi = 1, #selectedObjects do
						if selectedObjects[soi] == v then
							_G.table.remove(selectedObjects, soi)
							soi = #selectedObjects
						end
					end
				end				
			end
		end
		selectionRectActive = false
	end

	if keyPressed["LBUTTON"] then
		oldCursor.x = cursor.x
		oldCursor.y = cursor.y
		if not keyHold["SPACE"] then
			if objectToAdd ~= nil then
				if not editor.drawOneLayer then
					local name = createObject(blockTable, objectToAdd, nil, cursorPhysics.x, cursorPhysics.y)
					setRotation(name, objectToAddAngle)
					selectedObjects = {}
					birdSelected = false
					_G.table.insert(selectedObjects, objects.world[name])
				else
					local spr = blockTable.blocks[objectToAdd].sprite
					if not spr and blockTable.blocks[objectToAdd].damageSprites then
						spr = blockTable.blocks[objectToAdd].damageSprites.damage1
					end
					if spr then
					
						if objects.counts[objectToAdd] == nil then
							objects.counts[objectToAdd] = 0
						end
	
						objects.counts[objectToAdd] = objects.counts[objectToAdd] + 1
						local name = objectToAdd .. "_" .. objects.counts[objectToAdd]
						selectedObjects = {}
						
						addThemeSprite(name, {definition=objectToAdd, name=name, x = cursorPhysics.x, y = cursorPhysics.y, angle = 0, scale = {x=1,y=1}, layer = editor.currentLayer })
						
						if not objects.themeSprites then
							objects.themeSprites = {}
						end
						objects.themeSprites[name] = { definition = objectToAdd, 
													   name = name, x = cursorPhysics.x, 
													   y = cursorPhysics.y, layer = editor.currentLayer, 
													   angle = objectToAddAngle, scale = {x=1,y=1} }							   						
					end
				end	
			end
			if copiedObjects ~= nil then
				
				--this table will be indexed by the copied objects names, and the values
				--will be the new copies name
				local t_nameRelationTable = {}
				for k, v in _G.pairs(copiedObjects) do
					if editor.drawOneLayer then
						--print("k = "..k.." value = " ..v.definition)
						
						if objects.counts[v.definition] then
							objects.counts[v.definition] = objects.counts[v.definition] + 1						
						else
							objects.counts[v.definition] = 1			
						end
						local name = v.definition .. "_" .. objects.counts[v.definition]
						addThemeSprite(name, {definition=v.definition, name=name, x = cursorPhysics.x + v.x, y = cursorPhysics.y + v.y, angle = v.angle, scale = v.scale, layer = editor.currentLayer })
						
						if not objects.themeSprites then
							objects.themeSprites = {}
						end
						objects.themeSprites[name] = { 	definition = v.definition, 
														name = name, x = cursorPhysics.x + v.x, 
														y = cursorPhysics.y + v.y, 
														layer = editor.currentLayer, 
														angle = v.angle,
														scale = v.scale}
					else
						local name = createObject(blockTable, v.definition, nil, cursorPhysics.x + v.x, cursorPhysics.y + v.y)
						t_nameRelationTable[v.name] = name
						setRotation(name, v.angle)
						objects.world[name].strength = v.strength
					end
					
				end						
				
				--will create new joints based on the new objects
				if copiedJoints ~= nil then
					for k, v in _G.pairs(copiedJoints) do
						
						
						local t_newJointName = t_nameRelationTable[v.end1] .. t_nameRelationTable[v.end2]
						
						--makes a copy of the joint to be copied, with updated name, and1 and end2 values					
						
						t_newJoint = {}
						
						
						--distance joint
						if v.type == 1 then
							t_newJoint = { name = t_newJointName, type =  v.type, end1 = t_nameRelationTable[v.end1], end2= t_nameRelationTable[v.end2], x1=v.x1, y1=v.y1, x2=v.x2, y2=v.y2, coordType=v.coordType,collideConnected=v.collideConnected, dampingRatio=v.dampingRatio, frequency=v.frequency }
						--weld joint
						elseif v.type == 2 then
							t_newJoint = { name = t_newJointName, type =  v.type, end1 = t_nameRelationTable[v.end1], end2= t_nameRelationTable[v.end2], x1=v.x1, y1=v.y1, x2=v.x2, y2=v.y2, coordType=v.coordType,collideConnected=v.collideConnected }
						--revolute joint
						elseif v.type == 3 then
							t_newJoint = { name = t_newJointName, type =  v.type, end1 = t_nameRelationTable[v.end1], end2= t_nameRelationTable[v.end2], x1=v.x1, y1=v.y1, x2=v.x2, y2=v.y2, coordType=v.coordType,collideConnected=v.collideConnected, maxTorque=v.maxTorque,limit=v.limit,backAndForth=v.backAndForth,motorSpeed=v.motorSpeed,motor=v.motor,lowerLimit=v.lowerLimit,upperLimit=v.upperLimit }
						--prismatic joint
						elseif v.type == 4 then
							t_newJoint = { name = t_newJointName, type =  v.type, end1 = t_nameRelationTable[v.end1], end2= t_nameRelationTable[v.end2], x1=v.x1, y1=v.y1, x2=v.x2, y2=v.y2, coordType=v.coordType,collideConnected=v.collideConnected, maxTorque=v.maxTorque, limit=v.limit, backAndForth=v.backAndForth,motorSpeed=v.motorSpeed,worldAxisY=v.worldAxisY, motor=v.motor, lowerLimit=v.lowerLimit, upperLimit=v.upperLimit, worldAxisX = v.worldAxisX}
						--anihilation joint
						elseif v.type == 5 then
							t_newJoint = { name = t_newJointName, type =  v.type, end1 = t_nameRelationTable[v.end1], end2= t_nameRelationTable[v.end2], x1=v.x1, y1=v.y1, x2=v.x2, y2=v.y2, coordType=v.coordType,collideConnected=v.collideConnected, destroyTimer = v.destroyTimer}
						end					
						
						--print("\nnew joint name: " .. t_newJointName)
						createJoint(t_newJoint)
						editorJointPage.addJoint(editorJointPage, t_newJointName)
					end
				end
			end
		end
	end

	if keyHold["LBUTTON"] then
		if keyHold["SPACE"] then
			screen.x = screen.x - (cursorWorld.x - draggingStartPosWorld.x) * 0.5
			screen.y = screen.y - (cursorWorld.y - draggingStartPosWorld.y) * 0.5
		else
			if objectToAdd ~= nil then
				-- do not allow object selection if object to add is active
			elseif selectedObjects ~= nil and #selectedObjects > 0 and (not editor.drawOneLayer)then
				for k, v in _G.pairs(selectedObjects) do
					object = v
					x, y = worldToPhysicsTransform(cursor.x - oldCursor.x, cursor.y - oldCursor.y)
					x = x / worldScale
					y = y / worldScale
					setSleeping(object.name, false)
					if keyHold["CONTROL"] then
						setRotation(object.name, object.angle + (cursor.x - oldCursor.x)/180 * _G.math.pi )
					else
						setPosition(object.name, x + object.x, y + object.y)
					end
				end
				levelSaved = false
			elseif selectedObjects ~= nil and #selectedObjects > 0 and editor.drawOneLayer then
				for k, v in _G.pairs(selectedObjects) do
					object = v
					x, y = worldToPhysicsTransform(cursor.x - oldCursor.x, cursor.y - oldCursor.y)
					x = x / worldScale
					y = y / worldScale
					if keyHold["CONTROL"] then
						modifyThemeSprite(object.name, object.x, object.y, object.scale.x, object.scale.y, object.angle + (cursor.x - oldCursor.x)/180 * _G.math.pi , object.layer)
						object.angle = object.angle + (cursor.x - oldCursor.x)/180 * _G.math.pi 
						objects.themeSprites[object.name].angle = object.angle
					else
						modifyThemeSprite(object.name,  x + object.x, y + object.y, object.scale.x, object.scale.y, object.angle, object.layer)
						object.x = x + object.x
						object.y = y + object.y
						objects.themeSprites[object.name].x = object.x
						objects.themeSprites[object.name].y = object.y
					end
				end
				levelSaved = false
			end
		end
	end

	if not keyHold["LBUTTON"] and not keyHold["RBUTTON"] then
		draggingStartPosWorld.x = cursorWorld.x
		draggingStartPosWorld.y = cursorWorld.y
	end

	-- handle key input
	if selectedObjects ~= nil and #selectedObjects > 0 then
		local moveAmount = 1
		if keyHold["SHIFT"] then
			moveAmount = 10
		end	
		if keyHold["SHIFT"] and keyHold["CONTROL"] then
			moveAmount = 100
		end
		if not keyHold["SHIFT"] and keyHold["CONTROL"] then
			-- remove movement if only control pressed
			moveAmount = 0
		end
		
		if keyReleased["DELETE"] then
			if editor.drawOneLayer then
				for k, v in _G.pairs(selectedObjects) do					
					local name = v.name
					objects.themeSprites[v.name] = nil
					themeSpriteObjects[v.name] = nil
					removeThemeSprite(name, editor.currentLayer)
				end
			else
	
				for k, v in _G.pairs(selectedObjects) do
					for key, value in _G.pairs(objects.joints) do
						if value.end1 == v.name or value.end2 == v.name then
							editorJointPage:removeItem(value.name)
							editorJointPage:removeItem(value.name .. "_ANCHOR_1")
							editorJointPage:removeItem(value.name .. "_ANCHOR_2")
						end
					end
					
					local name = v.name
					objects.world[name] = nil
					removeObject(name)
				end
				
			end
			selectedObjects = {}
			levelSaved = false
		end
		if not keyHold["RETURN"] then
			local moveKeyDown = false

			if (keyHold["LEFT"] or keyHold["RIGHT"] or keyHold["UP"] or keyHold["DOWN"])then
				moveKeyDown = true
			end
			
			if blockMoveTimer == 0 or blockMoveTimer > 0.3 then
				if keyHold["LEFT"] then
					setPositions(-moveAmount, 0)
				end
				if keyHold["RIGHT"] then
					setPositions(moveAmount, 0)
				end
				if keyHold["UP"] then
					setPositions(0, -moveAmount)
				end
				if keyHold["DOWN"] then
					setPositions(0, moveAmount)
				end
			end
			
			if moveKeyDown then
				blockMoveTimer = blockMoveTimer + dt
			else
				blockMoveTimer = 0
			end		
		end
	end

	if keyHold["SHIFT"] then
		if keyPressed["R"] then
			local angle = _G.math.pi / 8
			if keyHold["CONTROL"] then
				angle = -angle
			end
			if copiedObjects ~= nil then
				local px, py, w, h = getObjectListBounds(copiedObjects)
				for k, v in _G.pairs(copiedObjects) do
	
					v.angle = v.angle + angle
					
					-- move to origin
					local cx = v.x - px
					local cy = v.y - py
					
					-- rotate around origin
					local tcx = cx * _G.math.cos(angle) - cy * _G.math.sin(angle)
					local tcy = cx * _G.math.sin(angle) + cy * _G.math.cos(angle)
	
					-- move back
					v.x = tcx + px
					v.y = tcy + py
					--print("Rotating copied object: " .. k .. "\n")
				end
			else
				if objectToAdd ~= nil then
					objectToAddAngle = objectToAddAngle + angle
				else
					if selectedObjects ~= nil and #selectedObjects > 0 then
						for k, v in _G.pairs(selectedObjects) do
							setRotation(v.name, v.angle + angle)
						end
						levelSaved = false
					end
				end
			end
		end
		
		if keyPressed["J"] then
			if #selectedObjects == 2 then
				--createJoint(selectedObjects[1].name .. selectedObjects[2].name, selectedObjects[1].name, selectedObjects[2].name, 1, 2, 0, 0, 0, 0)
				--levelSaved = false
				
				editor.newJoint = { name = selectedObjects[1].name .. selectedObjects[2].name, 
								end1 = selectedObjects[1].name, end2 = selectedObjects[2].name, type = 1,
								coordType = 2, x1 = 0, y1 = 0, x2 = 0, y2 = 0, collideConnected = false }
				editorJointPage.newJoint = true	
				levelSaved = false
				
			end
		end
	end
	
	if #selectedObjects == 2 then
		if keyPressed["F1"] then -- distance joint
			editor.newJoint = { name = selectedObjects[1].name .. selectedObjects[2].name, 
								end1 = selectedObjects[1].name, end2 = selectedObjects[2].name, type = 1,
								coordType = 2, x1 = 0, y1 = 0, x2 = 0, y2 = 0 }
			editorJointPage.newJoint = true		
		elseif keyPressed["F2"] then -- weld joint
			editor.newJoint = { name = selectedObjects[1].name .. selectedObjects[2].name, 
								end1 = selectedObjects[1].name, end2 = selectedObjects[2].name, type = 2,
								coordType = 2, x1 = 0, y1 = 0, x2 = 0, y2 = 0 }
			editorJointPage.newJoint = true	
		elseif keyPressed["F3"] then -- revolute joint
			editor.newJoint = { name = selectedObjects[1].name .. selectedObjects[2].name, 
								end1 = selectedObjects[1].name, end2 = selectedObjects[2].name, type = 3,
								coordType = 2, x1 = 0, y1 = 0, x2 = 0, y2 = 0 }
			editorJointPage.newJoint = true		
		elseif keyPressed["F4"] then -- prismatic joint
			editor.newJoint = { name = selectedObjects[1].name .. selectedObjects[2].name, 
								end1 = selectedObjects[1].name, end2 = selectedObjects[2].name, type = 4,
								coordType = 2, x1 = 0, y1 = 0, x2 = 0, y2 = 0}
			editorJointPage.items.x.visible = true
			editorJointPage.items.y.visible = true
			editorJointPage.items.x.text = editorJointPage.xTexts[1]
			editorJointPage.items.y.text = editorJointPage.yTexts[1]
			editorJointPage.newJoint = true	
		elseif keyPressed["F5"] then -- "destroy attached" -joint
			editor.newJoint = { name = selectedObjects[1].name .. selectedObjects[2].name,
								end1 = selectedObjects[1].name, end2 = selectedObjects[2].name, type = 5,
								coordType = 2, x1 = 0, y1 = 0, x2 = 0, y2 = 0								}
			editorJointPage.newJoint = true	
		end
	end
		
	if not keyHold["SHIFT"] and keyHold["CONTROL"] then		
		if keyPressed["LEFT"] or keyPressed["RIGHT"] then
			if selectedObjects ~= nil and #selectedObjects > 0 then
				local px, py, w, h = getObjectListBounds(selectedObjects)
								
				for k, v in _G.pairs(selectedObjects) do
					setPosition(v.name, px + (px - v.x), v.y)
				end
				levelSaved = false
			end			
		end
	
		if keyPressed["UP"] or keyPressed["DOWN"] then
			if selectedObjects ~= nil and #selectedObjects > 0 then
				local px, py, w, h = getObjectListBounds(selectedObjects)
								
				for k, v in _G.pairs(selectedObjects) do
					setPosition(v.name, v.x, py + (py - v.y))
				end
				levelSaved = false
			end
		end
	end
	
	if keyHold["SHIFT"] and keyHold["CONTROL"] and (keyPressed["B"] or keyPressed["HOME"]) then
		if objects.birdCameraData and objects.birdCameraData[deviceModel] ~= nil then
			screen.x = objects.birdCameraData[deviceModel].px
			screen.y = objects.birdCameraData[deviceModel].py
			worldScale = objects.birdCameraData[deviceModel].sx
			setWorldScale(worldScale)
			oldScale = worldScale
		end
	end
	
	if keyHold["SHIFT"] and keyHold["CONTROL"] and (keyPressed["C"] or keyPressed["END"]) then
		if objects.castleCameraData ~= nil and objects.castleCameraData[deviceModel]then
			screen.x = objects.castleCameraData[deviceModel].px
			screen.y = objects.castleCameraData[deviceModel].py
			worldScale = objects.castleCameraData[deviceModel].sx
			setWorldScale(worldScale)
			oldScale = worldScale
		end
	end
	
	if not keyHold["SHIFT"] and not keyHold["CONTROL"] and keyPressed["END"] then
		if objects.doNotWaitForMovingObjects ~= nil then
			objects.doNotWaitForMovingObjects = nil
		else
			objects.doNotWaitForMovingObjects = true
		end
	end
	
	if not keyHold["SHIFT"] and keyHold["CONTROL"] and keyPressed["C"] then
		copiedObjects = {}
		copiedJoints = {}
		local x, y, w, h = getObjectListBounds(selectedObjects)
		for k, v in _G.pairs(selectedObjects) do
			--print("Adding to copied objects: " .. v.name .. "\n")
			copiedObjects[v.name] = { name = v.name, definition = v.definition, x = v.x - x, y = v.y - y, angle = v.angle }
			if v.width == nil then
				copiedObjects[v.name].width = v.radius
				copiedObjects[v.name].height = v.radius
			else
				copiedObjects[v.name].width = v.width
				copiedObjects[v.name].height = v.height
			end
			
			if editor.drawOneLayer then
				copiedObjects[v.name].scale = v.scale
			end	
			
		end
		
		for k, v in _G.pairs(objects.joints) do
			--print("Current joints to check: " .. v.name .. "\n")
			
			--change the clause below to or if you want to select a joint even if you have
			--only selected one block of it
			--if isKeyInList(v.end1, copiedObjects) and isKeyInList(v.end2, copiedObjects) then
			if copiedObjects[v.end1] ~= nil and copiedObjects[v.end2] ~= nil then
				--print("this joint is going to get copied " .. v.name .. "\n")
				
				--distance joint
				if v.type == 1 then
					copiedJoints[v.name] = { type =  v.type, end1 = v.end1, end2= v.end2, x1=v.x1, y1=v.y1, x2=v.x2, y2=v.y2, coordType=v.coordType,collideConnected=v.collideConnected, dampingRatio=v.dampingRatio, frequency=v.frequency }
				--weld joint
				elseif v.type == 2 then
					copiedJoints[v.name] = { type =  v.type, end1 = v.end1, end2= v.end2, x1=v.x1, y1=v.y1, x2=v.x2, y2=v.y2, coordType=v.coordType,collideConnected=v.collideConnected }
				--revolute joint
				elseif v.type == 3 then
					copiedJoints[v.name] = { type =  v.type, end1 = v.end1, end2= v.end2, x1=v.x1, y1=v.y1, x2=v.x2, y2=v.y2, coordType=v.coordType,collideConnected=v.collideConnected, maxTorque=v.maxTorque,limit=v.limit,backAndForth=v.backAndForth,motorSpeed=v.motorSpeed,motor=v.motor,lowerLimit=v.lowerLimit,upperLimit=v.upperLimit }
				--prismatic joint
				elseif v.type == 4 then
					copiedJoints[v.name] = { type =  v.type, end1 = v.end1, end2= v.end2, x1=v.x1, y1=v.y1, x2=v.x2, y2=v.y2, coordType=v.coordType,collideConnected=v.collideConnected, maxTorque=v.maxTorque, limit=v.limit, backAndForth=v.backAndForth,motorSpeed=v.motorSpeed,worldAxisY=v.worldAxisY, motor=v.motor, lowerLimit=v.lowerLimit, upperLimit=v.upperLimit, worldAxisX = v.worldAxisX}
				--anihilation joint
				elseif v.type == 5 then
					copiedJoints[v.name] = { type =  v.type, end1 = v.end1, end2= v.end2, x1=v.x1, y1=v.y1, x2=v.x2, y2=v.y2, coordType=v.coordType,collideConnected=v.collideConnected, destroyTimer = v.destroyTimer}
				end
			end
			
		end
		--the loop below is for selecting blocks that were left off from the selection
		--but are connected to a joint that is connected to a selected block. 
		--uncomment it out if needed later
		--[[
		for k, v in _G.pairs(copiedJoints) do
			--print("this joint will be copied: " .. k .. "\n")
			
			
			
			if (not isKeyInList(v.end1, copiedObjects)) then
				--print("this object is not selected, but will be copied " .. v.end1 .. "\n")				
				
				copiedObjects[v.end1] = { name = v.end1, definition = objects.world[v.end1].definition, x = objects.world[v.end1].x - x, y = objects.world[v.end1].y - y, angle = objects.world[v.end1].angle, strength=objects.world[v.end1].strength }
				if objects.world[v.end1].width == nil then
					copiedObjects[v.end1].width = objects.world[v.end1].radius
					copiedObjects[v.end1].height = objects.world[v.end1].radius
				else
					copiedObjects[v.end1].width = objects.world[v.end1].width
					copiedObjects[v.end1].height = objects.world[v.end1].height
				end
			
			elseif (not isKeyInList(v.end2, copiedObjects)) then
				--print("this object is not selected, but will be copied " .. v.end1 .. "\n")				
				
				copiedObjects[v.end2] = { name = v.end2, definition = objects.world[v.end2].definition, x = objects.world[v.end2].x - x, y = objects.world[v.end2].y - y, angle = objects.world[v.end2].angle, strength=objects.world[v.end2].strength }
				if objects.world[v.end2].width == nil then
					copiedObjects[v.end2].width = objects.world[v.end2].radius
					copiedObjects[v.end2].height = objects.world[v.end2].radius
				else
					copiedObjects[v.end2].width = objects.world[v.end2].width
					copiedObjects[v.end2].height = objects.world[v.end2].height
				end
			end
			
		end
		]]--
		
		--for k, v in _G.pairs(copiedObjects) do
		--	print("Final objects to copy: " .. v.name .. "\n")
		--end
		
		selectedObjects = {}
	end
	
	if (keyHold["CONTROL"] and keyPressed["P"]) or (editor.edit_particles and keyPressed["RETURN"]) then
		editor.edit_particles = not editor.edit_particles
		if editor.particle_amount == nil then
			if objects.levelParticles and objects.levelParticles.settingsFrame and objects.levelParticles.settingsFrame.amount then
				editor.particle_amount = objects.levelParticles.settingsFrame.amount
			else
				editor.particle_amount = 0
			end
		end
		if editor.particle_type == nil then
			editor.particle_type = 0
			if objects.levelParticles and objects.levelParticles.particles then
				local p = objects.levelParticles.particles
				if particleTable.particles[p] then
					for k, v in _G.ipairs(particleTable.levelParticles) do
						if v == p then
							editor.particle_type = k
						end
					end
				end
			end
		end
	end
	
	if editor.edit_particles and not keyHold["CONTROL"] then
		local refreshParticleData = function()
			if editor.particle_amount > 0 and editor.particle_type > 0 then
				objects.levelParticles =
				{
					settingsBegin =
					{
						ignoreLimits = false,
						amount = editor.particle_amount * 10,
					},
					settingsFrame =
					{
						ignoreLimits = false,
						amount = editor.particle_amount,
					},
					particles = particleTable.levelParticles[editor.particle_type]
				}
			else
				objects.levelParticles = nil
			end
		end
	
		if keyPressed["M"] then
			editor.particle_amount = editor.particle_amount + 1
			refreshParticleData()
		end
		if keyPressed["L"] then
			if editor.particle_amount > 0 then
				editor.particle_amount = editor.particle_amount - 1
				refreshParticleData()
			end
		end
		if keyPressed["T"] then
			editor.particle_type = editor.particle_type + 1
			if editor.particle_type > #particleTable.levelParticles then
				editor.particle_type = 0
			end
			refreshParticleData()
		end
		if keyPressed["D"] then
			editor.particle_amount = 0
			editor.particle_type = 0
			refreshParticleData()
		end
	end
	
	if keyPressed["0"] then
		editor.drawOneLayer = not editor.drawOneLayer
		selectedObjects = {}
		copiedObjects = {}
		copiedJoints = {}
		objectToAdd = nil
	end
	
	defaultCamera(dt)

	oldCursor.x = cursor.x
	oldCursor.y = cursor.y	
	
--	drawGame()
	for k, v in _G.pairs(objects.joints) do
		if v.backAndForth then
			checkJointLimits(v.name)
		end
	end
	
	if editor.drawOneLayer and keyHold["CONTROL"] and cursor.wheelTriggered then
		editor.currentLayer = editor.currentLayer - cursor.wheel
		local maxLayer = #blockTable.themes[objects.theme].bgLayers + #blockTable.themes[objects.theme].fgLayers 
		if editor.currentLayer >= maxLayer then
			editor.currentLayer = 0
		elseif editor.currentLayer < 0 then
			editor.currentLayer = maxLayer - 1
		end
	end
	
	editorJointPage:update(dt)
	drawEditor()
	editorJointPage:draw()
	
	if cursor.wheelTriggered then
		cursor.wheelTriggered = false
	end
	

	
end

function drawEditor()
	
	local wScale = worldScale
	
	setRenderState(0, 0, 1, 1, 0)
	
	if editor.drawOneLayer then
		drawLayer(editor.currentLayer)				
		
		--draws selected objects on current layer
		for k, v in _G.pairs(selectedObjects) do										
			if v.definition ~= nil and v.definition ~= "" then
				local w, h = _G.res.getSpriteBounds("", blockTable.blocks[v.definition].sprite)
				w, h = w * v.scale.x, h * v.scale.y
				w, h = w * 0.5, h * 0.5
				local x, y = physicsToWorldTransform(v.x, v.y)
				local x1, y1 = x - w, y - h
				local x2, y2 = x + w, y + h
				local t_pivotX, t_pivotY = _G.res.getSpritePivot("", blockTable.blocks[v.definition].sprite)
				t_pivotX, t_pivotY = t_pivotX * v.scale.x, t_pivotY * v.scale.y
				--setRenderState(-screen.left, -screen.top, worldScale, worldScale, 0, 0, 0)
				setRenderState(	-screen.left, -screen.top, worldScale, worldScale, 
								v.angle, t_pivotX, t_pivotY)
				drawRect(1, 0, 0, 0.5, x1, y1, x2, y2, true)
			end			
		end
		
		if copiedObjects ~= nil then
			for k, v in _G.pairs(copiedObjects) do
				local sprite = blockTable.blocks[v.definition].sprite
				local blockDefScale = blockTable.blocks[v.definition].scale or 1
				local pivotX, pivotY = 0, 0
				local flip = 1
				if blockTable.blocks[v.definition].horFlip then
					flip = -flip
				end

				pivotX, pivotY = _G.res.getSpritePivot(sprite)
				--setRenderState(-screen.left, -screen.top, worldScale * v.scale.x, worldScale * v.scale.y, v.angle, res.getSpritePivot("", sprite))
				setRenderState(flip * -screen.left / (v.scale.x * blockDefScale), -screen.top / (v.scale.y * blockDefScale), flip * worldScale * v.scale.x, worldScale * v.scale.y, flip * v.angle, pivotX, pivotY)
				
				local x, y = physicsToWorldTransform(v.x + cursorPhysics.x, v.y + cursorPhysics.y)
				
				x, y = flip * x / v.scale.x, y / v.scale.y
				
				_G.res.drawSprite(sprite, _G.math.floor(x), _G.math.floor(y))
			end
			setRenderState(0, 0, 1, 1, 0)
		end		
		
		setRenderState(0, 0, 1, 1, 0)	
		
	else
		--this call will draw all in game elements
		drawGame()
		
		if keyHold["L"] then
			for k, v in _G.pairs(objects.world) do
				if v.startNumber then
					local sprite = blockTable.blocks[v.definition].sprite
					local blockDefScale = blockTable.blocks[v.definition].scale or 1
					local pivotX, pivotY = _G.res.getSpritePivot(sprite)
					setRenderState(-screen.left / blockDefScale, -screen.top / blockDefScale, worldScale, worldScale , v.angle, pivotX, pivotY)
					local x, y = physicsToWorldTransform(v.x, v.y)
					_G.res.drawString("TEXTS_BASIC", "" .. v.startNumber, x, y, "HCENTER", "VCENTER")
				end
			end
			setRenderState(0, 0, 1, 1, 0)
		end
	end
	
	
	setRenderState(0, 0, 1, 1, 0)
	_G.res.drawString("TEXTS_BASIC", levelName, 0, 0, "TOP", "LEFT")

	if selectionRectActive then
		local x1, y1 = draggingStartPosWorld.x, draggingStartPosWorld.y
		local x2, y2 = cursorWorld.x, cursorWorld.y
		if x1 > x2 then	x1, x2 = x2, x1	end
		if y1 > y2 then	y1, y2 = y2, y1	end
		setRenderState(-screen.left, -screen.top, wScale, wScale, 0)
		drawRect(1, 0, 0, 0.5, x1, y1, x2, y2, true)
	end		

	setRenderState(0, 0, 1, 1, 0)
	if not editor.drawOneLayer then
		for k, v in _G.pairs(objects.joints) do
			drawJoint(v, "EDITOR_JOINT")
		end
	end
	
	if selectedObjects[1] ~= nil then
		if selectedObjects[1].controllable then
			if selectedObjects[1].startNumber ~= nil then
				_G.res.drawString("TEXTS_BASIC", "Start: " .. selectedObjects[1].startNumber, 0, 35, "TOP", "LEFT")
			end
		end
	end

	for k, v in _G.pairs(selectedObjects) do
		if v.sprite ~= nil and v.sprite ~= "" then
			local w, h = _G.res.getSpriteBounds("", v.sprite)
			w, h = w*0.5, h*0.5
			local x, y = physicsToWorldTransform(v.x, v.y)
			local x1, y1 = x - w, y - h
			local x2, y2 = x + w, y + h
			setRenderState(-screen.left, -screen.top, wScale, wScale, v.angle, v.spritePivotX, v.spritePivotY)
			drawRect(1, 0, 0, 0.5, x1, y1, x2, y2, true)
		end
	end
	
	if physicsEnabled then
		for k, v in _G.pairs(objects.world) do
			if v.sleeping == true and v.sprite ~= "" then
				local w, h = _G.res.getSpriteBounds("", v.sprite)
				w, h = w*0.5, h*0.5
				local x, y = physicsToWorldTransform(v.x, v.y)
				local x1, y1 = x - w, y - h
				local x2, y2 = x + w, y + h
				setRenderState(-screen.left, -screen.top, wScale, wScale, v.angle, v.spritePivotX, v.spritePivotY)
				drawRect(1, 0, 0, 0.5, x1, y1, x2, y2, true)
			end
		end
	end
	
	-- Draw small rect to indicate origin
	if keyHold["O"] then
		setRenderState(-screen.left*wScale, -screen.top*wScale, 1, 1, 0, 0, 0)
	else
		setRenderState(-screen.left, -screen.top, wScale, wScale, 0, 0, 0)
	end
	_G.res.drawSprite("", "ORIGO", 0, 0)
	setRenderState(0, 0, 1, 1, 0)

	if objectToAdd ~= nil then
		local sprite = blockTable.blocks[objectToAdd].sprite
		setRenderState(-screen.left, -screen.top, wScale, wScale, objectToAddAngle, _G.res.getSpritePivot("", sprite))
		_G.res.drawSprite("", sprite, _G.math.floor(cursorWorld.x), _G.math.floor(cursorWorld.y))
		setRenderState(0, 0, 1, 1, 0)
	end
	
	if not editor.drawOneLayer then
		if copiedObjects ~= nil then
			for k, v in _G.pairs(copiedObjects) do
				local sprite = objects.world[v.name].sprite
				local blockDefScale = blockTable.blocks[v.definition].scale or 1
				local pivotX, pivotY = 0, 0
				local flip = 1
				if blockTable.blocks[v.definition].horFlip then
					flip = -flip
				end
				pivotX, pivotY = _G.res.getSpritePivot(sprite)
				setRenderState(flip * -screen.left / blockDefScale, -screen.top / blockDefScale, flip * worldScale * blockDefScale, worldScale * blockDefScale, flip * v.angle, pivotX, pivotY)
				local x, y = physicsToWorldTransform(v.x + cursorPhysics.x, v.y + cursorPhysics.y)
				x, y = flip * x / blockDefScale, y / blockDefScale
				_G.res.drawSprite(sprite, _G.math.floor(x), _G.math.floor(y))
			end
			
			setRenderState(0, 0, 1, 1, 0)
		end
		
		if levelSaved then
			_G.res.drawSprite("", "EDITOR_SAVED", screenWidth, 0)
		else
			_G.res.drawSprite("", "EDITOR_NOT_SAVED", screenWidth, 0)
		end

		if physicsEnabled then
			_G.res.drawSprite("", "EDITOR_PHYSICS_ON", screenWidth, 0)
		else
			_G.res.drawSprite("", "EDITOR_PHYSICS_OFF", screenWidth, 0)
		end

		if objects.castleCameraData and objects.castleCameraData[deviceModel] then
			_G.res.drawSprite("", "EDITOR_C_CAMERA_ON", screenWidth, 0)
		else
			_G.res.drawSprite("", "EDITOR_C_CAMERA_OFF", screenWidth, 0)
		end

		if objects.birdCameraData and objects.birdCameraData[deviceModel] then
			_G.res.drawSprite("", "EDITOR_B_CAMERA_ON", screenWidth, 0)
		else
			_G.res.drawSprite("", "EDITOR_B_CAMERA_OFF", screenWidth, 0)
		end
		
		if objects.doNotWaitForMovingObjects ~= nil then
			_G.res.drawString("", "QUICK END", screenWidth, screenHeight, "BOTTOM", "RIGHT")
		end
	end
	
	if editor.edit_particles then
	
		local type = "<none>"
		if editor.particle_type > 0 then
			type = particleTable.levelParticles[editor.particle_type]
		end
	
		_G.res.drawString("", "LEVEL PARTICLES - (D)ELETE", 50, 50, "TOP", "LEFT")
		_G.res.drawString("", "(T)YPE: " .. type, 75, 100, "TOP", "LEFT")
		_G.res.drawString("", "AMOUNT: " .. editor.particle_amount .. " (M)ore/(L)ess", 75, 150, "TOP", "LEFT")
	end

end

selectedObjectsAreaCoords = nil
function drawSelectedObjectsArea()
	-- draw box of selected items
	if(selectedObjects ~= nil and #selectedObjects > 1) then
		
		local val = 9999999999
		local minX = val local minY = val local maxX = -val local maxY = -val		

		
		for k,v in _G.pairs(selectedObjects) do
			
			local points = getBoundingBox(v)
			
			local w = points.x2 - points.x1
			local h = points.y2 - points.y1
			
			
			minX = _G.math.min(minX, v.x - w / 2)
			minY = _G.math.min(minY, v.y - h / 2)

			maxX = _G.math.max(maxX, v.x + w / 2)
			maxY = _G.math.max(maxY, v.y + h / 2)
			
		end		

		if(selectedObjectsAreaCoords == nil or keyHold["LBUTTON"]) then
			selectedObjectsAreaCoords = {}
			selectedObjectsAreaCoords.x1 = minX
			selectedObjectsAreaCoords.y1 = minY
			selectedObjectsAreaCoords.x2 = maxX
			selectedObjectsAreaCoords.y2 = maxY				
		end
		
		local worldMinX, worldMinY = physicsToWorldTransform(selectedObjectsAreaCoords.x1, selectedObjectsAreaCoords.y1)
		local worldMaxX, worldMaxY = physicsToWorldTransform(selectedObjectsAreaCoords.x2, selectedObjectsAreaCoords.y2)
		drawWireFrameRect(worldMinX,worldMinY,worldMaxX,worldMaxY,3,true,255,0,255,255,0,0.5,0.5)
		
	else
		selectedObjectsAreaCoords = nil
	end	
end

function getBoundingBox(object)
	local w,h = _G.res.getSpriteBounds(object.sprite)
	w,h = worldToPhysicsTransform(w,h)
	local x1 = object.x - w / 2
	local y1 = object.y - h / 2

	local x2 = object.x + w / 2
	local y2 = object.y - h / 2

	local x3 = object.x + w / 2
	local y3 = object.y + h / 2

	local x4 = object.x - w / 2
	local y4 = object.y + h / 2

	local _x1 = object.x - x1
	local _y1 = object.y - y1
	local _x2 = object.x - x2
	local _y2 = object.y - y2
	local _x3 = object.x - x3
	local _y3 = object.y - y3
	local _x4 = object.x - x4 
	local _y4 = object.y - y4	
	
	local an = object.angle
	local cosinus = _G.math.cos(an)
	local sinus = _G.math.sin(an)
	
	local __x1 = _x1 * cosinus - _y1 * sinus + object.x
	local __y1 = _x1 * sinus + _y1 * cosinus + object.y
	local __x2 = _x2 * cosinus - _y2 * sinus + object.x
	local __y2 = _x2 * sinus + _y2 * cosinus + object.y
	local __x3 = _x3 * cosinus - _y3 * sinus + object.x
	local __y3 = _x3 * sinus + _y3 * cosinus + object.y
	local __x4 = _x4 * cosinus - _y4 * sinus + object.x
	local __y4 = _x4 * sinus + _y4 * cosinus + object.y

	local minx = _G.math.min(_G.math.min(__x1,__x2), _G.math.min(__x3,__x4))
	local maxx = _G.math.max(_G.math.max(__x1,__x2), _G.math.max(__x3,__x4))
	
	local miny = _G.math.min(_G.math.min(__y1,__y2), _G.math.min(__y3,__y4))
	local maxy = _G.math.max(_G.math.max(__y1,__y2), _G.math.max(__y3,__y4))
	
	return {x1 = minx, y1 = miny, x2 = maxx, y2 = maxy}	
end

function drawCircle(x,y,radius, angle,r,g,b,a,w)
	local points = {}
					
	for i = 0,_G.math.pi * 2,0.5 do
			local px = _G.math.cos(i) * physicsToWorldTransform(radius,0)
			local py = _G.math.sin(i) * physicsToWorldTransform(radius,0)
			local point = {x + px, y +py}						
			_G.table.insert(points,point)							
	end
	
	drawPolygon(points,w, true,r,g,b,a,angle,0.5,0.5)	
end


function drawPolygon(points,lineW,inWorld,r,g,b,a,angle,pivotX,pivotY)
	local wScale = worldScale
	
	if tempWorldScale ~= nil then
		wScale = tempWorldScale
	end
	
	wScale = wScale or 1
	
	-- Add the last one again to complete polygon.	
	_G.table.insert(points, points[1])

	pivotX = pivotX or 0.5
	pivotY = pivotY or 0.5
	
	local temp = 99999999
	local w = 0
	local h = 0
	local minX = temp
	local maxX = -temp
	local minY = temp
	local maxY = -temp
	
	-- find bounds
	for k,v in _G.pairs(points) do

		minX = _G.math.min(minX, points[k][1])
		minY = _G.math.min(minY, points[k][2])
			
		maxX = _G.math.max(maxX, points[k][1])
		maxY = _G.math.max(maxY, points[k][2])			
	end
	
	local w = (maxX - minX) 
	local h = (maxY - minY) 

	local px = pivotX * w
	local py = pivotY * h
	
	-- draw polygon
	for k,v in _G.pairs(points) do
		if(k > 1) then
			
			local x1 = points[k-1][1]
			local y1 = points[k-1][2]
			
			local x2 = points[k][1]
			local y2 = points[k][2]
			
			-- calculate rotation pivot
			local rotatePivotX = (minX + px) - x1   
			local rotatePivotY = (minY + py) - y1 			
			
			setRenderState(-screen.left, -screen.top, wScale, wScale, angle, rotatePivotX, rotatePivotY)
			drawLine(r,g,b,a,x1,y1,x2,y2,inWorld,lineW)		
		end
	end	
end


function drawWireFrameRect(x1,y1,x2,y2,lineW, inWorld,r,g,b,a,angle,pivotX, pivotY)
	local points = {{x1,y1}, {x2,y1}, {x2,y2},{x1,y2}}
	drawPolygon(points,lineW, inWorld,r,g,b,a,angle,pivotX,pivotY)
end

--void GameLua::drawLine2D(float x0, float y0, float x1, float y1, float w, float r, float g, float b, float a)
function drawLine(r,g,b,a,x1,y1,x2,y2,inWorld, lineSize)
	local lz = lineSize or 1
	
	if(inWorld == false) then
		setRenderState(0,0,1,1)
	end
	
	drawLine2D(x1,y1,x2,y2,lz,r,g,b,a)
end

function drawString(text, scale,x,y, anchorX, anchorY, inWorld)
	local ax = anchorX or "HCENTER"
	local ay = anchorY or "VCENTER"
	
	--void GameLua::drawRect( float r, float g, float b, float a, float x1, float y1, float x2, float y2, bool inWorld)
	--drawRect(1.0,1.0,1.0,1.0, 0,screenHeight / 2 + 1, screenWidth, screenHeight / 2 , false)
	--drawLine(255,255,255,255,0,0, screenWidth, screenHeight, false, 12)
	setFont(fontBasic);
	--setRenderState(x * scale, y * scale, scale,scale)
	if(inWorld ~= true) then
		setRenderState(0, 0 , scale,scale)	
		_G.res.drawString("", text, x * ((screenWidth / scale) / screenWidth), y * ((screenHeight / scale) / screenHeight), ay, ax)
	else
		local xp,yp = worldToScreenTransform(x,y)
		scale = scale * worldScale
		setRenderState(0,0,scale,scale,0,0)	
		_G.res.drawString("", text, xp * ((screenWidth / scale) / screenWidth), yp * ((screenHeight / scale) / screenHeight), ay, ax)
	end
	setRenderState(0,0,1,1)
end

function initCollisionDummy(selectedObject)
	local name = selectedObject.name
	--local name = selectedObjects[1].name
	local selected = objects.world[name]
	local blockDef = blockTable.blocks[selected.definition]
	local dir = 1
			
	adjustedBlockDef = adjustedBlockDef or {}
	adjustedBlockDef.objectNames = adjustedBlockDef.objectNames or {}
	
	adjustedBlockDef.objectNames[name] = adjustedBlockDef.objectNames[name] or {}
			-- Initialize dummy
	if(adjustedBlockDef.objectNames[name].radius == nil and blockDef.radius) then
		adjustedBlockDef.objectNames[name].radius = blockDef.radius			
	end
    
	if(adjustedBlockDef.objectNames[name].spritePivotX == nil and blockDef.spritePivotX) then
		adjustedBlockDef.objectNames[name].spritePivotX = blockDef.spritePivotX			
	end
    
	if(adjustedBlockDef.objectNames[name].spritePivotY == nil and blockDef.spritePivotY) then
		adjustedBlockDef.objectNames[name].spritePivotY = blockDef.spritePivotY			
	end
				
	if(adjustedBlockDef.objectNames[name].width == nil and blockDef.width) then
		adjustedBlockDef.objectNames[name].width = blockDef.width			
	end

	if(adjustedBlockDef.objectNames[name].height == nil and blockDef.height) then
		adjustedBlockDef.objectNames[name].height = blockDef.height			
	end
			
	if(adjustedBlockDef.objectNames[name].vertices == nil and blockDef.vertices ~= nil) then
		--adjustedBlockDef.objectName.height = blockDef.height			
		adjustedBlockDef.objectNames[name].vertices = {}
		for k,v in _G.pairs(blockDef.vertices) do					
			_G.table.insert(adjustedBlockDef.objectNames[name].vertices, {x = v.x, y = v.y})
		end
	end
end

function alignObjects(dir)
	
	local xDir = 0
	local yDir = 0
	
	if(dir == "DOWN") then
		yDir = -1		
	elseif(dir == "UP") then
		yDir = 1
	elseif(dir == "LEFT") then
		xDir = -1
	elseif(dir == "RIGHT") then
		xDir = 1
	end
	
	
	if(selectedObjects ~= nil and #selectedObjects > 1) then
		-- sort selected objects according to direction
		if(dir == "DOWN") then _G.table.sort( selectedObjects, function(a,b) return a.y > b.y end )	end	
		if(dir == "UP") then _G.table.sort( selectedObjects, function(a,b) return a.y < b.y end )	end	
		if(dir == "LEFT") then _G.table.sort( selectedObjects, function(a,b) return a.x < b.x end )	end	
		if(dir == "RIGHT") then _G.table.sort( selectedObjects, function(a,b) return a.x > b.x end )	end	
		
		
		for i = 1, #selectedObjects do
			local sel = selectedObjects[i]
			cBox1 = getBoundingBox(sel)			
			local w = cBox1.x2 - cBox1.x1
			local h = cBox1.y2 - cBox1.y1
			
			-- insert to initial position
			if(yDir == 1) then
				setPosition(sel.name, sel.x,  selectedObjectsAreaCoords.y1 +  h / 2)									
			elseif(yDir == -1) then
				setPosition(sel.name, sel.x,  selectedObjectsAreaCoords.y2 - h / 2)									
			elseif(xDir == 1) then 
				setPosition(sel.name, selectedObjectsAreaCoords.x2 - w / 2,  sel.y)									
			elseif(xDir == -1) then 
				setPosition(sel.name, selectedObjectsAreaCoords.x1 + w / 2 ,  sel.y)									
			end
			
			local val = 99999999999999
			local mincX = val
			local maxcX = -val
			local mincY = val
			local maxcY = -val
			local collided = false
			-- collision checks					
			for j = 1, i do
				-- for boxes that won't move anymore
				local sel2 = selectedObjects[j]							
				cBox2 = getBoundingBox(sel2)
				
				if(sel2 ~= sel) then
					local collideArea = nil
					if(xDir ~= 0) then
						collideArea = checkCollide(cBox1,cBox2,1)					
					else
						collideArea = checkCollide(cBox1,cBox2,0)					
					end
					if(collideArea ~= nil) then 				
						mincX = _G.math.min(cBox2.x1, mincX)
						maxcX = _G.math.max(cBox2.x2, maxcX)
						mincY = _G.math.min(cBox2.y1, mincY)
						maxcY = _G.math.max(cBox2.y2, maxcY)
						collided = true
					end		
				end					
			end
			
			if(collided == true) then
				local ww,hh = worldToPhysicsTransform(1,1)
				if(xDir ~=0) then
					local w = cBox1.x2 - cBox1.x1
					local xp = 0
					if(xDir == -1) then
						xp = maxcX
					else
						xp = mincX
					end
					setPosition(sel.name, xp + (ww + w / 2) * -xDir, sel.y)														
				else
					local h = cBox1.y2 - cBox1.y1
					local yp = 0
					if(yDir == 1) then
						yp = maxcY
					else
						yp = mincY
					end
					setPosition(sel.name, sel.x, yp + (hh + h / 2) * yDir)														
				end
			end
		end			
	end	
end

function checkCollide(object1, object2, dir) 
    local left1 = object1.x1
    local left2 = object2.x1
    local right1 = object1.x2
    local right2 = object2.x2
    local top1 = object1.y1
    local top2 = object2.y1
    local bottom1 = object1.y2
    local bottom2 = object2.y2
	
	if(dir == 1) then
		if (bottom1 < top2) then return nil end;
		if (top1 > bottom2) then return nil end;	
	end
  
	if(dir == 0) then
		if (right1 < left2) then return nil end;
		if (left1 > right2) then return nil end;	
	end

	return true

end

function drawDummyCollisionBox(object)
	
	if showSleepingObjects == true then
		local objectName = object.name
			
		if(objectName ~= nil and adjustedBlockDef ~= nil and adjustedBlockDef.objectNames[objectName] ~= nil) then
			local selected = objects.world[objectName]
			local blockDef = adjustedBlockDef.objectNames[objectName]
			
			local x, y = physicsToWorldTransform(selected.x, selected.y)
			--local w, h = _G.res.getSpriteBounds("", v.sprite)
			local w, h = _G.res.getSpriteBounds("", selected.sprite)

			
			
			local radius = adjustedBlockDef.objectNames[objectName].radius 
			local width = adjustedBlockDef.objectNames[objectName].width 
			local height = adjustedBlockDef.objectNames[objectName].height 
			local vertices = adjustedBlockDef.objectNames[objectName].vertices 
					
			if(radius ~= nil) then
				drawCircle(x,y,radius, selected.angle,255,0,255,255,2)
				drawString(""..radius, 0.5, x,y, nil,nil, true)
			elseif(width ~= nil and height ~= nil) then
					local ww, hh = physicsToWorldTransform(width, height) 
					local x1, y1 = x - ww / 2, y - hh / 2
					local x2, y2 = x + ww / 2, y + hh / 2					
					local pivX = object.spritePivotX / (w ) 
					local pivY = object.spritePivotY / (h )
					drawWireFrameRect(x1,y1,x2,y2,1,true,255,0,255,255,selected.angle,pivX, pivY)					
					drawString("w="..width .." h="..height, 0.5, x,y, nil,nil, true)
			
			elseif(vertices ~= nil) then
				local points = {}
					
				for kk,vv in _G.pairs(blockDef.vertices) do
					local wx,wy = w * vv.x, h  * vv.y 
					local point = {x + (wx) - w / 2, y + (wy) - h / 2}
					_G.table.insert(points,point)
				end					
				drawPolygon(points,2, true,255,0,255,255,object.angle,0.5,0.5)					

				for kk,vv in _G.pairs(blockDef.vertices) do
					local wx,wy = w * vv.x, h  * vv.y 
					local xString = _G.string.format("%.2f", (vv.x))
					local yString = _G.string.format("%.2f", (vv.y))
					drawString("("..xString.."/"..yString..")", 0.1, x + wx - w / 2,y + wy - h / 2, nil,nil, true)
				end					
			end				
		end
	end
end

function drawJoint(joint, sprite)
	if joint.x1 == nil then
		return
	end
	
	local jointWorldX1 = joint.x1
	local jointWorldY1 = joint.y1
	local jointWorldX2 = joint.x2
	local jointWorldY2 = joint.y2
	
	if joint.coordType == 2 then
		jointWorldX1, jointWorldY1 = getWorldPoint(joint.end1, jointWorldX1, jointWorldY1);
		jointWorldX2, jointWorldY2 = getWorldPoint(joint.end2, jointWorldX2, jointWorldY2);
	end
	
	local xdif = jointWorldX2 - jointWorldX1
	local ydif = jointWorldY2 - jointWorldY1
	local tlen = vLength(xdif, ydif)
	local x = 0
	local y = 0

	--print(k .. " " .. tlen .. " " .. vLength(x, y) .."\n")
	if tlen == 0 then
		return
	end

	local vlen = 0
	while vlen <= tlen do
		sx, sy = physicsToScreenTransform(jointWorldX1 + x, jointWorldY1 + y )
		_G.res.drawSprite("", sprite, sx, sy)
		x = x + xdif * 0.13
		y = y + ydif * 0.13
		vlen = vLength(x, y)
		--print("vlen: " .. vlen .. " tlen: " .. tlen .. "\n")
	end
end


filename = "editor.lua"
