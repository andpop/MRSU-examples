class Student:
    def __init__(self, name, last_name):
        self.__name = name
        self.__last_name = last_name

    def get_name(self):
        return self.__name

    def set_name(self, name):
        self.__name = name;

    def get_last_name(self):
        return self.__last_name

    def set_last_name(self, last_name):
        self.__last_name = last_name;

    def get_full_name(self):
        print("Полное имя: " + self.__name + ' ' + self.__last_name)


student1 = Student('Сергей', 'Иванов')
student1.get_full_name()

print(student1.get_name())
student1.set_name('Петр')
print(student1.get_name())

# print(student1.__name)
# print(student1._Student__name)

print(dir(student1))

