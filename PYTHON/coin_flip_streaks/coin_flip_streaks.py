#Let us assume we have 10 coins which we flip
#Streak length is 3
#Sample space is 20
#random.randint(0,1)
#0--------->Head, 1-------->Tail

import random
numberofstreaks=0
# we make 20 attempts
for experiment_number in range(20):
    list_coins=[];
    #Generating random choices for 10 coins and making them a list
    for i in range(0,10):
        choice=random.randint(0,1)
        if (choice==0):
            list_coins.append("H")
        else:
            list_coins.append("T")
        
     #--------------------------------
     #repeat=0
    for i in range(0,10):
             if (i>=3):
                 if  (list_coins[i-2]==list_coins[i] and list_coins[i-1]==list_coins[i]):
                     numberofstreaks+=1
              
                
    #-------------------------------------
print('Chance of streak: %s%%' % (numberofstreaks / 100))
