--[[ Definitions ]]
local nameplates = {};

-- Checks to see if the frame is a Blizzard nameplate
local function isBlizzardNameplate(frame)
	local regions = frame:GetRegions();
	return regions and regions:GetObjectType() == "Texture" and regions:GetTexture() == "Interface\\TargetingFrame\\UI-TargetingFrame-Flash" 
end

-- Updates level text color in Blizzard nameplates
local function updateNameplateLevel(nameplate)
	if (nameplates[nameplate] == true or not nameplate:IsShown()) then
		return;
	end
	
	nameplates[nameplate] = true;
	
	-- Update level text color
	local regions = {};
	_, _, _, _, _, _, _, regions.level, _, _, _ = nameplate:GetRegions();

	local level = regions.level:GetText();
	local color = GetQuestDifficultyColor(level);
	
	regions.level:SetTextColor(color.r, color.g, color.b);
end

function onUpdate(self)
	-- Check for Blizzard nameplates and update their level
	local numChildren = WorldFrame.GetNumChildren(WorldFrame);
	local children = { WorldFrame.GetChildren(WorldFrame) };
	local currentNameplates = 0;
	for i = 1, numChildren, 1 do
		local nameplate = children[i];
		if (isBlizzardNameplate(nameplate)) then
			-- Only count nameplates which are shown
			if (nameplate:IsShown()) then
				currentNameplates = currentNameplates + 1;

				if (nameplates[nameplate] == nil) then
					nameplates[nameplate] = false;
				end
			else
				-- Flag known nameplates that are not shown
				if (nameplates[nameplate] ~= nil) then
					nameplates[nameplate] = false;
				end
			end
		end
	end
	
	for nameplate in pairs(nameplates) do
		updateNameplateLevel(nameplate);
	end
end

--[[ Register Hooks ]]
GreyBegone:SetScript("OnUpdate", onUpdate)