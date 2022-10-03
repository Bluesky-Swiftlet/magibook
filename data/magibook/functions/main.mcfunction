## Check static sneaked
scoreboard players add @a[predicate=magibook:is_static] TP_Sneaking 1
scoreboard players reset @a[predicate=!magibook:is_static] TP_Sneaking
scoreboard players set @a[predicate=!magibook:is_static] TP_Temp 0
## Reset move detection
scoreboard players set @a[scores={TP_MV_Chk_1=1..}] TP_MV_Chk_1 0
scoreboard players set @a[scores={TP_MV_Chk_2=1..}] TP_MV_Chk_2 0
scoreboard players set @a[scores={TP_MV_Chk_3=1..}] TP_MV_Chk_3 0
scoreboard players set @a[scores={TP_MV_Chk_4=1..}] TP_MV_Chk_4 0
## Summon
execute as @a[scores={Give_teleport_point=1..},limit=1] at @s run function magibook:tp_point/make_tp_point
## Teleport
execute as @a[tag=active_teleport,limit=1] run function magibook:tp_point/teleport
execute as @a[scores={Emergency_teleport=1..},limit=1] run function magibook:tp_point/emergency
execute as @a[tag=enabled_teleport,scores={Delete_teleport_point=1..},limit=1] run function magibook:tp_point/delete
## Check active
execute as @a[tag=!teleported,scores={TP_Sneaking=1..},level=10..] run function magibook:tp_point/activate
## Unset after teleport
tag @a[predicate=!magibook:is_sneak] remove teleported