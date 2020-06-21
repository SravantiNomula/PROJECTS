import random

#random.randint(0,2) will guess a value between 0 and 2
#0-->(R)OCK; 1-->(P)APER;2-->(S)XR 
#Rock vs paper : Paper win
#paper vs sxr  : Sxr win
#Rock vs Sxr   : Rock win
print("0-->Rock, 1-->Paper, 2-->Sxr")
score=0

for i in range (6):
    #Making a guess 
    guess=random.randint(0,2)
    #User's turn
    print("Your turn!")
    choice=int(input())

    if(guess==choice):
        score=score
        print("It is a tie!")

    elif((guess==0 and choice==1)or (guess==1 and choice==2) or(guess==2 and choice==1)):
        score=score+1
        print("You Won!!Yaay!")
    else:
        scoere=score-1
        print("Hi!LOOSER!!")
        
print("The final result is..")
if (score==0):
    print("Overall Tie..Play again..")
elif (score>0):
    print("WINNER!WINNER!!")
else:
    print("LAPPY IS THE WINNER!PLAY AGAIN!!")
