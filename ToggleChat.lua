-- ToggleChat Addon for WoW Classic 1.15.7
-- Toggle chat windows visibility with a keybinding

local addonName, addon = ...
local frame = CreateFrame("Frame")

-- Default settings
local defaults = {
    showChat = true,
    chatFrameSettings = {}
}

-- Initialize saved variables
function addon:InitializeDB()
    ToggleChatDB = ToggleChatDB or {}
    for key, value in pairs(defaults) do
        if ToggleChatDB[key] == nil then
            ToggleChatDB[key] = value
        end
    end
end

-- Get all existing chat frames
function addon:GetChatFrames()
    local chatFrames = {}
    local i = 1
    
    while true do
        local chatFrame = _G["ChatFrame" .. i]
        if chatFrame then
            table.insert(chatFrames, chatFrame)
            i = i + 1
        else
            break
        end
    end
    
    return chatFrames
end

-- Save chat frame settings
function addon:SaveChatFrameSettings()
    if not ToggleChatDB.chatFrameSettings then
        ToggleChatDB.chatFrameSettings = {}
    end
    
    local chatFrames = addon:GetChatFrames()
    
    for i, chatFrame in ipairs(chatFrames) do
        local tab = _G["ChatFrame" .. i .. "Tab"]
        ToggleChatDB.chatFrameSettings[i] = {
            isVisible = chatFrame:IsVisible(),
            tabIsVisible = tab and tab:IsShown() or false
        }
        -- In Classic, we'll just save the visibility state
    end
end

-- Restore chat frame settings
function addon:RestoreChatFrameSettings()
    if not ToggleChatDB.chatFrameSettings then
        return
    end
    
    local chatFrames = addon:GetChatFrames()
    
    for i, chatFrame in ipairs(chatFrames) do
        local settings = ToggleChatDB.chatFrameSettings[i]
        local tab = _G["ChatFrame" .. i .. "Tab"]
        if settings then
            if settings.isVisible then
                chatFrame:Show()
            else
                chatFrame:Hide()
            end
            if tab then
                if settings.tabIsVisible then
                    tab:Show()
                else
                    tab:Hide()
                end
            end
        end
    end
end

-- Toggle chat visibility
function addon:ToggleChat()
    local chatFrames = addon:GetChatFrames()
    if ToggleChatDB.showChat then
        addon:SaveChatFrameSettings()
        for i, chatFrame in ipairs(chatFrames) do
            chatFrame:Hide()
            local tab = _G["ChatFrame" .. i .. "Tab"]
            if tab then tab:Hide() end
        end
        ToggleChatDB.showChat = false
    else
        for i, chatFrame in ipairs(chatFrames) do
            chatFrame:Show()
            local tab = _G["ChatFrame" .. i .. "Tab"]
            if tab then tab:Show() end
        end
        addon:RestoreChatFrameSettings()
        ToggleChatDB.showChat = true
    end
end

-- Register slash commands
SLASH_TOGGLECHAT1 = "/togglechat"
SLASH_TOGGLECHAT2 = "/tc"
SlashCmdList["TOGGLECHAT"] = function(msg)
    if msg == "toggle" then
        addon:ToggleChat()
    elseif msg == "help" then
        print("|cFF00FF00[ToggleChat]|r Commands:")
        print("  /togglechat or /tc - Toggle chat visibility")
        print("  /togglechat help - Show this help")
    else
        addon:ToggleChat()
    end
end

-- Register keybinding
BINDING_HEADER_TOGGLECHAT = "ToggleChat"
BINDING_NAME_TOGGLECHAT_TOGGLE = "Toggle Chat Visibility"

function ToggleChat_Toggle()
    addon:ToggleChat()
end

-- Event handling
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local loadedAddon = ...
        if loadedAddon == addonName then
            addon:InitializeDB()
        end
    elseif event == "PLAYER_LOGIN" then
        C_Timer.After(2, function()
            if not ToggleChatDB.chatFrameSettings or not next(ToggleChatDB.chatFrameSettings) then
                addon:SaveChatFrameSettings()
            end
        end)
        print("|cFF00FF00[ToggleChat]|r Loaded. Use /togglechat or /tc to toggle chat visibility.")
        print("|cFF00FF00[ToggleChat]|r Type /togglechat help for more commands.")
    end
end) 