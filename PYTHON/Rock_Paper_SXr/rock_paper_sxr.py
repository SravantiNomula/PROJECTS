import random

#random.randint(0,2) will guess a value between 0 and 2
#0-->(R)OCK; 1-->(P)APER;2-->(S)XR 
#Rock vs paper : Paper win
#paper vs sxr  : Sxr win
#Rock vs Sxr   : Rock win

score=0

for i in range (10):
    #Making a guess 
    guess=random.randint(0,2)
    #User's turn
    print("Rock paper scissor!")
    print("0-->Rock, 1-->Paper, 2-->Sxr")
    print("Your turn!")
    choice=int(input())
#_____________________________
    if (guess==0):
        computer_move="Rock"
    elif(guess==1):
        computer_move="Paper"
    else:    
        computer_move="Sxr"   
#____________________________
    if (choice==0):
        player_move="Rock"
    elif(choice==1):
        player_move="Paper"
    else:    
        player_move="Sxr" 
#_____________________________



    if(guess==choice):
        score=score
        print("It is a tie! "+computer_move)
        print("______________________________")

    elif((guess==0 and choice==1)or (guess==1 and choice==2) or(guess==2 and choice==1)):
        score=score+1
        print("COMPUTER :"+computer_move)
        print("PLAYER :"+player_move)
        print("You Won!!Yaay!")
        print("______________________________")
    else:
        score=score-1
        print("COMPUTER : "+computer_move)
        print("PLAYER : "+player_move)
        print("Hi!LOOSER!!")
        print("______________________________")
        
print("The final result is..")
if (score==0):
    print("Overall Tie..Play again..")
elif (score>0):
    print("WINNER!WINNER!!")
else:
    print("LAPPY IS THE WINNER!PLAY AGAIN!!")
