

justin = User.create(name: "justin", email: "justin@gmail.com" , password:"password" )
cinthia = User.create(name: "cinthia", email: "cinthia@gmail.com" , password: "password")

read = Habit.create(habit: "reading")
code = Habit.create(habit: "coding")
test = Habit.create(habit: "test")
write = Habit.create(habit: "writing")

justin.habits = [read, code, test]
cinthia.habits = [read, write, test]






