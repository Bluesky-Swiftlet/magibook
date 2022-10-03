scoreboard players operation @s TP_Sneaking %= #One_Second TP_Temp
execute if score @s TP_Temp matches 5 if score @s TP_Sneaking matches 0 unless entity @s[tag=teleported] run tag @s add active_teleport
execute at @s if score @s TP_Temp matches ..4 if score @s TP_Sneaking matches 1 run function magibook:tp_point/heartbeat