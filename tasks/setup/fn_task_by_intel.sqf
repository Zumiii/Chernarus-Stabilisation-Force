



[_unit, "acex_intelitems_notepad", "Notes!"] call acex_intelitems_fnc_addIntel

[_unit, "acex_intelitems_document", "Notes!"] call acex_intelitems_fnc_addIntel



private _pos = ((villages select _id) select 12);
private _referenceObject = (((villages select _id) select 12) call CBA_fnc_getNearestBuilding) select 0;
private _pic = [configFile >> "CfgVehicles" >> (typeOf _referenceObject) >> "Editorpreview", "STRING", ""] call CBA_fnc_getConfigEntry;
[_unit, "acex_intelitems_photo", _pic] call acex_intelitems_fnc_addIntel;

private _pic = [missionConfigFile >> "CfgIntels" >> (typeOf _referenceObject) >> "Hint", "STRING", ""] call CBA_fnc_getConfigEntry;
