require_relative('../models/student.rb')
require_relative('../models/course.rb')

Student.delete_all
Course.delete_all

course1 = Course.new({
  'title' => 'Induction',
  'capacity' => 20,
  'day' => 'thursday'
  })

course1.save



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

# Student.delete_student(4)

# Student.delete_all

student1.book_in_to_course(course1.id)
student2.book_in_to_course(course1.id)

course1.list_students_by_course
