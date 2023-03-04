class Student:
    def __init__(self, name, last_name):
        self.hidden_name = name
        self.hidden_last_name = last_name

    def get_name(self):
        print('Inside getter')
        return self.hidden_name

    def set_name(self, name):
        print('Inside setter')
        self.hidden_name = name;
        
    name = property(get_name, set_name)

    @property
    def last_name(self):
        print('Inside getter')
        return self.hidden_last_name

    @last_name.setter
    def last_name(self, last_name):
        print('Inside setter')
        self.hidden_last_name = last_name;

    def get_full_name(self):
        print("Полное имя: " + self.hidden_name + ' ' + self.hidden_last_name)


student1 = Student('Сергей', 'Иванов')
student1.get_name()
student1.name

print(student1.hidden_name)

student1.last_name = 'Андреев'
student1.get_full_name()
