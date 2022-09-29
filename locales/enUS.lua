local name, tbl = ...;

local LibStub = LibStub;
local AceLocale = LibStub:GetLibrary("AceLocale-3.0"); ---@type AceLocale-3.0
local L = AceLocale:NewLocale(name, "enUS", true, true); ---@class HelloWorldLocale

L['Hello World'] = true;
L['Message'] = true;
L['The message to be displayed'] = true;
L['Profiles'] = true;