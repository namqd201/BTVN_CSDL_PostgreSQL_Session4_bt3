-- *** 1. TẠO BẢNG VÀ CHÈN DỮ LIỆU BAN ĐẦU ***

-- Lệnh tạo bảng students
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    major VARCHAR(50),
    gpa DECIMAL(3,2)
);

-- Lệnh tạo bảng scholarships
CREATE TABLE scholarships (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(id),
    name VARCHAR(50),
    amount DECIMAL(10,2),
    year INT
);

-- Lệnh chèn dữ liệu ban đầu vào students
INSERT INTO students (name, age, major, gpa) VALUES
('An', 20, 'CNTT', 3.5),
('Bình', 21, 'Toán', 3.2),
('Cường', 22, 'CNTT', 3.8),
('Dương', 20, 'Vật lý', 3.0),
('Em', 21, 'CNTT', 2.9);

-- Lệnh chèn dữ liệu ban đầu vào scholarships
INSERT INTO scholarships (student_id, name, amount, year) VALUES
(1, 'Học bổng xuất sắc', 1000, 2025),
(3, 'Học bổng xuất sắc', 1200, 2025),
(2, 'Học bổng khuyến khích', 500, 2025),
(4, 'Học bổng khuyến khích', 400, 2025);

-- Thêm một học bổng phụ cho An (ID=1) để kiểm tra câu 5
INSERT INTO scholarships (student_id, name, amount, year) VALUES
(1, 'Học bổng nghiên cứu', 800, 2025);


-- *** 2. CÁC YÊU CẦU THỰC THI (6 bước) ***

-- 1. Thêm học bổng mới cho sinh viên "Em" (ID=5)
INSERT INTO scholarships (student_id, name, amount, year)
VALUES (
    (SELECT id FROM students WHERE name = 'Em'),
    'Học bổng khuyến khích',
    450,
    2025
);

-- 2. Cập nhật GPA của sinh viên có học bổng "Học bổng xuất sắc" lên 4.0 (ID=1:An và ID=3:Cường)
UPDATE students SET gpa = 4.0
WHERE id IN (
    SELECT student_id FROM scholarships WHERE name = 'Học bổng xuất sắc'
);

-- 3. Xóa các học bổng của sinh viên có GPA < 3.0 (ID=5:Em sau khi đã chèn học bổng)
DELETE FROM scholarships
WHERE student_id IN (
    SELECT id FROM students WHERE gpa < 3.0
);

-- 4. Liệt kê tên sinh viên, chuyên ngành, tên học bổng và số tiền của các học bổng năm 2025, sắp xếp theo tên sinh viên giảm dần
SELECT
    s.name AS student_name,
    s.major,
    sc.name AS scholarship_name,
    sc.amount
FROM
    students s
JOIN
    scholarships sc ON s.id = sc.student_id
WHERE
    sc.year = 2025
ORDER BY
    s.name DESC;

-- 5. Liệt kê các sinh viên có nhiều hơn 1 học bổng (sử dụng GROUP BY và HAVING) (Kết quả là sinh viên An - ID=1)
SELECT
    s.name AS student_name,
    COUNT(sc.id) AS total_scholarships
FROM
    students s
JOIN
    scholarships sc ON s.id = sc.student_id
GROUP BY
    s.id, s.name
HAVING
    COUNT(sc.id) > 1;

-- 6. Liệt kê sinh viên có tên chứa chữ 'C' và nhận học bổng (ID=3:Cường)
SELECT DISTINCT s.*
FROM students s
JOIN scholarships sc ON s.id = sc.student_id
WHERE s.name LIKE '%C%';

-- 7. Hiển thị 2 sinh viên đầu tiên theo GPA giảm dần, sử dụng LIMIT/OFFSET (Kết quả sau khi An và Cường được update lên 4.0)
SELECT * FROM students
ORDER BY gpa DESC
LIMIT 2;