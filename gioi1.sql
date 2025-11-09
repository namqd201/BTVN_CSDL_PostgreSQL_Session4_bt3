-- *** 1. TẠO BẢNG (Giả định) VÀ CHÈN DỮ LIỆU BAN ĐẦU ***

-- Lệnh tạo bảng (ví dụ cấu trúc)
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(50),
    gender VARCHAR(10),
    birth_year INT,
    major VARCHAR(50),
    gpa DECIMAL(3,2)
);

-- Lệnh chèn dữ liệu ban đầu
INSERT INTO students (full_name, gender, birth_year, major, gpa) VALUES
('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
('Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
('Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
('Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
('Lưu Đức Tài', 'Nam', 2004, 'Cơ khí', NULL),
('Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);


-- *** 2. CÁC YÊU CẦU THỰC THI (8 bước) ***

-- 1. Thêm sinh viên mới: "Phạm Hoàng Nam", Nam, 2003, CNTT, GPA 3.8
INSERT INTO students (full_name, gender, birth_year, major, gpa) VALUES
('Phạm Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);

-- 2. Cập nhật GPA của sinh viên "Lê Quốc Cường" thành 3.4
UPDATE students SET gpa = 3.4 WHERE full_name = 'Lê Quốc Cường';

-- 3. Xóa tất cả sinh viên có GPA IS NULL
DELETE FROM students WHERE gpa IS NULL;

-- 4. Hiển thị sinh viên ngành CNTT có gpa >= 3.0, chỉ lấy 3 kết quả đầu tiên
SELECT * FROM students WHERE major = 'CNTT' AND gpa >= 3.0 LIMIT 3;

-- 5. Liệt kê danh sách ngành học duy nhất
SELECT DISTINCT major FROM students;

-- 6. Hiển thị sinh viên ngành CNTT, sắp xếp giảm dần theo GPA, sau đó tăng dần theo tên
SELECT * FROM students WHERE major = 'CNTT' ORDER BY gpa DESC, full_name ASC;

-- 7. Tìm sinh viên có tên bắt đầu bằng "Nguyễn"
SELECT * FROM students WHERE full_name LIKE 'Nguyễn%';

-- 8. Hiển thị sinh viên có năm sinh từ 2001 đến 2003
SELECT * FROM students WHERE birth_year BETWEEN 2001 AND 2003;