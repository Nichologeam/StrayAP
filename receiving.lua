local M = {}

local item_handlers = {
    [712000] = function() -- Keys (B-12 Flat)
        GiveItem("/Game/GPE/Lootable/B12Flat/LOOT_Keys_B12Flat.LOOT_Keys_B12Flat_C", 1)
    end,

    [712001] = function() -- Postcard
        GiveItem("/Game/GPE/Lootable/B12Flat/BP_Lootable_PostCard.BP_Lootable_PostCard_C", 1)
    end,

    [712002] = function() -- Keys (Library)
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Keys_SlumLibrary.LOOT_Keys_SlumLibrary_C", 2)
    end,

    [712003] = function() -- Momo's Notebook
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Notebook_Momo.LOOT_Notebook_Momo_C", 2)
    end,

    [712004] = function() -- Zbaltazar's Notebook
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Notebook_Gerard.LOOT_Notebook_Gerard_C", 2)
    end,

    [712005] = function() -- Doc's Notebook
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Notebook_Doc.LOOT_Notebook_Doc_C", 2) -- in some areas, this is called Jess's Notebook
    end,

    [712006] = function() -- Clementine's Notebook
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Notebook_Clem.LOOT_Notebook_Clem_C", 2)
    end,

    [712007] = function() -- Safe's Mysterious Password
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Postit_clue_01.LOOT_Postit_clue_01_C", 2)
    end,

    [712008] = function() -- Sheet Music (Petite valse)
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Music_Part_1.LOOT_Music_Part_1_C", 2)
    end,

    [712009] = function() -- Sheet Music (Ballad of the Lonely Robot)
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Music_Part_2.LOOT_Music_Part_2_C", 2)
    end,

    [712010] = function() -- Sheet Music (Untitled)
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Music_Part_3.LOOT_Music_Part_3_C", 2)
    end,

    [712011] = function() -- Sheet Music (The way you compute tonight)
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Music_Part_4.LOOT_Music_Part_4_C", 2)
    end,

    [712012] = function() -- Sheet Music (Tomorrows)
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Music_Part_5.LOOT_Music_Part_5_C", 2)
    end,

    [712013] = function() -- Sheet Music (Cool down)
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Music_Part_6.LOOT_Music_Part_6_C", 2)
    end,

    [712014] = function() -- Sheet Music (Mildly important information)
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Music_Part_7.LOOT_Music_Part_7_C", 2)
    end,

    [712015] = function() -- Sheet Music (Unreadable sheet music)
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Music_Part_8.LOOT_Music_Part_8_C", 2)
    end,

    [712016] = function() -- Energy Drink Speed 2K
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Energy_Drink.LOOT_Energy_Drink_C", 2)
    end,

    [712017] = function() -- Super Spirit Detergent
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Rare_Oil.LOOT_Rare_Oil_C", 2) -- apparently this was oil in some early version of the game. pretty cool!
    end,

    [712018] = function() -- Electric Cable
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Electric_Cable.LOOT_Electric_Cable_C", 2)
    end,

    [712019] = function() -- Poncho
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Eliott_Poncho.LOOT_Eliott_Poncho_C", 2)
    end,

    [712020] = function() -- Transceiver
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Transceiver.LOOT_Transceiver_C", 2)
    end,

    [712021] = function() -- Broken Tracker
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Broken_Tracker.LOOT_Broken_Tracker_C", 2)
    end,

    [712022] = function() -- Fixed Tracker
        GiveItem("/Game/GPE/Lootable/Slums/LOOT_Fixed_Tracker.LOOT_Fixed_Tracker_C", 2)
    end,

    [712023] = function() -- Fuse
        GiveItem("/Game/GPE/Lootable/LOOT_Fusible.LOOT_Fusible_C", 2)
    end,

    [712024] = function() -- Purple Plant
        GiveItem("/Game/GPE/Lootable/Antvillage/LOOT_Plant_mauve.LOOT_Plant_mauve_C", 7)
    end,

    [712025] = function() -- Red Plant
        GiveItem("/Game/GPE/Lootable/Antvillage/LOOT_Plant_red.LOOT_Plant_red_C", 7)
    end,

    [712026] = function() -- Yellow Plant
        GiveItem("/Game/GPE/Lootable/Antvillage/LOOT_Plant_yellow.LOOT_Plant_yellow_C", 7)
    end,

    [712027] = function() -- Clementine's Picture
        GiveItem("/Game/GPE/Lootable/Midtown/LOOT_Clementine_Adress.LOOT_Clementine_Adress_C", 7)
    end,

    [712028] = function() -- Contact Message
        GiveItem("/Game/GPE/Lootable/Midtown/LOOT_BlazerMessage.LOOT_BlazerMessage_C", 8)
    end,

    [712029] = function() -- Cassette Tape
        GiveItem("/Game/GPE/Lootable/Midtown/LOOT_Tape.LOOT_Tape_C", 8)
    end,

    [712030] = function() -- Worker Hat
        GiveItem("/Game/GPE/Lootable/Midtown/LOOT_Helmet.LOOT_Helmet_C", 8)
    end,

    [712031] = function() -- Jacket
        GiveItem("/Game/GPE/Lootable/Midtown/LOOT_Jacket.LOOT_Jacket_C", 8)
    end,

    [712032] = function() -- Worker Keys
        GiveItem("/Game/GPE/Lootable/Midtown/LOOT_factory_lostkeys.LOOT_factory_lostkeys_C", 9)
    end,

    [712033] = function() -- Atomic Battery
        GiveItem("/Game/GPE/Lootable/Midtown/LOOT_Rikonium.LOOT_Rikonium_C", 9) -- This is a very interesting internal name for the battery
    end,

    [712034] = function() -- Mysterious Message
        GiveItem("/Game/GPE/Lootable/Midtown/LOOT_To_Club.LOOT_To_Club_C", 10)
    end,

    [712035] = function() -- Strange Drink
        GiveItem("/Game/GPE/Lootable/Midtown/LOOT_ClubDrink.LOOT_ClubDrink_C", 10)
    end,

    [712036] = function() -- Lever Handle
        GiveItem("/Game/GPE/Lootable/Midtown/LOOT_LeverArm.LOOT_LeverArm_C", 10)
    end,

    [712037] = function() -- Subway Key
        GiveItem("/Game/GPE/Lootable/Midtown/LOOT_Subway_Keys.LOOT_Subway_Keys_C", 10) -- This might require a higher chapter number to not crash?
    end,

    [712100] = function() -- Outsider Badge
        GiveBadge("Outsider")
    end,

    [712101] = function() -- Music Badge
        GiveBadge("Music")
    end,

    [712102] = function() -- Plant Badge
        GiveBadge("Plant")
    end,

    [712103] = function() -- Police Badge
        GiveBadge("PoliceStation")
    end,

    [712104] = function() -- Neco Badge
        GiveBadge("TrashZone")
    end,

    [712105] = function() -- Cat Badge
        GiveBadge("ShopSafe")
    end,

    [712200] = function() -- Paper Bag Trap
        local world = UEHelpers:GetWorld()
        local cat = FindFirstOf("BP_CatPawn_C")
        if not cat or not cat:IsValid() then
            print("[ArchipelagoMod] Paper Bag Trap received inside the main menu or a loading screen. Skipping.\n")
            return
        end
        local bag = world:SpawnActor("/Game/Technical/Components/COMP_CatPaperBag.COMP_CatPaperBag_C", cat:K2_GetActorLocation(), cat:K2_GetActorRotation()) -- could and maybe should use StaticFindObject
        -- it's incredibly difficult to actually get the bag to go on the cat's head, and I can't for the life of me figure it out
        -- what i've tried:
        -- bag:_OnAfterMoveUseStarted(cat) -> causes the reverse control effect, but no bag visuals, then crashes the game when the bag should be removed 20 seconds later
        -- bag:_OnUseStarted(cat) -> instant game crash
        -- bag:_OnFollowSplineEndReach(cat) -> does nothing, then causes a crash 20 seconds later
        -- bag:_OnBeforeUseDone(cat) -> does nothing
        -- bag:_OnAfterUseDone(cat) -> does nothing
        -- bag.Owner:BndEvt__BP_CatButtonPaperBag_COMP_CatPaperBag_K2Node_ComponentBoundEvent_0_CatUsableDelegate__DelegateSignature(bag, cat) -> does nothing
        -- I need ideas on how to actually make this work, since I've already run out of functions to call and parameters to change
    end
}

function M.ProcessItem(item) -- called when receiving any item
    local handler = item_handlers[item]

    if handler then
        print("[ArchipelagoMod] Processing " .. tostring(item) .. "\n")
        handler() -- see table above to see each result (basically replicating a switch statement because Lua doesn't have one)
    else
        print("[ArchipelagoMod] Unknown item: " .. tostring(item) .. "\n")
    end
end

function GiveItem(id, chapter) -- uses BP_Backpack_C and HK_SessionSaveData_C
    local savedata = FindFirstOf("BP_HKSessionSaveData_C")
    local currentChapter = savedata.ChapterAdventureState
    if currentChapter < chapter then
        print("[ArchipelagoMod] Received item that requires later story progression to not crash the game.\n")
        return
    end
    local backpack = FindFirstOf("BP_Backpack_C")
    if not backpack or not backpack:IsValid() then
        print("[ArchipelagoMod] Can't give this item because the player doesn't have the backpack!\n")
    else
        local object = LoadAsset(id)
        backpack:InstantiateAndAddActorToInventory(object)
        print("[ArchipelagoMod] Current Backpack Contents:\n")
        for _, item in ipairs(backpack.m_inventory) do
            print("   " .. item:GetFullName() .. "\n")
    end

    -- Here's a full list of object pointers dumped from the game:
    -- /Game/GPE/Lootable/B12Flat/BP_Lootable_PostCard.BP_Lootable_PostCard_C
    -- /Game/GPE/Lootable/B12Flat/LOOT_Keys_B12Flat.LOOT_Keys_B12Flat_C
    -- /Game/GPE/Lootable/Slums/LOOT_Keys_SlumLibrary.LOOT_Keys_SlumLibrary_C
    -- /Game/GPE/Lootable/Slums/LOOT_Notebook_Momo.LOOT_Notebook_Momo_C
    -- /Game/GPE/Lootable/Slums/LOOT_Notebook_Clem.LOOT_Notebook_Clem_C
    -- /Game/GPE/Lootable/Slums/LOOT_Notebook_Gerard.LOOT_Notebook_Gerard_C
    -- /Game/GPE/Lootable/Slums/LOOT_Notebook_Doc.LOOT_Notebook_Doc_C
    -- /Game/GPE/Lootable/Slums/LOOT_Transceiver.LOOT_Transceiver_C
    -- /Game/GPE/Lootable/Slums/LOOT_Broken_Tracker.LOOT_Broken_Tracker_C
    -- /Game/GPE/Lootable/Slums/LOOT_Electric_Cable.LOOT_Electric_Cable_C
    -- /Game/GPE/Lootable/Slums/LOOT_Rare_Oil.LOOT_Rare_Oil_C
    -- /Game/GPE/Lootable/Slums/LOOT_Eliott_Poncho.LOOT_Eliott_Poncho_C
    -- /Game/GPE/Lootable/Slums/LOOT_Fixed_Tracker.LOOT_Fixed_Tracker_C
    -- /Game/GPE/Lootable/Slums/LOOT_Energy_Drink.LOOT_Energy_Drink_C
    -- /Game/GPE/Lootable/Slums/LOOT_Music_Part_1.LOOT_Music_Part_1_C
    -- /Game/GPE/Lootable/Slums/LOOT_Music_Part_2.LOOT_Music_Part_2_C
    -- /Game/GPE/Lootable/Slums/LOOT_Music_Part_3.LOOT_Music_Part_3_C
    -- /Game/GPE/Lootable/Slums/LOOT_Music_Part_4.LOOT_Music_Part_4_C
    -- /Game/GPE/Lootable/Slums/LOOT_Music_Part_5.LOOT_Music_Part_5_C
    -- /Game/GPE/Lootable/Slums/LOOT_Music_Part_6.LOOT_Music_Part_6_C
    -- /Game/GPE/Lootable/Slums/LOOT_Music_Part_7.LOOT_Music_Part_7_C
    -- /Game/GPE/Lootable/Slums/LOOT_Music_Part_8.LOOT_Music_Part_8_C
    -- /Game/GPE/Lootable/LOOT_Fusible.LOOT_Fusible_C               (this is the fuse in Dead End)
    -- /Game/GPE/Lootable/Midtown/LOOT_Clementine_Adress.LOOT_Clementine_Adress_C
    -- /Game/GPE/Lootable/Midtown/LOOT_BlazerMessage.LOOT_BlazerMessage_C
    -- /Game/GPE/Lootable/Midtown/LOOT_Tape.LOOT_Tape_C
    -- /Game/GPE/Lootable/Midtown/LOOT_Jacket.LOOT_Jacket_C
    -- /Game/GPE/Lootable/Midtown/LOOT_Helmet.LOOT_Helmet_C
    -- /Game/GPE/Lootable/Midtown/LOOT_Rikonium.LOOT_Rikonium_C     (this is the Atomic Battery)
    -- /Game/GPE/Lootable/Midtown/LOOT_To_Club.LOOT_To_Club_C       (this is the note Clem leaves behind to tell the cat to go to the nightclub)
    -- /Game/GPE/Lootable/Midtown/LOOT_Subway_Keys.LOOT_Subway_Keys_C
    -- /Game/GPE/Lootable/Midtown/LOOT_factory_lostkeys.LOOT_factory_lostkeys_C
    -- /Game/GPE/Lootable/Antvillage/LOOT_Plant_mauve.LOOT_Plant_mauve_C
    -- /Game/GPE/Lootable/Antvillage/LOOT_Plant_red.LOOT_Plant_red_C
    -- /Game/GPE/Lootable/Antvillage/LOOT_Plant_yellow.LOOT_Plant_yellow_C
    -- /Game/GPE/Lootable/Slums/LOOT_Postit_clue_01.LOOT_Postit_clue_01_C
    -- /Game/GPE/Lootable/Midtown/LOOT_LeverArm.LOOT_LeverArm_C
    -- /Game/GPE/Lootable/Midtown/LOOT_ClubDrink.LOOT_ClubDrink_C
    -- /Game/GPE/Lootable/LOOT_Fusible.LOOT_Fusible_C               (not sure why this is here twice)
    -- /Game/GPE/Lootable/Badges/LOOT_Badge_Trashzone.LOOT_Badge_Trashzone_C
    -- /Game/GPE/Lootable/Badges/LOOT_Badge_ShopSafe.LOOT_Badge_ShopSafe_C
    -- /Game/GPE/Lootable/Badges/LOOT_Badge_PoliceStation.LOOT_Badge_PoliceStation_C
    -- /Game/GPE/Lootable/Badges/LOOT_Badge_Plant.LOOT_Badge_Plant_C
    -- /Game/GPE/Lootable/Badges/LOOT_Badge_Outsider.LOOT_Badge_Outsider_C
    -- /Game/GPE/Lootable/Badges/LOOT_Badge_Music.LOOT_Badge_Music_C
end

function GiveBadge(badge) -- uses both BP_HKPersistentSaveData_C and BP_Backpack_C
    local save = FindFirstOf("BP_HKPersistentSaveData_C")
    local backpack = FindFirstOf("BP_Backpack_C")

    if badge == "Outsider" then
        save.BadgeOutsiderUnlocked = true
    end

    if badge == "TrashZone" then
        save.BadgeTrashzoneUnlocked = true
    end

    if badge == "Music" then
        save.BadgeMusicUnlocked = true
    end

    if badge == "Plant" then
        save.BadgePlantUnlocked = true
    end

    if badge == "ShopSafe" then
        save.BadgeShopSafeUnlocked = true
    end

    if badge == "PoliceStation" then
        save.BadgePoliceStationUnlocked = true
    end

    if slot_data.Goal == 2 then -- obtain all six badges
        -- check if all badges are obtained
        -- if they are, goal
    end

    if not backpack or not backpack:IsValid() then
        print("[ArchipelagoMod] Can't update badges visibility because the player doesn't have the backpack!\n")
    else
        backpack:RefreshBadgesVisibility(false)
        -- That `false` is for if B-12 should be hidden or not
        -- The only real issue hardcoding this to false could cause is making B-12 show up during sections they shouldn't if the player gets a badge during that time, like...
        -- During the beginning half of the Jail chapter, but the player won't have the backpack anyway
        -- During scripted cutscenes where B-12 changes from a game actor to a cutscene actor, though the camera never really lets you see into the backpack during these
        -- During the short Zurg chase just before Antvillage where B-12 is in the cat's mouth, not the backpack
        -- And the very end of the game after B-12 dies to open Walled City 99, though you won't have the backpack here either
    end
end

function GiveMemory(id) -- uses BP_HKPersistentSaveData_C
    local save = FindFirstOf("BP_HKPersistentSaveData_C")
    save:UnlockMemory(id)

    -- List of each memory's ID in order they appear in the UI (case sensitive):
    -- MAIN1
    -- MAIN2
    -- MAIN3
    -- MAIN4
    -- MAIN5
    -- Immigrant
    -- Ancestor
    -- Food
    -- Videogame
    -- RIP
    -- Art
    -- tree
    -- Neon
    -- NecoCorp
    -- Wall
    -- Cottage
    -- Knight
    -- water
    -- Slimy
    -- Language
    -- Science
    -- Feel
    -- Barbershop
    -- Burger
    -- Sentinels
    -- Party
    -- Rebooted
end

return M
