# Cau 1
select mssv, hoten, gioiTinh, noiSinh
from sinhvien
order by mssv desc;
# Cau 2
select mssv, hoten, diaChi
from sinhvien
where ngaysinh like '2001%';
# Cau 3
select mssv, hoten, tenHP, diem
from sinhvien
natural join ketqua, hocphan;
# Cau 4
select mssv, hoten
from sinhvien sv
join khoa k on sv.maKhoa = k.maKhoa
where gioiTinh = 'F';
# Cau 5
SELECT 
    sv.mssv,
    sv.hoTen AS 'Họ Tên',
    kq.maHP AS 'Mã Học Phần',
    kq.diem AS 'Điểm'
FROM
    sinhvien sv
JOIN
    ketqua kq ON sv.mssv = kq.mssv
JOIN
    hocphan hp ON kq.maHP = hp.maHP;
# Cau 6
SELECT 
    hp.maHP AS 'Mã Học Phần',
    hp.tenHP AS 'Tên Học Phần'
FROM
    hocphan hp
LEFT JOIN
    ketqua kq ON hp.maHP = kq.maHP
WHERE
    kq.maHP IS NULL;
# Cau 7
SELECT 
    sv.mssv AS 'MSSV',
    sv.hoTen AS 'Họ Tên'
FROM
    sinhvien sv
JOIN
    (
        SELECT 
            mssv,
            AVG(diem) AS diem_trung_binh
        FROM
            ketqua
        GROUP BY
            mssv
    ) avg_diem ON sv.mssv = avg_diem.mssv
ORDER BY
    avg_diem.diem_trung_binh DESC
LIMIT 1;

# Cau 8
select k.maKhoa,k.tenKhoa, count(sv.mssv) as SLSV
from khoa k
left join sinhvien sv on k.maKhoa = sv.maKhoa
group by k.maKhoa, k.tenKhoa;

# Cau 9

select sv.mssv ,k.tenKhoa
from khoa k
left join sinhvien sv on k.maKhoa = sv.maKhoa
where sv.hoten like '%Khang';

# Cau 10
select sv.mssv, sv.hoten, kq.maHP, kq.diem
from sinhvien sv
join
ketqua kq on sv.mssv = kq.mssv
order by sv.maKhoa ASC, sv.hoTen ASC;

# Cau 11
update ketqua kq
join sinhvien sv on kq.mssv = sv.mssv
set kq.diem = kq.diem + 1
where sv.maKhoa <> 'CNTT&TT' and kq.maHP = 'CT101';

# Cau 12

select sv.mssv, sv.hoTen
from sinhvien sv
join ketqua kq on sv.mssv = kq.mssv
where kq.maHP = 'CT101' and sv.mssv in (
select mssv from ketqua where maHP = 'CT176');

# Cau 13
select sv.mssv, sv.hoten
from sinhvien sv
join ketqua kq on sv.mssv = kq.mssv
join hocphan hp on kq.maHP = hp.maHP
where hp.tenHP <> 'Anh văn căn bản 1';

# Cau 14
select sv.hoten, sv.noisinh, sv.maKhoa
from sinhvien sv
where sv.ngaySinh = (select max(ngaySinh) from sinhvien);

# Cau 15

select k.maKhoa, k.tenKhoa, sum(case when gioiTinh = 'M' then 1 else 0 end) as 'Số Nam',
sum(case when gioiTinh = 'F' then 1 else 0 end) as 'Số nữ'
from sinhvien sv
join khoa k on sv.maKhoa = k.maKhoa
group by maKhoa, tenKhoa;

# Cau 16
select sv.mssv, hp.maHP, sv.hoten
from sinhvien sv
join ketqua kq on sv.mssv = kq.mssv
join hocphan hp on kq.maHP = hp.maHP
where kq.diem < 5;

# Cau 17
alter table sinhvien
modify column mssv char(8) check (mssv REGEXP '^[A-Z][0-9]{8}$');

# Cau 18
ALTER TABLE sinhvien
modify column hoten varchar(45)
CHECK (hoten REGEXP '^[a-zA-Z ]+$');

# Cau 19
ALTER TABLE ketqua
modify column diem float
CHECK(diem between 0 and 10);

# Cau 20
ALTER TABLE sinhvien
modify column gioitinh char(1)
CHECK(gioitinh in('F','M'));


SELECT hoten
FROM sinhvien
WHERE hoten NOT REGEXP '^[a-zA-Z ]+$';

SELECT mssv
FROM sinhvien
WHERE mssv NOT REGEXP '^[A-Z][0-9]{8}$';
