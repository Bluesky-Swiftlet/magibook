function magibook:tp_point/identify
execute as @e[tag=teleport_point,scores={identification=0}] at @s run forceload remove ~ ~
execute as @e[tag=teleport_point,scores={identification=0}] run kill @s
tag @s remove enabled_teleport
function magibook:tp_point/undo
execute at @s run particle minecraft:block minecraft:nether_portal ~ ~1.5 ~ .2 .5 .2 1 50 force @s
execute at @s run playsound minecraft:block.glass.break master @s ~ ~ ~ 1 0.6
scoreboard players set @s Delete_teleport_point 0
scoreboard players enable @s Delete_teleport_point