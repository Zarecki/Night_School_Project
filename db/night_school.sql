DROP TABLE bookings;
DROP TABLE students;
DROP TABLE courses;

CREATE TABLE courses (
  id SERIAL2 PRIMARY KEY,
  title VARCHAR(255),
  capacity INT2,
  day VARCHAR(255),
  session VARCHAR(255),
  level INT2,
  number_of_students INT2,
  id INT2
);

CREATE TABLE students (
  id SERIAL2 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  age INT2,
  ability INT2,
  gender INT2,
  course_id REFERENCES courses(id) ON DELETE CASCADE
);

CREATE TABLE bookings (
  id SERIAL4 PRIMARY KEY,
  student_id REFERENCES students(id) ON DELETE CASCADE,
  course_id REFERENCES courses(id) ON DELETE CASCADE
);
