function magibook:tp_point/identify
effect give @s regeneration 5 4 true
effect give @s absorption 10 4 true
effect give @s fire_resistance 10 0 true
effect give @s resistance 5 4 true
effect give @s saturation 2 4 true
execute at @e[tag=teleport_point, scores={identification=0}] run tp ~ ~-.5 ~
execute at @s run effect give @s blindness 1 0 true
execute at @s run particle cloud ^ ^1 ^.5 0 .1 .5 .7 500 force @a
execute at @s run playsound minecraft:block.amethyst_cluster.break master @a ~ ~ ~ 1 .6
execute at @s run playsound minecraft:block.glass.break master @a ~ ~ ~ 1 .7
execute at @s run playsound minecraft:item.totem.use master @a ~ ~ ~ .2 2
execute at @e[tag=teleport_point, scores={identification=0}] run forceload remove ~ ~
kill @e[tag=teleport_point, scores={identification=0}]
tag @s add teleported
tag @s remove enabled_teleport
experience set @s 0 levels
experience set @s 0 points
function magibook:tp_point/undo