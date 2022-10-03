# Install
scoreboard objectives add identification dummy
scoreboard players add #ID_Holder identification 1
scoreboard objectives add Give_teleport_point trigger
scoreboard objectives add Emergency_teleport trigger
scoreboard objectives add Delete_teleport_point trigger
scoreboard objectives add TP_Chk_Sneak minecraft.custom:minecraft.sneak_time
scoreboard objectives add TP_Sneaking dummy
scoreboard objectives add TP_Temp dummy
scoreboard players set #One_Second TP_Temp 20
scoreboard objectives add TP_MV_Chk_1 minecraft.custom:minecraft.crouch_one_cm
scoreboard objectives add TP_MV_Chk_2 minecraft.custom:minecraft.sprint_one_cm
scoreboard objectives add TP_MV_Chk_3 minecraft.custom:minecraft.jump
scoreboard objectives add TP_MV_Chk_4 minecraft.custom:minecraft.damage_taken
data merge storage magibook:config {is_installed:1}
tellraw @a [{"text": "MAGIBOOK", "color": "gold", "bold": true},{"text": " is installed successfully!", "color": "white", "bold": false}]

# Install first entered
scoreboard players set @s Give_teleport_point 0
scoreboard players set @s Emergency_teleport 0
scoreboard players enable @s Give_teleport_point
scoreboard players enable @s Emergency_teleport

# Install check
execute unless data storage magibook:config is_installed run function magibook:install/init
execute as @s run function magibook:install/trigger_book

# Make magibook
execute at @s run loot spawn ~ ~ ~ loot magibook:magibook
data modify entity @e[type=item,limit=1,sort=nearest] PickupDelay set value 0
playsound minecraft:entity.villager.work_cartographer master @s ~ ~ ~ 1 1.0
recipe take @s magibook:magibook
clear @s knowledge_book 1
advancement revoke @s only magibook:craft/magibook

# main
## Check static sneaked
scoreboard players add @a[predicate=magibook:is_static] TP_Sneaking 1
scoreboard players reset @a[predicate=!magibook:is_static] TP_Sneaking
scoreboard players reset @a[predicate=!magibook:is_static] TP_Temp
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

# magibook
## make_tp_point
execute if entity @s[tag=enabled_teleport] run function magibook:tp_point/delete
execute if block ~ ~1 ~ air run function magibook:tp_point/success
execute unless block ~ ~1 ~ air run function magibook:tp_point/failure
scoreboard players set @s Give_teleport_point 0
scoreboard players enable @s Give_teleport_point
### tp_point/delete
function magibook:tp_point/identify
execute as @e[tag=teleport_point,scores={identification=0}] at @s run forceload remove ~ ~
execute as @e[tag=teleport_point,scores={identification=0}] run kill @s
tag @s remove enabled_teleport
function magibook:tp_point/undo
scoreboard players set @s Delete_teleport_point 0
scoreboard players enable @s Delete_teleport_point
### tp_point/identify
scoreboard players operation #ID_Temp identification = @s identification
execute as @e[tag=teleport_point] run scoreboard players operation @s identification -= #ID_Temp identification
### tp_point/undo
execute as @e[tag=teleport_point] run scoreboard players operation @s identification += #ID_Temp identification
scoreboard players set #ID_Temp identification 0
### tp_point/success
summon minecraft:item ~ ~1 ~ {Item:{id:"minecraft:nether_star",Count:1b},Tags:["teleport_point"],Age:-32768s,Invulnerable:1b,Health:32767s,PickupDelay:32767s,NoGravity:1b,CustomNameVisible:1b}
setblock ~ ~ ~ minecraft:birch_sign{Text1: '{"text":"Owner: ","extra":[{"selector":"@p"}],"color":"dark_purple","italic": false,"bold": true}'}
data modify entity @e[tag=teleport_point,sort=nearest,limit=1] CustomName set from block ~ ~ ~ Text1
setblock ~ ~ ~ air
execute at @e[tag=teleport_point,sort=nearest,limit=1] run playsound entity.wither.spawn master @s ~ ~ ~ .15 2
execute at @e[tag=teleport_point,sort=nearest,limit=1] run particle minecraft:dust_color_transition .2 1 .2 .7 .2 1 .2 ~ ~ ~ .3 .1 .3 .5 50 force @a
execute unless entity @s[tag=identificated] run function magibook:tp_point/get_id
scoreboard players operation @e[tag=teleport_point,sort=nearest,limit=1] identification = @s identification
tag @s add enabled_teleport
execute at @e[tag=teleport_point,sort=nearest,limit=1] run forceload add ~ ~
### tp_point/failure
tellraw @s {"text": "There is no enough space... Try again.", "color": "dark_red", "italic": false}
execute at @s run playsound entity.villager.no master @s ~ ~ ~ 1 1.3
#### tp_point/get_id
scoreboard players operation @s identification = #ID_Holder identification
scoreboard players add #ID_Holder identification 1
tag @s add identificated

## tp_point/teleport
function magibook:tp_point/identify
execute at @e[tag=teleport_point, scores={identification=0}] run tp ~ ~-1 ~
execute run effect give @s blindness 1 0 true
execute at @s run particle minecraft:totem_of_undying ~ ~2 ~ 0 0 0 .3 100 force @a
execute at @s run playsound entity.ender_eye.death master @a ~ ~ ~ 1 .75
execute at @s run playsound entity.enderman.teleport master @a ~ ~ ~ 1 1.2
tag @s remove active_teleport
tag @s add teleported
experience add @s -10 levels
function magibook:tp_point/undo

## tp_point/emergency
execute if entity @s[tag=enabled_teleport,level=20..] run function magibook:tp_point/em_success
execute unless entity @s[tag=enabled_teleport,level=20..] run function magibook:tp_point/em_failure
scoreboard players set @s Emergency_teleport 0
scoreboard players enable @s Emergency_teleport
### tp_point/em_success
function magibook:tp_point/identify
execute at @e[tag=teleport_point, scores={identification=0}] run tp ~ ~-1 ~
execute at @s run effect give @s blindness 1 0 true
execute at @s run particle cloud ^ ^1 ^.5 0 .1 .5 .7 500 force @a
execute at @s run playsound minecraft:block.amethyst_cluster.break master @a ~ ~ ~ 1 .6
execute at @s run playsound minecraft:block.glass.break master @a ~ ~ ~ 1 .7
execute at @s run playsound minecraft:item.totem.use master @a ~ ~ ~ .2 2
kill @e[tag=teleport_point, scores={identification=0}]
tag @s add teleported
experience set @s 0 levels
function magibook:tp_point/undo
### tp_point/em_failure
execute unless entity @s[tag=enabled_teleport] run tellraw @s [{"text": "You didn't put teleport point!\n", "bold": true, "color": "red", "italic": false}, {"text": "You must put teleport point at first!", "color": "red", "bold": true, "italic": false}]
execute if entity @s[tag=enabled_teleport] run tellraw @s [{"text": "You don't have enough level to activate emergency teleport!\n", "bold": true, "color": "red", "italic": false},{"text": "You must have ", "extra": [{"text": "10 levels ", "color": "red", "bold": true, "underlined": true}, {"text": "to activate!"}],"italic": false}]
execute at @s run playsound minecraft:block.amethyst_cluster.break master @s ~ ~ ~ .6 1.2
execute at @s run playsound minecraft:block.pointed_dripstone.drip_water_into_cauldron master @s ~ ~ ~ 1 .8
execute at @s run particle minecraft:smoke ~ ~1 ~ .1 .2 .1 .05 40 force @s

## activate
scoreboard players operation @s TP_Sneaking %= #One_Second TP_Temp
execute if score @s TP_Temp matches 5 if score @s TP_Sneaking matches 0 unless entity @s[tag=teleported] run tag @s add active_teleport
execute at @s if score @s TP_Temp matches ..4 if score @s TP_Sneaking matches 1 run function magibook:tp_point/heartbeat
### tp_point/heartbeat
effect give @s darkness 3 0 true
playsound entity.warden.heartbeat master @s ~ ~ ~ 1.0
particle minecraft:portal ~ ~0.5 ~ 0.4 0.5 0.4 0.5 50 force @s
scoreboard players add @s TP_Temp 1