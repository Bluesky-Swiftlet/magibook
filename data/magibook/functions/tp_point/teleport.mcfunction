function magibook:tp_point/identify
execute at @e[tag=teleport_point, scores={identification=0}] run tp ~ ~-.5 ~
execute run effect give @s blindness 1 0 true
execute at @s run particle minecraft:totem_of_undying ~ ~2 ~ 0 0 0 .3 100 force @a
execute at @s run playsound entity.ender_eye.death master @a ~ ~ ~ 1 .75
execute at @s run playsound entity.enderman.teleport master @a ~ ~ ~ 1 1.2
tag @s remove active_teleport
tag @s add teleported
experience add @s -10 levels
function magibook:tp_point/undo