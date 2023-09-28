USE dbms;

create table khoa(
maKhoa char(8),
tenKhoa varchar(50)
);
--
create table sinhVien (
mssv char(8),
hoTen varchar(45),
ngaySinh date,
noiSinh varchar(40),
diaChi varchar(100),
maKhoa char(8),
primary key (mssv),
foreign key(mssv) references sinhVien(mssv),
foreign key(maHP) references ketQua(maHP)
);

--
create table ketQua (
mssv char(8),
maHP char(6),
diem FLOAT,
foreign key (mssv) references sinhvien(mssv),
foreign key (maHP) references hocPhan(maHP)
);

--
CREATE TABLE hocPhan (
  maHP char(6),
  tenHP varchar(50),
  soTinChi int,
  soTietLT int,
  soTietTH int,
  PRIMARY KEY (maHP)
);

---

INSERT INTO `hocphan` (`maHP`, `tenHP`, `soTinChi`, `soTietLT`, `soTietTH`) VALUES
	('CT101', 'Lập Trình Căn Bản', 4, 30, 60),
	('CT176', 'Lập Trình Hướng đối tượng', 3, 30, 30),
	('CT237', 'Nguyên lý Hệ Điều Hành', 3, 30, 30),
	('SP102', 'Đại số tuyến tính', 4, 60, 0),
	('TN001', 'Vi tích phân A1', 3, 45, 0),
	('TN021', 'Hóa học đại cương', 3, 60, 0),
	('TN101', 'Xác suất thống kê', 3, 45, 0),
	('TN172', 'Toán rời rạc', 4, 60, 0),
	('XH023', 'Anh Văn Căn Bản 1', 4, 60, 0);
    
---

INSERT INTO `ketqua` (`mssv`, `maHP`, `diem`) VALUES
	('B1234567', 'CT101', 4),
	('B1234568', 'CT176', 8),
	('B1234569', 'CT237', 9),
	('B1334569', 'SP102', 2),
	('B1345678', 'CT101', 6),
	('B1345679', 'CT176', 5),
	('B1456789', 'TN172', 10),
	('B1459230', 'TN172', 7),
	('B1456789', 'XH023', 6),
	('B1459230', 'XH023', 8),
	('B1234567', 'CT176', 1),
	('B1234568', 'CT101', 9),
	('B1234569', 'CT101', 8),
	('B1334569', 'CT101', 4),
	('B1345678', 'TN001', 6),
	('B1345679', 'CT101', 2),
	('B1456789', 'CT101', 7),
	('B1456790', 'TN101', 6),
	('B1345680', 'TN101', 7),
	('B1345680', 'XH023', 7);
---
INSERT INTO `khoa` (`maKhoa`, `tenKhoa`) VALUES
	('CNTT&TT', 'Công nghệ thông tin & Truyền thông'),
	('KT', 'Khoa kinh tế'),
	('NNG', 'Khoa Ngoại ngữ'),
	('SP', 'Khoa Sư Phạm'),
	('TN', 'Khoa Khoa Học Tự nhiên'),
	('TS', 'Khoa Thủy Sản');
---
INSERT INTO `sinhvien` (`mssv`, `hoten`, `gioiTinh`, `ngaySinh`, `noiSinh`, `DiaChi`, `maKhoa`) VALUES
	('B1234567', 'Nguyễn Thành Hải', 'M', '2000-12-02', 'Bạc Liêu', 'Phòng 01, KTX Khu B,', 'CNTT&TT'),
	('B1234568', 'Trần Thanh Mai', 'M', '2001-01-20', 'Cần Thơ', '232, Nguyễn Văn Khéo,Q.Ninh Kiều ,TPCT', 'CNTT&TT'),
	('B1234569', 'Trần Thu Thủy', 'F', '2001-07-01', 'Cần Thơ', '02, Đại lộ Hòa Bình, Q.Ninh Kiều , TPCT', 'CNTT&TT'),
	('B1334569', 'Nguyễn Thị Trúc Mã', 'F', '2002-05-25', 'Sóc Trăng', '343, Đường 30/4, Q/Ninh Kiều, TPCT', 'SP'),
	('B1345678', 'Trần Hồng Trúc', 'F', '2002-03-02', 'Cần Thơ', '123, Trần Hưng Đạo, Q.Ninh Kiều , TPCT', 'CNTT&TT'),
	('B1345679', 'Bùi Hoàng Yến', 'F', '2001-11-05', 'Vĩnh Long', 'Phòng 201, KTX Khu A,TPCT', 'CNTT&TT'),
	('B1345680', 'Trần Minh Tâm', 'M', '2001-02-04', 'Cà Mau', '07, Đại lộ Hòa Bình, Q.Ninh Kiều,TPCT', 'KT'),
	('B1456789', 'Nguyễn Hồng Thắm', 'F', '2003-05-09', 'An Giang', '133, Nguyễn Văn Cừ, Q.Ninh Kiều,TPCT', 'NNG'),
	('B1456790', 'Lê Khải Hoàng', 'M', '2002-07-03', 'Kiên Giang', '03, Trần Hoàng Na, Q.Ninh Kiều,TPCT', 'TS'),
	('B1459230', 'Lê Văn Khang', 'M', '2002-06-02', 'Đồng Tháp', '312, Nguyễn Văn Linh, Q.Ninh Kiều,TPCT', 'TN');
