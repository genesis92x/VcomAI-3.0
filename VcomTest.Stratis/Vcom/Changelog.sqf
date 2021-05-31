Dev Build Changes

-V2.1-
Fix: Small bugfixes

-V2-
New: Reintroduced VCM_fnc_3DPathDebug function to track AI movement
New: Enhanced Movement Code reintroduced, will be adding support for different version.
New: Idle animations toggle added to params
New: Idle animations chance slider added to params
New: Vcom will no longer force AI to seek cover until the AI group is engaged. Allowing scripts/Zeus to change the AI behavior (Aware vs combat vs stealth) prior to engagement

Fix: Idle animations now work correctly
Fix: Fixed undefined _coverobjects error when AI squad engages enemy aircraft
Fix: Encouraged AI to move further when doing bounding moves, you will have to keep an eye on their responses to enemy contact
Fix: New CBA initalization for attempted fix for CBA settings not appearing. CBA settings will appear in the Eden editor now.
Fix: Fixed inverted VCM_MEDICALACTIVE param in AIHIT function


-V1-
New: AI performance at stacking up and clearing buildings has been improved
New: FSM based system to monitor and move AI around the battlefield in more dynamic ways
New: Movement for AI while in combat. AI will move together more cohesively now, following their waypoint.
New: Parameter for smoke throw cool down.
New: Parameter for grenade throw cool down.
New: Parameter to disable AI radio protocol (Disabling AI protocol makes them respond faster to commands). This is not enabled by default.
New: Parameter to disable AI using static weapons
New: AI units will check if they are Zeus controlled before throwing grenades. (This will only work if the unit is local to the zeus). 

Fix: AI will now throw grenades again at enemies
Fix: Vcom will no longer replace skills of AI when VCM_SKILLCHANGE is set to false
Fix: Replaced 'servertime' commands with 'time' command. This will help Vcom work in SP environments
Fix: AI no longer throw as much smoke! Each AI squad will have a % chance to attempt throwing smoke, and then each AI within the group will have a % chance to throw smoke.
Fix: Vcom AI will no longer force YELLOW combat mode
Fix: Attempted fix of CBA settings not loading when using over 9000 mods