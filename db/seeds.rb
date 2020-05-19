

justin = User.create(name: "justin", email: "justin@gmail.com" , password:"password" )
cinthia = User.create(name: "cinthia", email: "cinthia@gmail.com" , password: "password")

justin.habits.create(habit: "Reading")
cinthia.habits.create(habit: "Writing")

