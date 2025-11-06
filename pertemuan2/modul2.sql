-- Buat database TokoRetailDB
CREATE DATABASE TokoRetailDB;

-- Gunakan DB Toko Retail
USE TokoRetailDB;

-- Buat tabel kategori produk
	CREATE TABLE KategoriProduk(
		KategoriID INT IDENTITY(1,1) PRIMARY KEY,
		NamaKategori VARCHAR(100) NOT NULL UNIQUE
		);

-- Buat tabel produk
	CREATE TABLE Produk(
		ProdukID  INT IDENTITY(1001,1) PRIMARY KEY,
		SKU VARCHAR(20) NOT NULL UNIQUE,
		NamaProduk VARCHAR(150) NOT NULL,
		Harga DECIMAL(10,2) NOT NULL,
		Stok INT NOT NULL,
		KategoriID INT NULL,

		-- Harganya gaboleh minus
		CONSTRAINT CHK_HargaPositif CHECK (Harga >= 0),
		-- Stok nya gaboleh minus
		CONSTRAINT CHK_StokPositif CHECK (Stok >= 0),
		-- Relasikan dengan tabel KategoriProduk
		CONSTRAINT FK_Produk_Kategori
			FOREIGN KEY (KategoriID)
			REFERENCES KategoriProduk(KategoriID)
		);

-- Masukkan dta ke tabel KategoriProduk
	INSERT INTO KategoriProduk (NamaKategori)
	VALUES ('Elekronik');

	INSERT INTO KategoriProduk (NamaKategori)
	VALUES ('Pakaian'), ('Buku');
	
-- Menampilkan tabel KategoriProduk
	SELECT * FROM KategoriProduk;

-- Menampilkan kolom NamaKategori dalam tabel KategoriProduk
	SELECT NamaKategori FROM KategoriProduk;

-- Menambahkan data ke tabel Produk
	INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
	VALUES
	('ELEC-001', 'Laptop Biasa Aja', 15000000.00,50,2);

	INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
	VALUES
	('ELEC-002', 'HP Biasa Aja', 50000000.00,50,1);

-- Menampilkan tabel Produk
	SELECT * FROM Produk;

-- Mengubah stok laptop biasa aja menjadi 30
	UPDATE Produk SET Stok = 30
	WHERE ProdukID = 1001;

-- Menghapus data hp biasa aja
	BEGIN TRANSACTION;
	DELETE FROM Produk
	WHERE ProdukID = 1003;

-- Simpan Transaksi di database
	COMMIT TRANSACTION;

-- Menambahkan Produk lagi
	INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
	VALUES
	('BAJU-001', 'Baju aja', 50000.00,30,2);

	INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
	VALUES
	('BAJU-002', 'Baju lumayan', 70000.00,30,2);

-- Menghapus data Baju aja
	BEGIN TRANSACTION;
	DELETE FROM Produk
	WHERE ProdukID = 1004;

-- Rollback data Baju aja
	ROLLBACK TRANSACTION;
	COMMIT TRANSACTION;