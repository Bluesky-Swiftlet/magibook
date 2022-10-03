execute if block ~ ~1 ~ air run function magibook:tp_point/success
execute unless block ~ ~1 ~ air run function magibook:tp_point/failure
scoreboard players set @s Give_teleport_point 0
scoreboard players enable @s Give_teleport_point
