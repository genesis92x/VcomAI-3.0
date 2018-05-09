//This function will handle assigning proper variables to units, while returning appropriate arrays.

//First let's find who the medics are in the team and return that list.
private _MedicArray = _this call VCM_fnc_RMedics; //Returns _MList

private _ItemList = _this call VCM_fnc_RStatics; //Returns [_StaticList,_SatchelList,_MineList];

private _RtrnList  = [_MedicArray,_ItemList];
_RtrnList