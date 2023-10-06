# Cau 1
DELIMITER $$
create procedure THEM_SV(mssv char(8), hoten varchar(45), gioitinh char(1), ngaySinh date,noiSinh varchar(40), diaChi varchar(100), maKhoa char(8)) 
begin
INSERT INTO `sinhvien` (`mssv`, `hoten`, `gioiTinh`, `ngaySinh`, `noiSinh`, `DiaChi`, `maKhoa`) VALUES
(mssv, hoten, gioitinh, ngaySinh, noiSinh, diaChi, maKhoa);
End;
DELIMITER;
call THEM_SV('B2014946','Phan Phát Tài', 'M', '2002-01-23','Cần Thơ','Trần Nam Phú, Q.Ninh Kiều, TP Cần Thơ','CNTT&TT');

# Cau 2
DELIMITER $$
create procedure XOA_SV(in p_mssv char(8))
begin
 declare sv_count int;
  select count(*) into sv_count
  from sinhvien
  where mssv = p_mssv;
  if sv_count > 0 then
  delete from ketQua where mssv = p_mssv;
  delete from sinhvien where mssv = p_mssv;
  select 'Xoa Thanh Cong' as result;
  else
  select 'MSSV khong ton tai' as result;
  end if;
  
end;
DELIMITER;

call XOA_SV('B2014946');

# Cau 3
DELIMITER $$
create procedure DIEM_TB (in p_mssv char(8), out p_diem_tb float)
begin
declare v_diemtb float;
set p_diem_tb = -1;

select avg(diem) into v_diemtb
from ketQua
where mssv = p_mssv;
if v_diemtb is not null then
set p_diem_tb = v_diemtb;
end if;
end;
DELIMITER;

call DIEM_TB ('B1234567', @diem_tb);
select @diem_tb as DiemTrungBinh;


# Cau 4
DELIMITER $$
create procedure BANG_DIEM_TB (in p_makhoa char(8))
begin 
declare khoa_count int;
select count(*) into khoa_count
from khoa
where maKhoa = p_makhoa;

if khoa_count > 0 then
select sinhvien.mssv, sinhvien.hoten, avg(ketQua.diem) as diemTrungBinh
from sinhvien
inner join ketQua on sinhvien.mssv = ketQua.mssv
where sinhvien.maKhoa = p_makhoa
group by sinhvien.mssv, sinhvien.hoten;
else
select 'Ma khoa khong ton tai' as result;
end if;
end;
DELIMITER;
call BANG_DIEM_TB('CNTT&TT');


-- 5. Hàm xét tốt nghiệp trên sinh viên
DELIMITER $$
create procedure TotNghiep(MaSV char(8)) 
BEGIN
	DECLARE dem INT;
	DECLARE hang FLOAT;
	-- Tìm sinh viên
	SET dem = (SELECT COUNT(*) FROM sinhvien WHERE mssv = MaSV);
	if (dem > 0) then
		SET hang = (SELECT SUM(kq.diem * hq.soTinChi)/SUM(hq.soTinChi) AS DiemTrungBinh
		FROM ketqua kq INNER JOIN hocphan hq ON kq.maHP = hq.maHP
							INNER JOIN sinhvien sv ON sv.mssv = kq.mssv
		WHERE kq.mssv = MaSV
		GROUP BY(sv.mssv));
		if(hang > 4) then
			SELECT 'TRUE';
		else
			SELECT 'FALSE';
		END if;
	else
		SELECT '-1';
	END if;
END; $$
DELIMITER ;

call TotNghiep('B1234567');

# Cau 6
DELIMITER $$
create procedure Loai_Tot_Nghiep(MaSV char(8)) 
BEGIN
	DECLARE dem INT;
	DECLARE hang FLOAT;
	-- Tìm sinh viên
	SET dem = (SELECT COUNT(*) FROM sinhvien WHERE mssv = MaSV);
	if (dem > 0) then
		SET hang = (SELECT SUM(kq.diem * hq.soTinChi)/SUM(hq.soTinChi) AS DiemTrungBinh
		FROM ketqua kq INNER JOIN hocphan hq ON kq.maHP = hq.maHP
							INNER JOIN sinhvien sv ON sv.mssv = kq.mssv
		WHERE kq.mssv = MaSV
		GROUP BY(sv.mssv));
		if(hang >= 9 or hang <=10) then
			SELECT 'Xuất sắc';
		ELSEIF (hang >= 8 or hang <= 8.9) then
			SELECT 'Giỏi';
		ELSEIF (hang >= 6.5 or hang <= 7.9) then
			SELECT 'Khá';
		ELSEIF (hang >= 5.5 or hang <= 6.5) then
			SELECT 'Trung bình';
		ELSEIF (hang >= 4 or hang < 5.5) then
			SELECT 'Yếu';
		ELSEIF (hang < 4) then
			SELECT 'Kém';
		END if;
	else
		SELECT '-1';
	END if;
END; $$
DELIMITER ;

call Loai_Tot_Nghiep('B1234567');


-- Câu 7
DELIMITER $$
CREATE PROCEDURE SV_TOT_NGHIEP(MKhoa CHAR(8))
BEGIN
    -- Khai báo biến lưu trữ dữ liệu từ con trỏ
    DECLARE mssv CHAR(8);
    DECLARE hoten VARCHAR(50);
    DECLARE Tot_Nghiep FLOAT;
    DECLARE LoaiTotNghiep VARCHAR(50);
    DECLARE done INT DEFAULT 0;

    -- Tạo con trỏ
    DECLARE C CURSOR FOR
        SELECT sv.mssv, sv.hoten, TotNghiep(sv.mssv), Loai_Tot_Nghiep(sv.mssv)
        FROM ketqua kq
        INNER JOIN hocphan hq ON kq.maHP = hq.maHP
        INNER JOIN sinhvien sv ON sv.mssv = kq.mssv
        INNER JOIN khoa k ON sv.maKhoa = k.maKhoa
        WHERE k.maKhoa = MKhoa
        GROUP BY (sv.mssv)
		  HAVING TotNghiep(sv.mssv) > 0;

    -- Khai báo NOT FOUND handler để xử lý lỗi không tìm thấy dữ liệu
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Mở con trỏ
    OPEN C;

    -- Bắt đầu vòng lặp
    WHILE done = 0 DO
        FETCH C INTO mssv, hoten, Tot_Nghiep, LoaiTotNghiep;
        IF NOT done THEN
            SELECT mssv, hoten, Tot_Nghiep, LoaiTotNghiep;
        END IF;
    END WHILE;
    	

    -- Đóng con trỏ
    CLOSE C;
END$$
DELIMITER ;
call SV_TOT_NGHIEP('KT');


# Cau 8
CREATE FUNCTION SL_SV_KHOA( TKhoa VARCHAR(50))	RETURNS INT 
BEGIN
	DECLARE dem INT;
	DECLARE soLuong INT;
	-- Tìm sinh viên
	SET dem = (SELECT COUNT(*) FROM khoa WHERE tenKhoa = TKhoa);
	if (dem > 0) then
		SET soLuong = (SELECT COUNT(*)
							FROM sinhvien sv INNER JOIN khoa ON sv.maKhoa = khoa.maKhoa
							WHERE khoa.tenKhoa = TKhoa	
							GROUP BY (khoa.maKhoa));
		RETURN soLuong;
	else
		RETURN -1;
	END if;
END;$$
DELIMITER ;

# Cau 9
DELIMITER $$
CREATE PROCEDURE SV_Loai(in tenLoai VARCHAR(20))
BEGIN
    SELECT mssv,hoten, Loai_Tot_Nghiep(mssv) 
	FROM sinhvien
	WHERE Loai_Tot_Nghiep(mssv) = tenLoai;
END$$
DELIMITER ;
call SV_Loai('Giỏi');


-- 10. Đặt quy luật không được phép xóa sinh viên từ khoa CNTT&TT
DELIMITER $$
CREATE TRIGGER KhongXoaSinhVienCNTT BEFORE DELETE	-- Sự kiện này bắt đầu trước sự kiện xóa
ON sinhvien
FOR EACH ROW -- Kiểm tra trên mỗi dòng
BEGIN
	DECLARE mak VARCHAR(10);
	
	SELECT maKhoa INTO mak
	FROM khoa
	WHERE maKhoa = OLD.maKhoa;

	if OLD.maKhoa = 'CNTT&TT' then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT ='Không được quyền xóa sinh viên từ khoa CNTT&TT';
	END if;
END;$$
DELIMITER ;