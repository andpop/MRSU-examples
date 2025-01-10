class Student:
    def __init__(self, name, last_name):
        self.name = name
        self.last_name = last_name

    def get_full_name(self):
        print("Полное имя: " + self.name + ' ' + self.last_name)


student1 = Student('Сергей', 'Иванов')
student1.get_full_name()

student2 = Student('Мария', 'Иванова')
student2.get_full_name()

