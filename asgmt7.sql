-- Active: 1729919499199@@127.0.0.1@5432@university_db

-- Create students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    age INT,
    email VARCHAR(255) UNIQUE,
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);

-- Create courses table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    credits INT
);

-- Create enrollment table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students (student_id),
    course_id INT REFERENCES courses (course_id)
);

-- Insert students data
INSERT INTO
    students (
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        'Sameer',
        21,
        'sameer@example.com',
        48,
        60,
        NULL
    ),
    (
        'Zoya',
        23,
        'zoya@example.com',
        52,
        58,
        NULL
    ),
    (
        'Nabil',
        22,
        'nabil@example.com',
        37,
        46,
        NULL
    ),
    (
        'Rafi',
        24,
        'rafi@example.com',
        41,
        40,
        NULL
    ),
    (
        'Sophia',
        22,
        'sophia@example.com',
        50,
        52,
        NULL
    ),
    (
        'Hasan',
        23,
        'hasan@gmail.com',
        43,
        39,
        NULL
    );

-- Insert course data
INSERT INTO
    courses (course_name, credits)
VALUES ('Next.js', 3),
    ('React.js', 4),
    ('Databases', 3),
    ('Prisma', 3);

-- Insert enrollment data
INSERT INTO
    enrollment (student_id, course_id)
VALUES (1, 1),
    (1, 2),
    (2, 1),
    (3, 2);

-- Query 01
INSERT INTO
    students (
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        'Abdul jolil',
        26,
        'jolil@gmail.com',
        55,
        58,
        NULL
    );

-- Query 02
SELECT s.student_name
FROM
    students s
    JOIN enrollment e ON s.student_id = e.student_id
    JOIN courses c ON e.course_id = c.course_id
WHERE
    c.course_name = 'Next.js';

-- Query 03
UPDATE students
SET
    status = 'Awarded'
WHERE
    student_id = (
        SELECT student_id
        FROM students
        ORDER BY (frontend_mark + backend_mark) DESC
        LIMIT 1
    );

-- Query 04
DELETE FROM courses
WHERE
    course_id NOT IN (
        SELECT DISTINCT
            course_id
        FROM enrollment
    );

-- Query 05
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2
OFFSET
    2;

-- Query 06
SELECT c.course_name, COUNT(e.student_id) AS students_enrolled
FROM courses c
    INNER JOIN enrollment e ON c.course_id = e.course_id
GROUP BY
    c.course_name;

-- Query 07
SELECT CAST(AVG(age) AS DECIMAL(10, 2)) AS average_age FROM students;

-- Query 08
SELECT student_name
FROM students
WHERE
    email LIKE '%example.com%';

-- ========end========