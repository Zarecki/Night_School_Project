DROP TABLE bookings;
DROP TABLE students;
DROP TABLE courses;

CREATE TABLE courses (
  id SERIAL2 PRIMARY KEY,
  title VARCHAR(255),
  capacity INT2,
  day VARCHAR(255),
  gender_requirement VARCHAR(255)
);

CREATE TABLE students (
  id SERIAL2 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  age INT2,
  ability INT2,
  gender VARCHAR(255)
);

CREATE TABLE bookings (
  id SERIAL4 PRIMARY KEY,
  student_id INT2 REFERENCES students(id) ON DELETE CASCADE,
  course_id INT2 REFERENCES courses(id) ON DELETE CASCADE
);
