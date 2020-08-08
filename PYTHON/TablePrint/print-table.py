# Hello World program in Python
    
#print "Hello World!\n"
tableData = [['apples', 'oranges', 'cherries', 'banana'],
            ['Alice', 'Bob', 'Carol', 'David'],
            ['dogs', 'cats', 'moose', 'goose']]


def printTable(table):
    list1=[]
    res=[]
    for i in table:
        width=0
        for j in i:        
            if len(j)>width:
                width=len(j)
            
        list1.append(width)
        
        
            
    for i in range(len(table[0])):
        for j in range (len(table)):
            #res[j][i]=table[i][j]         
            print(table[j][i].rjust(list1[j]), end=" ")
                  
        print("")

                  
 
printTable(tableData)

#i--0,1,2
#j--0,1,2,3
