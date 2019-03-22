require_relative('../models/student.rb')
require_relative('../models/course.rb')

course1 = Course.new({
  'title' => 'Induction',
  'capacity' => 20,
  'day' => 'thursday'
  })





  student1 = Student.new({
    'first_name' => 'Jo',
    'last_name' => 'Bloggs',
    'age' => 52
    })

  student2 = Student.new({
    'first_name' => 'John',
    'last_name' => 'Doe',
    'age' => 65
    })

student1.save
student2.save




# Student.find_all

# Student.find_by_id(2)
