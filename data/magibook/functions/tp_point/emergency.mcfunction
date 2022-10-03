execute unless entity @s[tag=enabled_teleport,level=20..] run function magibook:tp_point/em_failure
execute if entity @s[tag=enabled_teleport,level=20..] run function magibook:tp_point/em_success
scoreboard players set @s Emergency_teleport 0
scoreboard players enable @s Emergency_teleport