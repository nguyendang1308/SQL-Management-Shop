USE master
GO
--Check có tồn tại database
IF EXISTS(select name from sys.databases where name='QLBANHANG')
DROP DATABASE QLBANHANG
GO
--Tạo database 
CREATE DATABASE QLBANHANG
	ON (NAME = 'QLBANHANG_DATA', FILENAME = 'F:\Dani SQL\QLBANHANG.MDF')
	LOG ON (NAME = 'QLBANHANG_LOG', FILENAME = 'F:\Dani SQL\QLBANHANG.LDF')
GO
--Backup
BACKUP DATABASE QLBANHANG TO DISK = 'F:\Dani SQL\QLBANHANG.bak'
GO
--Started
USE QLBANHANG
GO
--Bảng Khách Hàng
CREATE TABLE KHACHHANG
(
	MAKH VARCHAR(5) PRIMARY KEY,TENKH NVARCHAR(30) NOT NULL ,DIACHI NVARCHAR(50),DT VARCHAR(11),EMAIL VARCHAR(30)
)
--ALTER TABLE dbo.KHACHHANG ADD CONSTRAINT CHECK_DT CHECK(DT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
ALTER TABLE dbo.KHACHHANG ADD CONSTRAINT CHECK_DT1 CHECK(DT >= 10)
GO
--Bảng Vật Tư
CREATE TABLE VATTU
(
	MAVT VARCHAR(5) PRIMARY KEY , TENVT NVARCHAR(30) NOT NULL, DVT NVARCHAR(20) , 
	GIAMUA MONEY CHECK(GIAMUA > 0), SLTON INT CHECK(SLTON >= 0)
)
GO
--Bảng Hóa Đơn
CREATE TABLE HOADON
(
	MAHD VARCHAR(10) PRIMARY KEY,NGAY DATE CHECK(NGAY <= GETDATE()),
	MAKH VARCHAR(5) FOREIGN KEY(MAKH) REFERENCES dbo.KHACHHANG(MAKH)
	, TONGTG FLOAT
)
GO
--Bảng Chi Tiết Hóa Đơn
CREATE TABLE CTHD
(
	PRIMARY KEY(MAHD,MAVT),MAHD VARCHAR(10) FOREIGN KEY(MAHD) REFERENCES dbo.HOADON(MAHD)
	, MAVT VARCHAR(5) FOREIGN KEY(MAVT) REFERENCES dbo.VATTU(MAVT),
	SL INT CHECK(SL > 0) , KHUYENMAI FLOAT , GIABAN FLOAT 
)
GO
--Định dạng lại ngày
SET DATEFORMAT DMY;
--Thêm dữ liệu VATTU
INSERT INTO dbo.VATTU
(
    MAVT,
    TENVT,
    DVT,
    GIAMUA,
    SLTON
)
VALUES
(   'VT01',   -- MAVT - varchar(5)
    N'Xi Măng',  -- TENVT - nvarchar(30)
    N'Bao', -- DVT - nvarchar(20)
    50000, -- GIAMUA - money
    5000  -- SLTON - int
)
INSERT INTO VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) VALUES ('VT02',N'Cát',N'Khối',45000,50000)
INSERT INTO VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) VALUES ('VT03',N'Gạch',N'Viên',120,800000)
INSERT INTO VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) VALUES ('VT04',N'Gạch',N'Viên',110,800000)
INSERT INTO VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) VALUES ('VT05',N'Đá lớn',N'Khối',25000,100000)
INSERT INTO VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) VALUES ('VT06',N'Đá nhỏ',N'Khối',33000,100000)
INSERT INTO VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON) VALUES ('VT07',N'Lam gió',N'Cái',15000,50000)
--Khách Hàng
INSERT INTO dbo.KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL) VALUES('KH01',N'NGUYỄN THỊ BÉ',N'TÂN BÌNH','38457895','BNT@YAHOO.COM')
INSERT INTO dbo.KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL) VALUES('KH02',N'LÊ HÒANG NAM',N'BÌNH CHÁNH','34568711','NAMLEHOANG@GMAIL.VN')
INSERT INTO dbo.KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL) VALUES('KH03',N'TRẦN THỊ CHIÊU',N'TÂN BÌNH','38457895',null)
INSERT INTO dbo.KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL) VALUES('KH04',N'MAI THỊ QUẾ ANH',N'BÌNH CHÁNH',null,null)
INSERT INTO dbo.KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL) VALUES('KH05',N'LÊ VĂN SÁNG',N'QUẬN 10',null,'SANGLV@HCM.VNN.VN')
INSERT INTO dbo.KHACHHANG(MAKH,TENKH,DIACHI,DT,EMAIL) VALUES('KH06',N'TRẦN HOÀNG',N'TÂN BÌNH','38457897',null)
--Hóa Đon
INSERT INTO dbo.HOADON(MAHD,NGAY,MAKH,TONGTG) VALUES('HD01','12/05/2010','KH01',null)
INSERT INTO dbo.HOADON(MAHD,NGAY,MAKH,TONGTG) VALUES('HD02','25/05/2010','KH02',null)
INSERT INTO dbo.HOADON(MAHD,NGAY,MAKH,TONGTG) VALUES('HD03','25/05/2010','KH01',null)
INSERT INTO dbo.HOADON(MAHD,NGAY,MAKH,TONGTG) VALUES('HD04','25/05/2010','KH04',null)
INSERT INTO dbo.HOADON(MAHD,NGAY,MAKH,TONGTG) VALUES('HD05','26/05/2010','KH04',null)
INSERT INTO dbo.HOADON(MAHD,NGAY,MAKH,TONGTG) VALUES('HD06','02/06/2010','KH03',null)
INSERT INTO dbo.HOADON(MAHD,NGAY,MAKH,TONGTG) VALUES('HD07','22/06/2010','KH04',null)
INSERT INTO dbo.HOADON(MAHD,NGAY,MAKH,TONGTG) VALUES('HD08','25/06/2010','KH03',null)
INSERT INTO dbo.HOADON(MAHD,NGAY,MAKH,TONGTG) VALUES('HD09','15/08/2010','KH04',null)
INSERT INTO dbo.HOADON(MAHD,NGAY,MAKH,TONGTG) VALUES('HD10','30/09/2010','KH01',null)
--Chi tiết hóa đơn
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD01','VT01',5,null,52000)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD01','VT05',10,null,30000)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD02','VT03',10000,null,150)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD03','VT02',20,null,55000)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD04','VT03',50000,null,150)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD04','VT04',20000,null,120)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD05','VT05',10,null,30000)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD05','VT06',15,null,35000)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD05','VT07',20,null,17000)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD06','VT04',10000,null,120)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD07','VT04',20000,null,125)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD08','VT01',100000,null,55000)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD08','VT02',20,null,47000)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD09','VT02',25,null,48000)
INSERT INTO dbo.CTHD(MAHD,MAVT,SL,KHUYENMAI,GIABAN) VALUES('HD10','VT01',25,null,57000)
GO
--Câu hỏi
--1.	Hiển thị danh sách các khách hàng có địa chỉ là “Tân Bình” gồm mã khách hàng
--, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
CREATE VIEW V1 AS
SELECT *
FROM dbo.KHACHHANG
WHERE DIACHI = N'Tân Bình'
GO
--2.	Hiển thị danh sách các khách hàng gồm các thông tin mã khách hàng, tên khách hàng, địa chỉ và 
--địa chỉ E-mail của những khách hàng chưa có số điện thoại.
CREATE VIEW V2 AS
SELECT MAKH,TENKH,DIACHI,EMAIL
FROM dbo.KHACHHANG
WHERE DT is NULL
GO
--3.	Hiển thị danh sách các khách hàng chưa có số điện thoại và 
--cũng chưa có địa chỉ Email gồm mã khách hàng, tên khách hàng, địa chỉ.
CREATE VIEW V3 AS
SELECT MAKH,TENKH,DIACHI
FROM dbo.KHACHHANG
WHERE DT is NULL AND EMAIL IS NULL
GO
--4.	Hiển thị danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail gồm mã khách hàng, 
--tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
CREATE VIEW V4 AS
SELECT TENKH,DIACHI,DT,EMAIL
FROM dbo.KHACHHANG
WHERE DT IS NOT NULL AND EMAIL IS NOT NULL
GO
--5.Hiển thị danh sách các vật tư có đơn vị tính là “Cái” gồm mã vật tư, tên vật tư và giá mua
CREATE VIEW V5 AS
SELECT MAVT,TENVT,GIAMUA
FROM dbo.VATTU
WHERE DVT LIKE N'Cái'
GO
--6.Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua trên 25000.
CREATE VIEW V6 AS
SELECT MAVT,TENVT,DVT,GIAMUA
FROM dbo.VATTU
WHERE GIAMUA > 25000
GO
--7.Hiển thị danh sách các vật tư là “Gạch” (bao gồm các loại gạch) gồm mã vật tư, tên vật tư, đơn vị tính và giá mua
CREATE VIEW V7 AS
SELECT MAVT,TENVT,DVT,GIAMUA
FROM dbo.VATTU 
WHERE TENVT LIKE N'Gạch'
GO
--8.Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua nằm trong khoảng từ 20000 đến 40000.
CREATE VIEW V8 AS
SELECT MAVT,TENVT,DVT,GIAMUA
FROM dbo.VATTU
WHERE GIAMUA >= 20000 AND GIAMUA <= 40000
GO
--9.Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
CREATE VIEW V9 AS
SELECT A.MAHD,A.NGAY,B.TENKH,B.DIACHI,B.DT
FROM dbo.HOADON A INNER JOIN dbo.KHACHHANG B ON A.MAKH = B.MAKH
GO
--10.Lấy ra các thông tin gồm Mã hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của ngày 25/5/2010
CREATE VIEW V10 AS
SELECT A.MAHD,B.TENKH,B.DIACHI,B.DT
FROM dbo.HOADON A INNER JOIN dbo.KHACHHANG B ON A.MAKH = B.MAKH
WHERE A.NGAY = '25/5/2010'
GO
--11.Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của những hóa đơn trong tháng 6/2010.
CREATE VIEW V11 AS
SELECT A.MAHD,A.NGAY,B.TENKH,B.DIACHI,B.DT 
FROM dbo.HOADON A INNER JOIN dbo.KHACHHANG B ON A.MAKH = B.MAKH
WHERE YEAR(A.NGAY) = 2010 AND MONTH(A.NGAY) = 6
GO
--12.Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) đã mua hàng trong tháng 6/2010.
CREATE VIEW V12 AS
SELECT C.TENKH,C.DIACHI,C.DT
FROM dbo.CTHD A , dbo.HOADON B,dbo.KHACHHANG C
WHERE A.MAHD = B.MAHD AND B.MAKH = C.MAKH
	  AND (MONTH(B.NGAY) = 6 AND YEAR(B.NGAY) = 2010)
GROUP BY C.TENKH,C.DIACHI,C.DT
GO
--13.Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2010 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
CREATE VIEW V13 AS
SELECT C.TENKH,C.DIACHI,C.DT
FROM dbo.CTHD A , dbo.HOADON B,dbo.KHACHHANG C
WHERE A.MAHD = B.MAHD AND B.MAKH = C.MAKH
	  AND (MONTH(B.NGAY) != 6 OR YEAR(B.NGAY) != 2010)
GROUP BY C.TENKH,C.DIACHI,C.DT
GO
--14.Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, 
--số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng).
CREATE VIEW V14 AS 
SELECT A.MAVT,B.TENVT,B.DVT,A.GIABAN,B.GIAMUA,A.SL,(B.GIAMUA*A.SL) AS N'Trị giá mua',(A.GIABAN * A.SL) AS N'Trị giá bán'
FROM dbo.CTHD A INNER JOIN dbo.VATTU B ON A.MAVT = B.MAVT
GO
--15.Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, 
--số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) mà có giá bán lớn hơn hoặc bằng giá mua.
CREATE VIEW V15 AS 
SELECT A.MAVT,B.TENVT,B.DVT,A.GIABAN,B.GIAMUA,A.SL,(B.GIAMUA*A.SL) AS N'Trị giá mua',(A.GIABAN * A.SL) AS N'Trị giá bán'
FROM dbo.CTHD A INNER JOIN dbo.VATTU B ON A.MAVT = B.MAVT
WHERE (A.GIABAN * A.SL) > (B.GIAMUA*A.SL)
GO
--17.	Tìm ra những mặt hàng chưa bán được.
CREATE VIEW V17 AS
SELECT *
FROM VATTU 
WHERE MAVT  NOT IN(SELECT B.MAVT FROM HOADON A, CTHD B WHERE A.MAHD=B.MAHD)
GO
--16.	Lấy ra các thông tin gồm mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, 
--trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng)  và cột khuyến mãi với khuyến mãi 10% cho những mặt hàng bán trong một hóa đơn lớn hơn 100.
CREATE VIEW V16 AS
SELECT B.MAHD,A.MAVT,A.TENVT,A.DVT,B.GIABAN,A.GIAMUA,B.SL,(A.GIAMUA*B.SL) AS TRIGIAMUA,(B.GIABAN*B.SL) AS TRIGIABAN,
CASE WHEN B.SL > 100 THEN 0.1*(B.SL*B.GIABAN) ELSE 0 END AS KHUYENMAI
FROM VATTU A,CTHD B
WHERE A.MAVT=B.MAVT
GO
--18.	Tạo bảng tổng hợp gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, 
--đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
CREATE VIEW V18 AS
SELECT B.MAHD,B.NGAY,A.TENKH,A.DIACHI,A.DT,D.TENVT,D.DVT,D.GIAMUA,C.GIABAN,
		C.SL,(D.GIAMUA*C.SL) AS N'Trị giá mua',(C.GIABAN * C.SL) AS N'Trị giá bán'
FROM KHACHHANG A,HOADON B,CTHD C,VATTU D
WHERE A.MAKH=B.MAKH AND B.MAHD=C.MAHD AND C.MAVT = D.MAVT
GROUP BY B.MAHD,B.NGAY,A.TENKH,A.DIACHI,A.DT,D.TENVT,D.DVT,D.GIAMUA,C.GIABAN,C.SL
GO
--19.	Tạo bảng tổng hợp tháng 5/2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, 
--tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán
CREATE VIEW V19 AS
SELECT B.MAHD,B.NGAY,A.TENKH,A.DIACHI,A.DT,D.TENVT,D.DVT,D.GIAMUA,C.GIABAN,
		C.SL,(D.GIAMUA*C.SL) AS N'Trị giá mua',(C.GIABAN * C.SL) AS N'Trị giá bán'
FROM KHACHHANG A,HOADON B,CTHD C,VATTU D
WHERE A.MAKH=B.MAKH AND B.MAHD=C.MAHD AND C.MAVT = D.MAVT AND (MONTH(B.NGAY) = 5 AND YEAR(B.NGAY) = 2010)
GROUP BY B.MAHD,B.NGAY,A.TENKH,A.DIACHI,A.DT,D.TENVT,D.DVT,D.GIAMUA,C.GIABAN,C.SL
GO
--20.	Tạo bảng tổng hợp quý 1 – 2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, 
--tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
CREATE VIEW V20 AS
SELECT B.MAHD,B.NGAY,A.TENKH,A.DIACHI,A.DT,D.TENVT,D.DVT,D.GIAMUA,C.GIABAN,
		C.SL,(D.GIAMUA*C.SL) AS N'Trị giá mua',(C.GIABAN * C.SL) AS N'Trị giá bán'
FROM KHACHHANG A,HOADON B,CTHD C,VATTU D
WHERE A.MAKH=B.MAKH AND B.MAHD=C.MAHD AND C.MAVT = D.MAVT AND 
		(MONTH(B.NGAY) IN(1,2,3) AND YEAR(B.NGAY) = 2010)
GROUP BY B.MAHD,B.NGAY,A.TENKH,A.DIACHI,A.DT,D.TENVT,D.DVT,D.GIAMUA,C.GIABAN,C.SL
GO
--21.	Lấy ra danh sách các hóa đơn gồm các thông tin: Số hóa đơn, ngày,
--tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
CREATE VIEW V21 AS
SELECT B.MAHD,B.NGAY,A.TENKH,A.DIACHI,sum(C.SL * C.GIABAN) as N'Tổng trị giá'
FROM KHACHHANG A,HOADON B,CTHD C
WHERE A.MAKH = B.MAKH AND B.MAHD = C.MAHD
GROUP BY B.MAHD,B.NGAY,A.TENKH,A.DIACHI
GO
--22.	Lấy ra hóa đơn có tổng trị giá lớn nhất gồm các thông tin: Số hóa đơn, 
--ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
CREATE VIEW V22 AS
SELECT top 1 with ties B.MAHD,B.NGAY,A.TENKH,A.DIACHI,sum(C.SL * C.GIABAN) as N'Tổng trị giá'
FROM KHACHHANG A,HOADON B,CTHD C
WHERE A.MAKH = B.MAKH AND B.MAHD = C.MAHD
GROUP BY B.MAHD,B.NGAY,A.TENKH,A.DIACHI
ORDER BY sum(C.SL * C.GIABAN) desc
GO
--23.	Lấy ra hóa đơn có tổng trị giá lớn nhất trong tháng 5/2010 gồm các thông tin: 
--Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
CREATE VIEW V23 AS
	SELECT top 1 with ties B.MAHD,B.NGAY,A.TENKH,A.DIACHI,sum(C.SL * C.GIABAN) as N'Tổng trị giá'
	FROM KHACHHANG A,HOADON B,CTHD C
	WHERE A.MAKH = B.MAKH AND B.MAHD = C.MAHD AND MONTH(B.NGAY) = 5 AND YEAR(B.NGAY) = 2010
	GROUP BY B.MAHD,B.NGAY,A.TENKH,A.DIACHI
	ORDER BY sum(C.SL * C.GIABAN) desc
GO
--24.	Đếm xem mỗi khách hàng có bao nhiêu hóa đơn
CREATE VIEW V24 AS
	SELECT B.TENKH,count(A.MAKH) as N'Số hợp đồng'
	FROM HOADON A,KHACHHANG B
	WHERE A.MAKH = B.MAKH
	GROUP BY B.TENKH,A.MAKH
GO
--25.	Đếm xem mỗi khách hàng, mỗi tháng có bao nhiêu hóa đơn.
CREATE VIEW V25 AS
	SELECT COUNT(MAHD) AS SOLUONG,TENKH,MONTH(NGAY) AS THANG
	FROM HOADON A,KHACHHANG B
	WHERE A.MAKH=B.MAKH
	GROUP BY TENKH,MONTH(NGAY)
GO
--26.	Lấy ra các thông tin của khách hàng có số lượng hóa đơn mua hàng nhiều nhất.
CREATE VIEW V26 AS
SELECT top 1 with ties B.MAKH,B.TENKH,B.DT,B.DIACHI,B.EMAIL,count(A.MAKH) as N'Số hợp đồng'
FROM HOADON A,KHACHHANG B
WHERE A.MAKH = B.MAKH
GROUP BY B.TENKH, B.TENKH , B.DT,B.DIACHI,B.EMAIL,B.MAKH
ORDER BY count(A.MAKH) desc
GO
--27.	Lấy ra các thông tin của khách hàng có số lượng hàng mua nhiều nhất.
CREATE VIEW V27 AS
SELECT top 1 A.MAKH,A.TENKH,A.DT,A.DIACHI,A.EMAIL,sum(C.SL) [Số lượng hàng mua]
FROM KHACHHANG A , HOADON B , CTHD C
WHERE A.MAKH = B.MAKH AND B.MAHD = C.MAHD
GROUP BY A.MAKH,A.TENKH,A.DT,A.DIACHI,A.EMAIL
ORDER BY count(C.SL) desc
GO
--28.	Lấy ra các thông tin về các mặt hàng mà được bán trong nhiều hóa đơn nhất.
SELECT top 1 with ties A.TENVT,count(B.MAVT) [Số lượng mặt hàng]
FROM VATTU A,CTHD B,HOADON C
WHERE A.MAVT = B.MAVT AND B.MAHD = C.MAHD
GROUP BY A.TENVT
ORDER BY count(C.MAHD) desc
GO
--29.	Lấy ra các thông tin về các mặt hàng mà được bán nhiều nhất.
CREATE VIEW V29 AS
SELECT top 1 with ties A.TENVT,count(B.MAVT) [Số lượng mặt hàng]
FROM VATTU A,CTHD B
WHERE A.MAVT = B.MAVT
GROUP BY A.TENVT
ORDER BY count(B.MAVT) desc
GO
--30.	Lấy ra danh sách tất cả các khách hàng gồm Mã khách hàng, tên khách hàng, địa chỉ, 
--số lượng hóa đơn đã mua (nếu khách hàng đó chưa mua hàng thì cột số lượng hóa đơn để trống)
SELECT A.MAKH,C.TENKH,C.DIACHI,count(B.MAHD) [Số lượng hóa đơn]
FROM HOADON A ,CTHD B,KHACHHANG C
WHERE A.MAHD = B.MAHD AND A.MAKH = C.MAKH
GROUP BY A.MAKH,C.TENKH,C.DIACHI
GO
--PROCEDURE
--1.	Lấy ra danh các khách hàng đã mua hàng trong ngày X, với X là tham số truyền vào.
CREATE PROCEDURE P1 (@ngay DATE) 
AS BEGIN
	SELECT B.TENKH,A.MAHD,A.NGAY
	FROM HOADON A ,KHACHHANG B
	WHERE A.MAKH = B.MAKH AND A.NGAY = @ngay
END
GO
--2.	Lấy ra danh sách khách hàng có tổng trị giá các đơn hàng lớn hơn X (X là tham số).
CREATE PROCEDURE P2 (@trigia int)
AS BEGIN
	SELECT A.MAKH,A.TENKH,sum(C.SL * C.GIABAN) [Tổng trị giá]
	FROM KHACHHANG A,HOADON B,CTHD C
	WHERE A.MAKH = B.MAKH AND B.MAHD = C.MAHD
	GROUP BY A.MAKH,A.TENKH
	HAVING sum(C.SL * C.GIABAN) > @trigia
END
GO
--3.	Lấy ra danh sách X khách hàng có tổng trị giá các đơn hàng lớn nhất (X là tham số).
CREATE PROC P3(@KH INT) AS
BEGIN
SELECT TOP (@KH) WITH TIES A.MAKH,A.TENKH,SUM(C.SL*C.GIABAN)[TổngGiáTrị]
FROM dbo.KHACHHANG A,dbo.HOADON B , dbo.CTHD C
WHERE A.MAKH = B.MAKH AND B.MAHD = C.MAHD
GROUP BY A.MAKH,A.TENKH
ORDER BY SUM(C.SL*C.GIABAN) DESC
END
GO
--4.	Lấy ra danh sách X mặt hàng có số lượng bán lớn nhất (X là tham số).
CREATE PROC P4 (@DS INT)
as
	select top (@DS) WITH TIES b.MAVT, b.TENVT, b.DVT, b.GIAMUA, b.SLTON
	from CTHD a, VATTU b
	where a.MAVT = b.MAVT AND b.SLTON = b.SLTON - a.SL
	group by b.MAVT, b.TENVT, b.DVT, b.GIAMUA, b.SLTON
	order by SL desc
GO
--5.	Lấy ra danh sách X mặt hàng bán ra có lãi ít nhất (X là tham số).
CREATE PROC P5
as
	select top 1 a.MAVT, a.TENVT, a.DVT, a.GIAMUA, a.SLTON from VATTU a, CTHD b
	where  a.MAVT = b.MAVT
	group by a.MAVT, a.TENVT, a.DVT, a.GIAMUA, a.SLTON
	order by sum((GIABAN - GIAMUA)*SL) asc
GO
--6.	Lấy ra danh sách X đơn hàng có tổng trị giá lớn nhất (X là tham số).
CREATE PROC P6 (@DS INT) AS
SELECT TOP (@DS) WITH ties MAHD,MAVT,SL,GIABAN,(SL*GIABAN)[Trị giá]
FROM dbo.CTHD
ORDER BY (SL*GIABAN) DESC
GO
--7.	Tính giá trị cho cột khuyến mãi như sau: Khuyến mãi 5% nếu SL > 100, 10% nếu SL > 500.
CREATE PROCEDURE P7
AS BEGIN
	SELECT MAHD,MAVT,SL,GIABAN,(CASE WHEN SL > 100 THEN 0.05*(SL*GIABAN)
			WHEN SL > 500 THEN 0.1*(SL*GIABAN) ELSE 0 END) AS KHUYENMAI
	FROM CTHD
END
GO
--8.	Tính lại số lượng tồn cho tất cả các mặt hàng (SLTON = SLTON – tổng SL bán được).
CREATE PROCEDURE P8
AS BEGIN
	SELECT A.TENVT,(A.SLTON - B.SL) [Số lượng tồn]
	FROM VATTU A,CTHD B
	WHERE A.MAVT = B.MAVT
END
GO
--9.	Tính trị giá cho mỗi hóa đơn.
CREATE PROC P9 
AS BEGIN
	SELECT A.MAHD,sum(B.SL*B.GIABAN) [Trị giá]
	FROM HOADON A,CTHD B
	WHERE A.MAHD = B.MAHD
	GROUP BY A.MAHD
END
GO
--10.	Tạo ra table KH_VIP có cấu trúc giống với cấu trúc table KHACHHANG. 
--Lưu các khách hàng có tổng trị giá của tất cả các đơn hàng >=10,000,000 vào table KH_VIP.
CREATE PROCEDURE KH_VIP
AS BEGIN
	SELECT A.MAKH,A.TENKH,A.DT,A.DIACHI,A.EMAIL,sum(C.SL*C.GIABAN) [Tổng trị giá]
	FROM KHACHHANG A,HOADON B,CTHD C
	WHERE A.MAKH = B.MAKH AND B.MAHD = C.MAHD
	GROUP BY A.MAKH,A.TENKH,A.DT,A.DIACHI,A.EMAIL
	HAVING sum(C.SL * C.GIABAN) >= 10000000
END
GO
CREATE PROC P10 (@TG BIGINT)
AS BEGIN
	SELECT A.MAKH,A.TENKH,A.DT,A.DIACHI,A.EMAIL,sum(C.SL*C.GIABAN) [Tổng trị giá]
	FROM KHACHHANG A,HOADON B,CTHD C
	WHERE A.MAKH = B.MAKH AND B.MAHD = C.MAHD
	GROUP BY A.MAKH,A.TENKH,A.DT,A.DIACHI,A.EMAIL
	HAVING sum(C.SL * C.GIABAN) >= @TG
END
--FUNCTION
--1.Viết hàm tính doanh thu của năm, với năm là tham số truyền vào.
CREATE FUNCTION F1 (@nam CHAR(4))
RETURNS BIGINT AS
BEGIN
	DECLARE @tong BIGINT;
	SELECT @tong = SUM(B.SL*B.GIABAN)
	FROM dbo.HOADON A,dbo.CTHD B
	WHERE A.MAHD=B.MAHD AND YEAR(A.NGAY) = @nam
	RETURN @tong
END
GO
PRINT N'Tổng Doanh Thu Nam 2010: '+ STR(dbo.F1('2010'))
GO
--2.Viết hàm tính doanh thu của tháng, năm, với tháng và năm là 2 tham số truyền vào.
CREATE FUNCTION F2 (@thang CHAR(2),@nam CHAR(4))
RETURNs BIGINT AS
BEGIN
	DECLARE @tong BIGINT;
	SELECT @tong = SUM(B.SL*B.GIABAN)
	FROM dbo.HOADON A,dbo.CTHD B
	WHERE A.MAHD = B.MAHD AND (MONTH(A.NGAY) = @thang AND YEAR(A.NGAY) = @nam)
	RETURN @tong
END
GO
PRINT N'Tổng Doanh Thu 06/2010: ' + STR(dbo.F2('06','2010'))
GO
--3.Viết hàm tính doanh thu của khách hàng với mã khách hàng là tham số truyền vào.
CREATE FUNCTION F3 (@MA_KH VARCHAR(5))
RETURNS BIGINT AS
BEGIN
	DECLARE @tong BIGINT;
	SELECT @tong = (C.SL*C.GIABAN)
	FROM dbo.KHACHHANG A,dbo.HOADON B,dbo.CTHD C
	WHERE A.MAKH=B.MAKH AND B.MAHD=C.MAHD AND A.MAKH = @MA_KH;
	RETURN @tong;
END
GO
PRINT N'Doanh Thu Của Khách Hàng Mã KH01: ' + STR(dbo.F3('KH01'))
GO
--4.	Viết hàm tính tổng số lượng bán được cho từng mặt hàng theo tháng, năm nào đó. Với mã hàng, 
--tháng và năm là các tham số truyền vào, nếu tháng không nhập vào tức là tính tất cả các tháng.
CREATE FUNCTION F4 (@MAH VARCHAR(5), @M INT, @Y INT)
RETURNS DECIMAL(28,6)
AS
BEGIN
		DECLARE @DT DECIMAL(28,6)
		SELECT @DT = SUM(SL)
		FROM HOADON A INNER JOIN CTHD B ON A.MAHD = B.MAHD 
		WHERE MAVT = @MAH AND YEAR(A.NGAY)=@Y AND (MONTH(A.NGAY) = @M OR (@M =''))
		RETURN @DT
END
GO 
PRINT N'Tổng Số Lượng bán được 2010 Mã Hàng VT01:' + STR(dbo.F4('VT01','',2010))
PRINT N'Tổng Số Lượng Vật Tư Mã Hàng Theo Năm Tháng: ' + STR(dbo.F4('VT01',6,2010))
GO
--5.	Viết hàm tính lãi (giá bán – giá mua) * số lượng bán được cho từng mặt hàng, với mã mặt hàng là tham số truyền vào. 
--Nếu mã mặt hàng không truyền vào thì tính cho tất cả các mặt hàng
CREATE FUNCTION F5 (@MH VARCHAR(5))
RETURNS DECIMAL(28,6) AS
BEGIN
	DECLARE @Tong DECIMAL(28,6)
	SELECT @Tong = ((B.GIABAN - A.GIAMUA) * B.SL)
	FROM dbo.VATTU A,dbo.CTHD B
	WHERE A.MAVT = B.MAVT AND A.MAVT = @MH OR (@MH ='' AND A.MAVT LIKE '%')
	RETURN @Tong
END
GO
PRINT N'Lãi mặt hàng VT01:'+STR(dbo.F5('VT01'))
PRINT N'Lãi mặt hàng tất cả mặt hàng:'+STR(dbo.F5(''))
GO
--TRIGGER
--1.	Thực hiện việc kiểm tra các ràng buộc khóa ngoại.
--2.	Không cho phép CASCADE DELETE trong các ràng buộc khóa ngoại.
--Ví dụ không cho phép xóa các HOADON nào có SOHD còn trong table CTHD.
CREATE TRIGGER T2 ON dbo.CTHD 
FOR DELETE AS
BEGIN
	DECLARE @mahd NVARCHAR(10)
	SELECT @mahd = MAHD FROM Deleted
	IF EXISTS(SELECT * FROM dbo.HOADON WHERE EXISTS(SELECT * FROM dbo.CTHD WHERE dbo.HOADON.MAHD=dbo.CTHD.MAHD
	AND dbo.HOADON.MAHD = @mahd))
		BEGIN
			PRINT N'Số Hóa Đơn Còn Tồn Tại'
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			PRINT N'Thành Công'
		END
END
GO
--3.	Không cho phép user nhập vào hai vật tư có cùng tên.
CREATE TRIGGER T3 ON dbo.VATTU 
INSTEAD OF INSERT AS
BEGIN
	IF EXISTS(SELECT * FROM dbo.VATTU WHERE EXISTS(SELECT * from inserted WHERE inserted.TENVT=dbo.VATTU.TENVT))
		BEGIN
			PRINT N'Khong duoc them!!!'
			SELECT * from VATTU
			ROLLBACK TRAN
		END
	ELSE 
		BEGIN
			PRINT N'Da them thanh cong!!!'
			SELECT * from VATTU
			INSERT INTO VATTU(MAVT,TENVT,DVT,GIAMUA,SLTON)
				SELECT MAVT,TENVT,DVT,GIAMUA,SLTON from inserted
			SELECT * from VATTU
		END
END
GO
--4.	Khi user đặt hàng thì KHUYENMAI là 5% nếu SL > 100, 10% nếu SL > 500.
CREATE TRIGGER T4 ON dbo.CTHD 
FOR INSERT, UPDATE AS
BEGIN
	DECLARE @SoLuong int
	DECLARE @MaHD VARCHAR(10)
	DECLARE @MAVaTu VARCHAR(5)
	select @SoLuong = SL, @MaHD = MAHD, @MAVaTu = MAVT from inserted
	if @SoLuong >= 500
		begin 
			UPDATE CTHD SET KHUYENMAI = 0.1*SL*GIABAN WHERE MAHD = @MaHD and MAVT = @MAVaTu
		end
	ELSE 
		IF(@SoLuong > 100)
			begin 
				UPDATE CTHD SET KHUYENMAI = 0.05*SL*GIABAN WHERE MAHD = @MaHD and MAVT = @MAVaTu
			END
		ELSE
			BEGIN
				UPDATE CTHD SET KHUYENMAI = 0 WHERE MAHD = @MaHD and MAVT = @MAVaTu
			END
END
GO
--5.Chỉ cho phép mua các mặt hàng có số lượng tồn lớn hơn hoặc bằng số lượng cần mua và tính lại số lượng tồn mỗi khi có đơn hàng
CREATE TRIGGER T5 ON dbo.CTHD 
FOR INSERT AS
BEGIN
	DECLARE @sltonkho INT 
	DECLARE @slmua INT
	DECLARE @mavt VARCHAR(5)
	SELECT @slmua = SL,@mavt = MAVT FROM Inserted
	SELECT @sltonkho = SUM(SLTON) FROM dbo.VATTU WHERE MAVT = @mavt
	IF(@slmua > @sltonkho)
		BEGIN
			PRINT N'Số lượng tồn trong kho không đủ'
			ROLLBACK TRAN
		END
	ELSE
		BEGIN 
			UPDATE dbo.VATTU 
			SET SLTON = SLTON - @slmua
			WHERE MAVT = @mavt
			PRINT N'Cập Nhập Thành Công'
		END
END
GO
--6.	Không cho phép user xóa một lúc nhiều hơn một vật tư.
CREATE TRIGGER T6 ON dbo.VATTU 
FOR DELETE AS
BEGIN
	DECLARE @dong int
	SET @dong = (SELECT COUNT(*) FROM Deleted)

	IF(@dong > 1)
		BEGIN
		 PRINT N'Không được xóa hơn 1 vật tư'
		 ROLLBACK TRAN
		END
	ELSE
		BEGIN
		 PRINT N'Thành Công'
		END
END
GO
--7. mỗi hóa đơn chỉ cho phép đặt tối đa 5 mặt hàng 
CREATE TRIGGER T7 ON dbo.CTHD 
FOR INSERT, UPDATE AS
BEGIN
	DECLARE @demmh int
	DECLARE @MaHD VARCHAR(10)
	select @MaHD = MAHD from inserted
	select @demmh = COUNT(MAVT) from CTHD WHERE CTHD.MAHD = @MaHD
	if @demmh > 5
		begin 
			print N'Đặt nhiều hơn 5 cái rồi'
			ROLLBACK TRAN
		end
	else
		begin 
			print N'Thành Công'
		end
END
GO
INSERT INTO CTHD VALUES('HD01','VT02',5,NULL,10000)
INSERT INTO CTHD VALUES('HD01','VT04',5,NULL,10000)
INSERT INTO CTHD VALUES('HD01','VT03',5,NULL,10000)
INSERT INTO CTHD VALUES('HD01','VT06',5,NULL,10000)
GO
--8.	Mỗi hóa đơn có tổng trị giá tối đa 50000000
CREATE TRIGGER T8 ON dbo.CTHD
FOR INSERT AS
BEGIN
	DECLARE @tong BIGINT
	DECLARE @mh VARCHAR(4)
	SELECT @mh = MAHD FROM Inserted
    SET @tong = (SELECT (SL*GIABAN)-KHUYENMAI FROM dbo.CTHD WHERE MAHD = @mh)
	IF(@tong > 50000000)
		BEGIN
			ROLLBACK TRAN
			PRINT N'Tổng trị giá đã vượt hơn 50 Triệu'
		END
	ELSE
		BEGIN
			PRINT N'Thành Công'
		END
END
GO
--9.	Không được phép bán hàng lỗ quá 50%.
CREATE TRIGGER T9 ON dbo.CTHD 
FOR INSERT AS 
BEGIN 
	DECLARE @giaban INT
	DECLARE @dinhmuc INT
	DECLARE @mavt CHAR(4)
	SELECT @mavt = MAVT,@giaban = GIABAN FROM Inserted
	SELECT @dinhmuc = GIAMUA*0.5 FROM dbo.VATTU WHERE MAVT = @mavt
	IF(@giaban <= @dinhmuc)
		BEGIN
			PRINT N'Rất Tiếc Chúng Tôi Không Bán Lỗ'
			ROLLBACK TRAN
		END
	ELSE
		BEGIN
			PRINT N'Giá Bán Tạm Ổn'
		END
END
GO
--10.	Chỉ bán mặt hàng Gạch (các loại gạch) với số lượng là bội số của 100
CREATE TRIGGER T10 ON dbo.CTHD FOR INSERT,UPDATE AS
BEGIN
	DECLARE @sl INT
	DECLARE @tenvt NVARCHAR(10)
	DECLARE @mvt VARCHAR(4)
	SELECT @sl = SL FROM Inserted
	SELECT @tenvt = TENVT FROM dbo.VATTU WHERE MAVT = @mvt
	IF (@tenvt = N'Gạch%' AND @sl % 100 = 0)
		BEGIN
		PRINT N'Thành Công'
		ROLLBACK TRAN
		END
	ELSE
		BEGIN
		PRINT N'Không Thành Công'
		END
END