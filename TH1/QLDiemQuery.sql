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
