#key is the name of fiend , value is dob
#Enter the name get bday


bday={"Name":"Jan 1",}

while True:
    print("Who's bday you wanna checkout?")
    name=input()
    if name=="":
        break
    
    if name in bday:
        print(name+" DOB: "+bday[name])

    else:
        #if their name is not present in our dict we have to add it
        print("We don't have their DOB. Common' add their DOB now!")
        dob=input()
        bday[name]=str(dob)
        print("Database updated")
        


print(bday)
    
