local select = select;

local name = select(1, ...);

local LibStub         = LibStub;
local AceAddon        = LibStub:GetLibrary("AceAddon-3.0"); ---@type AceAddon-3.0
local AceLocale       = LibStub:GetLibrary("AceLocale-3.0"); ---@type AceLocale-3.0
local AceDB           = LibStub:GetLibrary("AceDB-3.0"); ---@type AceDB-3.0
local AceDBOptions    = LibStub:GetLibrary("AceDBOptions-3.0");
local AceConfig       = LibStub:GetLibrary("AceConfig-3.0"); ---@type AceConfig-3.0
local AceConfigDialog = LibStub:GetLibrary("AceConfigDialog-3.0");


---@class HelloWorld: AceAddon, AceConsole-3.0, AceEvent-3.0
local HelloWorld = AceAddon:NewAddon(name, "AceConsole-3.0", "AceEvent-3.0");

---@type HelloWorldLocale
local L = AceLocale:GetLocale(name);

function HelloWorld:OnInitialize()
    local defaults = {
        profile = {
            general = {
                message = L['Hello World'],
            }
        }
    }
    self.db = AceDB:New(name.."DB", defaults, true);

    local options = {
        name = name,
        handler = HelloWorld,
        type = 'group',
        args = {
            general = {
                name = GENERAL_LABEL,
                type = 'group',
                args = {
                    message = {
                        name = L['Message'],
                        desc = L['The message to be displayed'],
                        type = 'input',
                        set = 'SetMessage',
                        get = 'GetMessage',
                    }
                }
            },
            profiles = AceDBOptions:GetOptionsTable(self.db);
        }
    }
    AceConfig:RegisterOptionsTable(name, options, {"hw", "hello", "helloWorld"});

    self.frames = {};
    self.frames.options = AceConfigDialog:AddToBlizOptions(name.."_Options", L['Hello World'], nil, options.args.general);
    self.frames.profiles = AceConfigDialog:AddToBlizOptions(name.."_Profiles", L['Profiles'], name.."_Options", options.args.profiles);
end

function HelloWorld:OnEnable()
    if self.frames.bar == nil then
        self.frames.bar = CreateFrame("Frame", name.."BarFrame", UIParent);
    end

    self:RegisterEvent("ZONE_CHANGED", self.SayHello);
end

function HelloWorld:SayHello()
    local GetBindLocation, GetSubZoneText = GetBindLocation, GetSubZoneText;

    if GetBindLocation() == GetSubZoneText() then
        UIErrorsFrame:AddMessage(self.db.profile.message, 1, 1, 1);
        UIErrorsFrame:AddMessage("This is getting too hard", 1, 1, 1);
        UIErrorsFrame:AddMessage("Does this even work?!", 1, 1, 1);
        UIErrorsFrame:AddMessage("A small change?!", 1, 1, 1);

    end
end

function HelloWorld:OnDisable()
end

function HelloWorld:SetMessage(info, value)
    self.db.profile.message = value;
end

function HelloWorld:GetMessage(info)
    return self.db.profile.message;
end