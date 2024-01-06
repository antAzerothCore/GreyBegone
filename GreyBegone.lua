--[[ Definitions ]]

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