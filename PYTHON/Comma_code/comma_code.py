#Take list as input and output a comma separated string as output


list1=["Shreya","Shruti","BUPU"]
#list1=["bu","bui"]
#list1=["apple","banana","orange","cherry"]
#list1=[]

if  len(list1)==0:
    res=str("")
else:
    res=list1[0]
    for i in list1:
        if i!=list1[len(list1)-1] and i!=list1[0]:
            res=str(res+" ,"+i)

        elif i==list1[0]:
            res=res
            
        elif i==list1[len(list1)-1]:
            res=str(res+" and "+i+".")
    
print (res)
