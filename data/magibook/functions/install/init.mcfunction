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
