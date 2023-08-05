execute if entity @s[tag=enabled_teleport] run function magibook:tp_point/delete
summon minecraft:armor_stand ~ ~.5 ~ {Marker:1,Invisible:1,Small:1,Tags:["teleport_point"],Invulnerable:1,NoGravity:1,ArmorItems:[{},{},{},{id:"beacon",Count:1}],CustomNameVisible:1b}
setblock ~ ~1 ~ minecraft:birch_wall_sign
data modify block ~ ~1 ~ front_text.messages[0] set value '{"text":"Owner: ","extra":[{"selector":"@p"}],"color":"dark_purple","italic": false,"bold": true}'
data modify entity @e[tag=teleport_point,sort=nearest,limit=1] CustomName set from block ~ ~1 ~ front_text.messages[0]
setblock ~ ~1 ~ air
execute at @e[tag=teleport_point,sort=nearest,limit=1] run playsound entity.wither.spawn master @s ~ ~ ~ .15 2
execute at @e[tag=teleport_point,sort=nearest,limit=1] run particle minecraft:dust_color_transition .2 1 .2 .7 .2 1 .2 ~ ~.75 ~ .3 .1 .3 .5 50 force @a
execute unless entity @s[tag=identificated] run function magibook:tp_point/get_id
scoreboard players operation @e[tag=teleport_point,sort=nearest,limit=1] identification = @s identification
tag @s add enabled_teleport
execute at @e[tag=teleport_point,sort=nearest,limit=1] run forceload add ~ ~