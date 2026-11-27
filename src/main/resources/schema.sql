DROP TABLE IF EXISTS Votes;
DROP TABLE IF EXISTS Replies;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Bookmarks;
DROP TABLE IF EXISTS RecipeCategories;
DROP TABLE IF EXISTS Recipes;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Users;
DROP TYPE IF EXISTS vote;
DROP TYPE IF EXISTS role;

CREATE TYPE role AS ENUM ('admin', 'user');
CREATE TYPE vote AS ENUM ('upvote', 'downvote');

CREATE TABLE Users (
	ID SERIAL PRIMARY KEY,
	Username varchar(20) NOT NULL UNIQUE,
	Email varchar(30) NOT NULL UNIQUE,
	Fullname varchar(40) NOT NULL,
	Password varchar(20) NOT NULL,
	Role role NOT NULL
);

CREATE TABLE Categories (
	ID SERIAL PRIMARY KEY,
	Name varchar(20) UNIQUE
);

CREATE TABLE Recipes (
	ID SERIAL PRIMARY KEY,
	Title VARCHAR(100) NOT NULL,
	ImagePath VARCHAR(100) NOT NULL,
	Description VARCHAR(700) NOT NULL,
	Ingredients VARCHAR(500) NOT NULL,
	Instructions VARCHAR(1000) NOT NULL,
	Duration INTERVAL NOT NULL,
	UserID INT REFERENCES Users (ID) NOT NULL,
	CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE RecipeCategories (
	RecipeID INT REFERENCES Recipes (ID) NOT NULL,
	CategoryID INT  REFERENCES Categories (ID) NOT NULL
);

CREATE TABLE Bookmarks (
	UserID INT REFERENCES Users (ID) NOT NULL,
      RecipeID INT REFERENCES Recipes (ID) NOT NULL
);

CREATE TABLE Reviews (
      UserID INT REFERENCES Users (ID) NOT NULL,
      RecipeID INT REFERENCES Recipes (ID) NOT NULL,
      Comment varchar(250) NOT NULL
);

CREATE TABLE Replies (
     UserID INT REFERENCES Users (ID) NOT NULL,
     RecipeID INT REFERENCES Recipes (ID) NOT NULL,
     Comment varchar(250) NOT NULL
);

CREATE TABLE Votes (
     UserID INT REFERENCES Users (ID) NOT NULL,
     RecipeID INT REFERENCES Recipes (ID) NOT NULL,
     Vote vote NOT NULL
);




--dummy data users
INSERT INTO Users (Username, Email, Fullname, Password, Role)
VALUES ('admin', 'admin@gmail.com', 'Admin01', 'Password123', 'admin'),
('Kendrick', 'hansellkendrick@gmail.com', 'Kendrick Hansell', 'Password123', 'user'),
('Andra', 'Andra@gmail.com', 'Andra Sang Chef', 'Password123', 'user'),
('Ivan', 'Ivan@gmail.com', 'Ivan Sang Chef', 'Password123', 'user')
;

--dummy data categories
INSERT INTO Categories (Name)
VALUES 
    ('Makanan Utama'),
    ('Camilan'),
    ('Masakan Nusantara'),
    ('Sayuran'),
    ('Makanan Penutup'),
    ('Sarapan'),
	('Indonesian');

--dummy data recipes
INSERT INTO Recipes (Title, ImagePath, Description, Ingredients, Instructions,Duration,UserID)
VALUES 
    (
        'Nasi Goreng Kampung Spesial',
        '{PATH}',
        'Nasi goreng khas rumahan dengan bumbu ulek terasi dan telur mata sapi.',
        '2 piring nasi putih, 3 siung bawang merah, 2 siung bawang putih, 5 cabai rawit, 1 sdt terasi, kecap manis, garam',
        '1. Haluskan bumbu. 2. Tumis bumbu hingga harum. 3. Masukkan nasi dan kecap manis, aduk rata hingga matang.',
        '30 Minutes',
		2
    ),
    (
        'Ayam Bakar Madu',
        '{PATH}',
        'Ayam ungkep empuk dengan olesan madu dan mentega yang gurih manis.',
        '1 ekor ayam potong 4, 3 sdm madu, 2 sdm mentega, 4 siung bawang putih, ketumbar, lengkuas, daun salam',
        '1. Ungkep ayam bersama bumbu halus hingga air menyusut. 2. Olesi campuran madu dan mentega. 3. Bakar hingga kecokelatan.',
        '1 Hour 10 Minutes',
		2
    ),
	(
        'Tumis Kangkung Terasi',
        '{PATH}',
        'Tumisan kangkung renyah dengan aroma terasi dan bawang putih yang menggugah selera.',
        '2 ikat kangkung segar, 4 siung bawang merah, 3 siung bawang putih, 5 cabai rawit merah, 1 sdt terasi bakar, 1 sdm saus tiram, garam, gula, sedikit air',
        '1. Tumis irisan bawang dan cabai hingga harum, masukkan terasi. 2. Besarkan api, masukkan kangkung dan bumbu penyedap. 3. Aduk cepat sekitar 2 menit agar kangkung tetap hijau dan renyah.',
		'25 Minutes',
	    3
    ),
	(
        'Pisang Goreng Crispy',
        '{PATH}',
        'Camilan pisang kepok manis yang dibalut tepung renyah di luar dan lembut di dalam.',
        '1 sisir pisang kepok matang, 150 gr tepung terigu, 50 gr tepung beras, 2 sdm gula pasir, 1/4 sdt garam, vanili bubuk, air es secukupnya, minyak goreng',
        '1. Campur tepung terigu, tepung beras, gula, garam, vanili, dan air es hingga adonan mengental. 2. Kupas pisang dan belah membentuk kipas, celupkan ke adonan. 3. Goreng dalam minyak panas hingga kuning keemasan.',
		'50 Minutes',
	    4
    ),(
        'Puding Cokelat Vla Vanila',
        '{PATH}',
        'Makanan penutup puding cokelat lembut yang disajikan dingin dengan siraman vla vanila manis.',
        '1 bungkus agar-agar cokelat, 700 ml susu cair cokelat, 100 gr gula pasir, 50 gr dark cooking chocolate, 1 sdm maizena, 250 ml susu cair putih, 1/2 sdt pasta vanila',
        '1. Masak agar-agar, susu cokelat, gula, dan dark chocolate hingga mendidih lalu tuang ke cetakan. 2. Masak susu putih, gula, maizena, dan vanila hingga mengental untuk vla. 3. Sajikan puding dingin dengan vla di atasnya.',
		'1 Hour 30 Minutes',
	    3
    ),
    (
        'Bubur Ayam Komplit',
        '{PATH}',
        'Menu sarapan bubur nasi gurih dengan suwiran ayam, cakwe, kacang kedelai goreng, dan kuah kaldu kuning.',
        '200 gr beras, 1.5 liter air kaldu ayam, 250 gr dada ayam suwir, 1 batang cakwe iris, kacang kedelai goreng, bawang goreng, seledri, kecap manis, kerupuk',
        '1. Masak beras bersama air kaldu dan daun salam sambil terus diaduk hingga menjadi bubur lembut. 2. Tata bubur di mangkuk, beri suwiran ayam, cakwe, kedelai, dan daun seledri. 3. Siram sedikit kuah kaldu dan kecap manis.',
        '2 Hour',
		4
    ),
    (
        'Roti Bakar Keju Cokelat',
        '{PATH}',
        'Sarapan praktis roti tawar panggang mentega dengan isian keju parut dan meses cokelat lumer.',
        '4 lembar roti tawar tebal, 2 sdm mentega, 50 gr keju cheddar parut, 3 sdm meses cokelat, 2 sdm susu kental manis',
        '1. Olesi kedua sisi roti tawar dengan mentega. 2. Isi bagian tengah roti dengan keju parut, meses, dan susu kental manis lalu tutup dengan roti lainnya. 3. Panggang di atas teflon hingga kedua sisi kecokelatan dan renyah.',
        '40 Minutes',
		2
    );

--dummy data recipecategory
INSERT INTO RecipeCategories (RecipeID, CategoryID)
VALUES
-- 1. nasi goreng kampung spesial (Makanan utama ,Masakan Nusantara ,Sarapan, Indonesian)
	(1, 1),
    (1, 3),
    (1, 6),
	(1,7),

-- 2. Ayam Bakar Madu (Makanan Utama, Masakan Nusantara, Indonesian)
    (2, 1),
    (2, 3),
	(2,7),

    -- 3. Tumis Kangkung Terasi (Makanan Utama, Masakan Nusantara, Sayuran, Indonesian)
    (3, 1),
    (3, 3),
    (3, 4),
	(3,7),

    -- 4. Pisang Goreng Crispy (Camilan, Masakan Nusantara, Indonesian)
    (4, 2),
    (4, 3),
	(4,7),

    -- 5. Puding Cokelat Vla Vanila (Camilan, Makanan Penutup, Indonesian)
    (5, 2),
    (5, 5),
	(5,7),
    -- 6. Bubur Ayam Komplit (Makanan Utama, Masakan Nusantara, Sarapan, Indonesian)
    (6, 1),
    (6, 3),
    (6, 6),
	(6,7),

    -- 7. Roti Bakar Keju Cokelat (Camilan, Sarapan, Indonesian)
    (7, 2),
    (7, 6),
	(7,7);


INSERT INTO Bookmarks (UserID, RecipeID)
VALUES
-- User 2 menyimpan Tumis Kangkung, Pisang Goreng, dan Bubur Ayam
    (2, 3),
    (2, 4),
    (2, 6),

    -- User 3 menyimpan Nasi Goreng, Pisang Goreng, dan Roti Bakar
    (3, 1),
    (3, 4),
    (3, 7),

    -- User 4 menyimpan Ayam Bakar dan Puding Cokelat
    (4, 2),
    (4, 5);

INSERT INTO Reviews (UserID, RecipeID, Comment)
VALUES 
	--nasgor
    (4, 1, 'Resepnya gampang banget diikuti! Takaran terasinya pas, rasanya persis kayak nasi goreng abang-abang.'), 
	--nasgor
	(3, 1, 'Sudah coba recook buat sarapan pagi ini, keluarga di rumah suka semua. Terima kasih resepnya!'),
    --ayam madu
	(3, 2, 'Bumbu ungkepnya meresap sampai ke tulang. Olesan madu dan menteganya bikin aroma bakaran makin sedap.'),
    --tumis kangkung
	(4, 3, 'Tips masak kangkung pakai api besar selama 2 menit berhasil banget, kangkungnya tetap hijau dan renyah.'),
    --pisang goreng
	(2, 4, 'Adonan tepungnya renyah tahan lama, nggak gampang melempem meskipun pisangnya sudah dingin.'),
    --pudding cokelat
	(3, 5, 'Puding cokelatnya lembut banget, perpaduan manis pahit dark chocolate sama vla vanilanya juara!'),
	--bubur
    (2, 6, 'Kuah kaldu kuningnya gurih dan wangi rempah. Cocok banget buat menu sarapan akhir pekan.');


INSERT INTO Replies (UserID, RecipeID, Comment)
VALUES 
    -- User 2 (pembuat resep 1) membalas ulasan di Nasi Goreng Kampung Spesial
    (2, 1, 'Terima kasih sudah mencoba resepnya! Senang banget kalau cocok di lidah keluarga.'),
    (2, 1, 'Sama-sama kak, boleh banget ditambah irisan pete atau bakso biar makin spesial.'),

    -- User 2 (pembuat resep 2) membalas ulasan di Ayam Bakar Madu
    (2, 2, 'Betul kak, kuncinya memang di api kecil pas ngungkep biar bumbunya meresap sempurna.'),

    -- User 3 (pembuat resep 3) membalas ulasan di Tumis Kangkung Terasi
    (3, 3, 'Mantap! Jangan lupa terasinya dibakar sebentar sebelum diulek biar aromanya lebih keluar.'),

    -- User 4 (pembuat resep 4) membalas ulasan di Pisang Goreng Crispy
    (4, 4, 'Rahasianya pakai air es dan campuran tepung beras biar kriuknya awet. Makasih review-nya!'),

    -- User 3 (pembuat resep 5) membalas ulasan di Puding Cokelat Vla Vanila
    (3, 5, 'Terima kasih! Kalau suka lebih creamy, susu cair di vla bisa diganti sebagian pakai whipping cream.');


INSERT INTO Votes (UserID, RecipeID, Vote)
VALUES 
    -- Resep 1 (Nasi Goreng Kampung Spesial)
	(2,1,'upvote'),
    (3, 1, 'upvote'),
    (4, 1, 'upvote'),

    -- Resep 2 (Ayam Bakar Madu)
    (3, 2, 'upvote'),
    (4, 2, 'downvote'),

    -- Resep 3 (Tumis Kangkung Terasi)
    (2, 3, 'upvote'),
    (4, 3, 'upvote'),

    -- Resep 4 (Pisang Goreng Crispy)
    (2, 4, 'upvote'),
    (3, 4, 'upvote'),

    -- Resep 5 (Puding Cokelat Vla Vanila)
    (2, 5, 'upvote'),
    (4, 5, 'upvote'),

    -- Resep 6 (Bubur Ayam Komplit)
	(3,6,'upvote'),
    (2, 6, 'upvote'),

    -- Resep 7 (Roti Bakar Keju Cokelat)
    (3, 7, 'upvote'),
    (4, 7, 'downvote');