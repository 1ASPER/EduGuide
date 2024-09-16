/* DLL description of EduGuide database structure */

CREATE TABLE EducationalInstitution (
    institution_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    type NVARCHAR(50) CHECK (type IN ('university', 'school', 'course', 'other')),
    description NVARCHAR(MAX),
    location NVARCHAR(255),
    website_url NVARCHAR(255),
    contact_email NVARCHAR(255)
);

CREATE TABLE Course (
    course_id INT IDENTITY(1,1) PRIMARY KEY,
    institution_id INT NOT NULL,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    duration INT, 
    price DECIMAL(10, 2),
    course_level NVARCHAR(50) CHECK (course_level IN ('beginner', 'intermediate', 'advanced')),
    start_date DATE,
    FOREIGN KEY (institution_id) REFERENCES EducationalInstitution(institution_id)
        ON DELETE CASCADE
);

CREATE TABLE Student (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(255) NOT NULL,
    last_name NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL,
    phone_number NVARCHAR(20),
    date_of_birth DATE,
    registered_date DATETIME DEFAULT GETDATE()
);

CREATE TABLE Enrollment (
    enrollment_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) CHECK (status IN ('enrolled', 'completed', 'dropped')),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
        ON DELETE CASCADE
);

CREATE TABLE Review (
    review_id INT IDENTITY(1,1) PRIMARY KEY,
    course_id INT NOT NULL,
    student_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment NVARCHAR(MAX),
    review_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
        ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON DELETE CASCADE
);

CREATE TABLE InstitutionType (
    type_id INT IDENTITY(1,1) PRIMARY KEY,
    type_name NVARCHAR(255) NOT NULL
);
