class Student:
    def get_full_name(self):
        print("Полное имя: " + self.name + ' ' + self.last_name)


# ========== Create objects ==========================

student1 = Student()

student1.name = 'Сергей'
student1.last_name = 'Иванов'
student1.get_full_name()

student2 = Student()
student2.name = 'Мария'
student2.last_name = 'Петрова'
student2.get_full_name()


# ========== Compare objects ==========================

student2.name = "Сергей"
student2.lastName = "Иванов"

print(student1 == student2)   # False
print(id(student1), id(student2))

# Student.get_full_name(student1)

# student3 = Student()
# student3.get_full_name()   # AttributeError: 'Student' object has no attribute 'name'
