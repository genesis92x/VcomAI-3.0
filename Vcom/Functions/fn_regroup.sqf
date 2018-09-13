// This function makes the AI regroup after combat.
// Right now it works wit setPos, will try to modify and make the AI regroup on foot
_groupLeader = _this select 0;
{_x setPos position _groupLeader} forEach units group _groupLeader;
