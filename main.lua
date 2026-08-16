print("[ArchipelagoMod] Mod loaded!\n")
local AP = require "lua-apclientpp"
local UEHelpers = require "UEHelpers"
local receiving = require "receiving"
local sending = require "sending"
print("[ArchipelagoMod] Mod initalized!\n")

local game_name = "Stray"
local client_version = {0, 6, 7}
local version = "v0.0.3"
local compatable_versions = {"v0.0.1", "v0.0.2", "v0.0.3"}
local message_format = AP.RenderFormat.TEXT
local uuid = ""
---@type APClient
ap = nil
pending_game_actions = {}
all_received_items = {}
slot_data = {}
APMessageFeed = nil
currentGameProgression = 0

-- USEFUL COMMANDS:
-- ap:Say("Hello!") -> Sends a chat message to the server
-- ap:ConnectUpdate(nil, {"Lua-APClientPP", "DeathLink"}) -> Changes server tags, like enabling/disabling deathlink
-- ap:LocationChecks({64000, 64001, 64002}) -> Mark locations as checked
-- most other common packets have similar commands
-- ap.missing_locations -> returns a table of all missing location IDs
-- ap.checked_locations -> returns a table of all checked location IDs
-- ap:get_players() -> returns all players as the Player object, which includes slot and name
-- ap:get_player_game(player.slot) -> returns a string of the game that player is playing

function connect(server, slot, password)
    function on_socket_connected()
        print("[ArchipelagoMod] Socket connected\n")
        table.insert(pending_game_actions, {
            type = "message",
            text = "Connecting..."
        })
    end

    function on_socket_error(msg)
        print("[ArchipelagoMod] Socket error: " .. msg .. "\n")
        table.insert(pending_game_actions, {
            type = "message",
            text = "Connection Error: " .. msg
        })
    end

    function on_socket_disconnected()
        print("[ArchipelagoMod] Socket disconnected\n")
        table.insert(pending_game_actions, {
            type = "message",
            text = "Disconnected from Archipelago."
        })
        disconnect()
    end

    function on_room_info()
        print("[ArchipelagoMod] Received room info, attempting connection...\n")
        ap:ConnectSlot(slot, password or "", 7, {"Lua-APClientPP"}, client_version)
    end

    function on_slot_connected(data)
        slot_data = data -- make global variable
        -- ap:get_item_name and ap:get_location_name for all datapackages

        if ap:get_game() == "Stray" then
            -- ap:get_item_name and ap:get_location_name for local datapackage
        end

        print("[ArchipelagoMod] Slot connected. Slot data:\n")
        print("[ArchipelagoMod] APWorldVersion: " .. tostring(slot_data.APWorldVersion) .. "\n")
        local compatable = false
        for _, compat_version in ipairs(compatable_versions) do
            if slot_data.APWorldVersion == compat_version then
                compatable = true
                break
            end
        end
        if compatable == false then
            local message = "AP version mismatch! These two versions are not compatable! Server is " .. tostring(slot_data.APWorldVersion) .. ", Client is " .. tostring(version)
            print("[ArchipelagoMod]" .. message .. ". Disconnecting.\n")
            os.execute("msg * " .. message) -- displays an os-specific message box popup
            AddMessageToAPFeed("Force disconnecting due to version mismatch.")
            disconnect() -- force disconnect
        end
        if slot_data.APWorldVersion ~= version and compatable == true then
            local message = "Minor AP version mismatch! These two versions should be compatable, but proceed with caution. Server is " .. tostring(slot_data.APWorldVersion) .. ", Client is " .. tostring(version)
            print("[ArchipelagoMod]" .. message .. ".\n")
            os.execute("msg * " .. message) -- displays an os-specific message box popup
            AddMessageToAPFeed("Compatable version mismatch. Proceed with caution, and change versions if possible.")
        end
        print("[ArchipelagoMod] Goal: " .. tostring(slot_data.Goal) .. "\n") -- 1 = Open the city, 2 = All Badges, 3 = Both, 4 = Specific Chapter
        print("[ArchipelagoMod] ChapterGoal: " .. tostring(slot_data.ChapterGoal) .. "\n") -- Chapters are in order from chapter 4 to 11
        print("[ArchipelagoMod] DeathLink: " .. tostring(slot_data.DeathLink) .. "\n") -- this returns as an int, so 0 is False and 1 is True
        print("[ArchipelagoMod] End Slot data.\n")
        print("[ArchipelagoMod] Missing locations: " .. table.concat(ap.missing_locations, ", ") .. "\n")
        print("[ArchipelagoMod] Checked locations: " .. table.concat(ap.checked_locations, ", ") .. "\n")
        print("[ArchipelagoMod] Players:\n")
        local players = ap:get_players()
        for _, player in ipairs(players) do
            print("  " .. tostring(player.slot) .. ": " .. player.name ..
                  " playing " .. ap:get_player_game(player.slot) .. "\n")
        end
    end

    function on_slot_refused(reasons)
        print("[ArchipelagoMod] Connection refused: " .. table.concat(reasons, ", ") .. "\n")
        table.insert(pending_game_actions, {
            type = "message",
            text = "Connection refused: " .. table.concat(reasons, ", ")
        })
    end

    function on_items_received(items)
        print("[ArchipelagoMod] Item(s) received:\n")
        for _, item in ipairs(items) do
            print(item.item .. "\n")
            table.insert(all_received_items, item.item)
            ExecuteInGameThread(function()
                receiving.ProcessItem(item.item)
            end)
        end
        print("\n")
    end

    function on_location_info(items)
        print("[ArchipelagoMod] Location(s) scouted: ")
        for _, item in ipairs(items) do
            print(item.item)
        end
        print("\n")
    end

    function on_location_checked(locations)
        print("[ArchipelagoMod] Location(s) checked:" .. table.concat(locations, ", ") .. "\n")
        print("[ArchipelagoMod] Checked locations: " .. table.concat(ap.checked_locations, ", ") .. "\n")
    end

    function on_data_package_changed(data_package)
        print("[ArchipelagoMod] Data package changed:\n")
        for k,v in pairs(data_package) do
            print(k .. ": " .. tostring(v) .. "\n")
        end
    end

    function on_print(msg)
        print("[ArchipelagoMod] Print: " .. msg .. "\n")
    end

    function on_print_json(msg, extra)
        print("[ArchipelagoMod] PrintJSON: " .. ap:render_json(msg, message_format) .. "\n")
        table.insert(pending_game_actions, {
            type = "message",
            text = ap:render_json(msg, message_format)
        })
    end

    function on_bounced(bounce)
        print("[ArchipelagoMod] Bounce received:\n")
        for k,v in pairs(bounce) do
            print(k .. ": " .. tostring(v) .. "\n")
        end
    end

    function on_retrieved(map, keys, extra)
        print("[ArchipelagoMod] Retrieved:\n")
        -- since lua tables won't contain nil values, we can use keys array
        for _, key in ipairs(keys) do
            print("  " .. key .. ": " .. tostring(map[key]))
        end
        print("\n")
        -- extra will include extra fields from Get
        print("Extra:\n")
        for key, value in pairs(extra) do
            print("  " .. key .. ": " .. tostring(value))
        end
        print("\n")
        -- both keys and extra are optional
    end

    function on_set_reply(message)
        print("[ArchipelagoMod] Set Reply:\n")
        for key, value in pairs(message) do
            print("  " .. key .. ": " .. tostring(value))
            if key == "value" and type(value) == "table" then
                for subkey, subvalue in pairs(value) do
                    print("    " .. subkey .. ": " .. tostring(subvalue))
                end
            end
        end
        print("\n")
    end

    ap = AP(uuid, game_name, server);

    ap:set_socket_connected_handler(on_socket_connected)
    ap:set_socket_error_handler(on_socket_error)
    ap:set_socket_disconnected_handler(on_socket_disconnected)
    ap:set_room_info_handler(on_room_info)
    ap:set_slot_connected_handler(on_slot_connected)
    ap:set_slot_refused_handler(on_slot_refused)
    ap:set_items_received_handler(on_items_received)
    ap:set_location_info_handler(on_location_info)
    ap:set_location_checked_handler(on_location_checked)
    ap:set_data_package_changed_handler(on_data_package_changed)
    ap:set_print_handler(on_print)
    ap:set_print_json_handler(on_print_json)
    ap:set_bounced_handler(on_bounced)
    ap:set_retrieved_handler(on_retrieved)
    ap:set_set_reply_handler(on_set_reply)
end

function AP_Connect(host, slot, password)
    print("[ArchipelagoMod] Connecting to: " .. host .. "\n")
    local world = UEHelpers:GetWorld()
    if world:GetFullName() == "World /Game/Map/_MainGame/HK_Project_MainStart.HK_Project_MainStart" then -- main menu
        AddMessageToAPFeed("Must be in-game to connect!") -- refuse connection on the main menu
        print("[ArchipelagoMod] Refusing to connect on the main menu.")
        return
    end
    ExecuteAsync(function()
        connect(host, slot, password)
    end)

    local savedata = FindFirstOf("BP_HKSessionSaveData_C")
    local currentGameProgression = savedata.ChapterAdventureState
    print("[ArchipelagoMod] AdventureState: " .. currentGameProgression)

	ResyncInventory()

    LoopAsync(200, function()
        if ap == nil then return false end
        xpcall(function()
            ap:poll()
            if scrollPending and APFeedScrollBox ~= nil then
                scrollPending = false
                APFeedScrollBox:ScrollToEnd()
            end
            ExecuteInGameThread(function()
                if savedata.ChapterAdventureState > currentGameProgression then -- the player has crossed a chapter boundary
					currentGameProgression = savedata.ChapterAdventureState
                    print("[ArchipelagoMod] AdventureState changed! Now " .. currentGameProgression .. ". Resyncing inventory...\n")
                    ResyncInventory()
                end
            end)
            while #pending_game_actions > 0 do
                local action = table.remove(pending_game_actions, 1)

                if action.type == "message" then
                    ExecuteInGameThread(function()
                        AddMessageToAPFeed(action.text)
                    end)
                end

                if action.type == "SendLocations" then
                    ap:LocationChecks({action.id})
                end
            end
        end, function()
            disconnect()
        end)
    end)
end

function disconnect()
    if ap == nil then 
        return
    end
    print("[ArchipelagoMod] Disconnected.\n")
    AddMessageToAPFeed("Disconnected from Archipelago.")
    ap = nil
    pending_game_actions = {}
    all_received_items = {}
    slot_data = {}
    currentGameProgression = 0
    collectgarbage("collect")
end

function ResyncInventory()
    local backpack = FindFirstOf("BP_Backpack_C")
    if not backpack or not backpack:IsValid() then
        print("[ArchipelagoMod] Can't resync item inventory because the cat doesn't have the backpack!\n")
    else
        if not ap then
            print("[ArchipelagoMod] Can't resync item inventory when not connected!\n")
            return
        end
        backpack:ClearInventory()
        for _, item in ipairs(all_received_items) do
            receiving.ProcessItem(item) -- reprocess all items
        end
    end
end

function SetupUI() -- this function is a beautiful mess
    local userWidgetClass = StaticFindObject("/Script/UMG.UserWidget")
    local widgetTreeClass = StaticFindObject("/Script/UMG.WidgetTree")
    local canvasClass = StaticFindObject("/Script/UMG.CanvasPanel")
    local scrollClass = StaticFindObject("/Script/UMG.ScrollBox")
    local verticalClass = StaticFindObject("/Script/UMG.VerticalBox")
    textClass = StaticFindObject("/Script/UMG.TextBlock") -- RichTextBlock starts with nil font. Trying to set it always instantly crashes the engine. Let me know if you know a workaround to this.
    local world = UEHelpers:GetWorld()
    local spawnedUserWidget = StaticConstructObject(userWidgetClass, world, 0, 0, 0, nil, false, false, nil)
    print("UserWidget created: " .. spawnedUserWidget:GetFullName() .. "\n")
    local spawnedWidgetTree = StaticConstructObject(widgetTreeClass, spawnedUserWidget, 0, 0, 0, nil, false, false, nil)
    spawnedUserWidget.WidgetTree = spawnedWidgetTree
    print("WidgetTree created: " .. spawnedWidgetTree:GetFullName() .. "\n")
    local spawnedCanvas = StaticConstructObject(canvasClass, spawnedWidgetTree, 0, 0, 0, nil, false, false, nil)
    spawnedWidgetTree.RootWidget = spawnedCanvas
    print("CanvasPanel created: " .. spawnedCanvas:GetFullName() .. "\n")
    APFeedScrollBox = StaticConstructObject(scrollClass, spawnedWidgetTree, 0, 0, 0, nil, false, false, nil)
    local slot = spawnedCanvas:AddChildToCanvas(APFeedScrollBox)
    print("ScrollBox created and attached: " .. APFeedScrollBox:GetFullName() .. "\n")
    slot:SetAnchors({Minimum={X=0.020000,Y=0.550000}, Maximum={X=0.350000,Y=0.980000}}) -- Size of the message feed itself, resolution independant
    APMessageFeed = StaticConstructObject(verticalClass, spawnedWidgetTree, 0, 0, 0, nil, false, false, nil)
    APFeedScrollBox:AddChild(APMessageFeed)
    spawnedUserWidget:AddToViewport(999) -- high ZOrder so it's above other menus
    AddMessageToAPFeed("Archipelago Mod Initalized. Start/load a save and use apconnect in the Unreal Engine console to connect.")
end

function AddMessageToAPFeed(text)
    if APMessageFeed == nil then
        SetupUI()
    end
    local newText = StaticConstructObject(textClass, APMessageFeed, 0, 0, 0, nil, false, false, nil)
    newText:SetText(FText(text))
    newText:SetAutoWrapText(true)
    newText.Font.Size = 17 -- default is 25, which is quite large
    APMessageFeed:AddChild(newText)
    scrollPending = true -- scrolling right after adding the child makes it not scroll all the way (doesn't account for text wrapping), so we defer until next update
end

RegisterConsoleCommandHandler("apconnect", function(cmd, args)
    if ap then
        print("[ArchipelagoMod] Already connected.")
        AddMessageToAPFeed("Already connected.")
        return true;
    end
    local host = args[1]
    local slot = args[2]
    local password = args[3] or ""

    if not host or not slot then
        print("[ArchipelagoMod] Usage: apconnect <host> <slot> [password]")
        AddMessageToAPFeed("Usage: apconnect <host> <slot> [password]")
        return true;
    end

    AP_Connect(host, slot, password)
    return true;
end)

RegisterConsoleCommandHandler("apsay", function(cmd, args)
    local message = args[1]

    if not ap then
        print("[ArchipelagoMod] You must be connected to chat.")
        AddMessageToAPFeed("You must be connected to chat.")
        return true;
    end

    ap:Say(message)
    return true;
end)

RegisterConsoleCommandHandler("apresync", function(cmd, args)
    if not ap then
        print("[ArchipelagoMod] You must be connected to resync items.")
        AddMessageToAPFeed("You must be connected to resync items.")
        return true;
    end

    ResyncInventory()
    return true;
end)

RegisterConsoleCommandHandler("apdisconnect", function(cmd, args)
    if not ap then
        print("[ArchipelagoMod] You're already disconnected!")
        AddMessageToAPFeed("You're already disconnected!")
        return true;
    end
    print("[ArchipelagoMod] apdisconnect used. Disconnecting...\n")
    disconnect()
    return true;
end)

RegisterConsoleCommandHandler("apdebug", function(cmd, args) -- restores (partial) functionality to the basegame's hidden debug menu
    local world = UEHelpers:GetWorld()
    local menu = StaticFindObject("/Game/GUI/HUD/UMG_HUD_Debug.UMG_HUD_Debug_C")
    local controller = UEHelpers:GetPlayerController() -- replaces FindFirstOf("BP_HKPlayerController_C")
    local fn = StaticFindObject("/Script/UMG.WidgetBlueprintLibrary:Create")
    local widget = fn(world, world, menu, controller) -- spawn widget with World as context, World as world object, the Menu itself as the widget to spawn, and the Controller as the controller to use the menu
    widget:AddToViewport(999) -- high Z layer, so it's over the death/pause/B12 menus
    widget:AddToPlayerScreen(999)
    print("creating bindings...\n")
    RegisterKeyBind(Key.H, function()
        widget:OnOpened()
    end)
    RegisterKeyBind(Key.I, function()
        widget:OnGUIUp()
    end)
    RegisterKeyBind(Key.K, function()
        widget:OnGUIDown()
    end)
    RegisterKeyBind(Key.J, function()
        widget:OnGUILeft() -- unused?
    end)
    RegisterKeyBind(Key.L, function()
        widget:OnGUIRight() -- unused?
    end)
    RegisterKeyBind(Key.U, function()
        widget:OnGUIValidate()
    end)
    RegisterKeyBind(Key.O, function()
        widget:OnGUICancel()
    end)
    RegisterKeyBind(Key.ESCAPE, function()
        widget:OnClosed()
    end)
    RegisterKeyBind(Key.P, function()
        widget:OnClosed()
    end)
    print("binds created:\n")
    print("H = Open\n")
    print("IJKL = Navigate\n")
    print("U = Select Option\n")
    print("O = Back\n")
    print("ESCAPE/P = Close\n")
    return true;
end)

RegisterLoadMapPostHook(function(params)
    local world = UEHelpers:GetWorld()
    local newWorld = world:GetFullName()
    print("World Change! Now " .. newWorld .. "\n")
    SetupUI() -- world has changed, UI needs rebuilding (since it's a child of the WorldContextObject)
    if newWorld == "World /Game/Map/_MainGame/HK_Project_MainStart.HK_Project_MainStart" and ap ~= nil then -- main menu
        print("[ArchipelagoMod] Went to main menu. Disconnecting.")
        disconnect()
        return
    end
end)

-- Resync the inventory upon loading from checkpoint.
-- This took me about 7 hours to figure out, because, for some reason, LoadingScreenSubsystem:EndLoadingScreen never triggers???
RegisterHook("/Script/Hk_project.Backpack:AfterLoaded", function(RemoteUnrealParam)
    print("[ArchipelagoMod] Game loaded and inventory initalized. Resyncing items...\n") -- a prehook needs to exist, else UE4SS throws a fit for some reason
end, function(RemoteUnrealParam) -- but all the action is in the posthook instead, after the game has resynced the inventory
    ResyncInventory() -- that means that the game won't overwrite it if we do it right afterwards
end)

sending.Hooks()


