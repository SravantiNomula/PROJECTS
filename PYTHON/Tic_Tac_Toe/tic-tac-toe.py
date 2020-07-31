#   a1  |  a2   | a3
#_______|_______|_____
#  b1   |  b2   |  b3
#_______|_______|________
#  c1   |  c2   |  c3
#       |       | 
import sys
board={"a1":" ","a2":" ","a3":" ",
       "b1":" ","b2":" ","b3":" ",
       "c1":" ","c2":" ","c3":" "}

#Function to print a board.
def print_board(board):
    print(board["a1"]+"|"+board["a2"]+"|"+board["a3"])
    print("-----")
    print(board["b1"]+"|"+board["b2"]+"|"+board["b3"])
    print("-----")
    print(board["c1"]+"|"+board["c2"]+"|"+board["c3"])


#Function to declare if any winner is there    
def winner(board):
    if(board["a1"]==board["a2"]==board["a3"]!=" ") or (board["b1"]==board["b2"]==board["b3"]!=" ") or (board["c1"]==board["c2"]==board["c3"]!=" ") or (board["a1"]==board["b1"]==board["c1"]!=" ") or (board["a2"]==board["b2"]==board["c2"]!=" ") or (board["a3"]==board["b3"]==board["c3"]!=" ") or (board["a1"]==board["b2"]==board["c3"]!=" ") or (board["a3"]==board["b2"]==board["c1"]!=" "):
        print("THE WINNNNNNNNNNERRR is X"+p)
        print_board(board)
        
        sys.exit()
    
#print_board(board)

#first user
print("Who is going to make the 1st move x or o??")
p1=input()
p=p1
if(p1=="x"):
    p2="o"
else:
    p2="x"

    
#take values and fill the board
for i in range (9):
    print("Enter the target position")
    move=input()
    if(board[move]==" "):
        board[move]=p
    else:
        print("Foul play!!That spot was already researved!Lost your chance")
    winner(board)
    
    if (p==p1):
        p=p2
    else:
        p=p1   
    print_board(board)
    
