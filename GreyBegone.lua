--[[ Definitions ]]
GreyBegone = CreateFrame("Frame", "GreyBegone", WorldFrame);
GreyBegone:SetFrameStrata("TOOLTIP"); -- When parented to WorldFrame, causes OnUpdate handler to run close to last

-- Redefine `GetQuestDifficultyColor` to return `GetQuestDifficultyColor["standard"]` instead of `GetQuestDifficultyColor["trivial"]`
function GetQuestDifficultyColor(level)
	local levelDiff = level - UnitLevel("player");
	local color;
	if ( levelDiff >= 5 ) then
		return QuestDifficultyColors["impossible"];
	elseif ( levelDiff >= 3 ) then
		return QuestDifficultyColors["verydifficult"];
	elseif ( levelDiff >= -2 ) then
		return QuestDifficultyColors["difficult"];
	elseif ( -levelDiff <= GetQuestGreenRange() ) then
		return QuestDifficultyColors["standard"];
	else
		return QuestDifficultyColors["standard"];
	end
end

-- Redefine `GetQuestDifficultyColor["trivial"]` in case someone uses `QuestDifficultyColors` directly
QuestDifficultyColors["trivial"] = QuestDifficultyColors["standard"];
