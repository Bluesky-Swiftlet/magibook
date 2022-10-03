execute at @s run loot spawn ~ ~ ~ loot magibook:magibook
data modify entity @e[type=item,limit=1,sort=nearest] PickupDelay set value 0
playsound minecraft:entity.villager.work_cartographer master @s ~ ~ ~ 1 1.0
recipe take @s magibook:magibook
clear @s knowledge_book 1
advancement revoke @s only magibook:craft/magibook