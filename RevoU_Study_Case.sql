-- Active: 1692794651748@@127.0.0.1@3306@study_case
USE study_case;
/*
    List Pertanyaan:

    Fasilitas:
        1. Buatkan Data total jumlah fasilitas setiap daerah Kabupaten
        2. Cek Berapa banyak Jumlah Posyandu & Puskesmas daerah Kabupaten, urutkan berdasarkan Puskesmas
        3. Berapa Total setiap Rumah Sakit kabupaten
        4. Buatkan Data total jumlah fasilitas setiap daerah Kota
        5. Cek Berapa banyak Jumlah Posyandu & Puskesmas daerah Kota, urutkan berdasarkan Puskesmas
        6. Berapa total Rumah Sakit setiap Kota

    Kesehatan:
        7. Buatkan Data Total kesehatan penduduk setiap Kabupaten
        8. Buatkan Data penduduk berdasarkan APBN & APBD setiap Kabupaten
        9. Bandingkan Total Jaminan Pekerja setiap Kabupaten
        10. Buatkan Data Total kesehatan penduduk setiap Kota
        11. Buatkan Data penduduk berdasarkan APBN & APBD setiap Kota
        12. Bandingkan Total Jaminan Pekerja setiap Kota
    
    Catatan:
        Seluruh Analisis di urutkan dari Data Terkecil
*/

-- 1. Buatkan Data total jumlah fasilitas setiap daerah Kabupaten
SELECT nama_kabupaten_kota AS `nama_kabupaten` , SUM(jumlah_faskes) AS `total_fasilitas`
FROM faskes
WHERE nama_kabupaten_kota LIKE 'kabupaten%'
GROUP BY 1
ORDER BY 2 ASC;

-- 2. Cek Berapa banyak Jumlah Posyandu & Puskesmas daerah Kabupaten, urutkan berdasarkan Puskesmas     
SELECT 
    nama_kabupaten_kota AS `nama_kabupaten`,  
    SUM(IF(jenis_faskes = 'posyandu' , jumlah_faskes, 0)) AS `total_posyandu`,
    SUM(IF(jenis_faskes = 'puskesmas' , jumlah_faskes, 0)) AS `total_puskesmas`
FROM faskes
WHERE 
    nama_kabupaten_kota LIKE 'kabupaten%'
GROUP BY 1
ORDER BY 3 ASC;

-- 3. Berapa Total setiap Rumah Sakit kabupaten
SELECT nama_kabupaten_kota AS `nama_kabupaten`, 
       SUM(jumlah_faskes) AS `total_rumah_sakit`
FROM faskes
WHERE jenis_faskes LIKE 'rumah%' AND nama_kabupaten_kota LIKE 'kabupaten%'
GROUP BY nama_kabupaten_kota
ORDER BY total_rumah_sakit ASC;

-- 4. Buatkan Data total jumlah fasilitas setiap daerah Kota
SELECT nama_kabupaten_kota AS `nama_kota` , SUM(jumlah_faskes) AS `total_fasilitas`
FROM faskes
WHERE nama_kabupaten_kota LIKE 'kota%'
GROUP BY 1
ORDER BY 2 ASC;

-- 5. Cek Berapa banyak Jumlah Posyandu & Puskesmas daerah Kota, urutkan berdasarkan Puskesmas
SELECT 
    nama_kabupaten_kota AS `nama_kota`,  
    SUM(IF(jenis_faskes = 'posyandu' , jumlah_faskes, 0)) AS `total_posyandu`,
    SUM(IF(jenis_faskes = 'puskesmas' , jumlah_faskes, 0)) AS `total_puskesmas`
FROM faskes
WHERE 
    nama_kabupaten_kota LIKE 'kota%'
GROUP BY 1
ORDER BY 2 ASC;

-- 6. Berapa total Rumah Sakit setiap Kota
SELECT nama_kabupaten_kota AS `nama_kota`, 
       SUM(jumlah_faskes) AS `total_rumah_sakit`
FROM faskes
WHERE jenis_faskes LIKE 'rumah%' AND nama_kabupaten_kota LIKE 'kota%'
GROUP BY nama_kabupaten_kota
ORDER BY total_rumah_sakit ASC;

-- 7. Buatkan Data Total kesehatan penduduk setiap Kabupaten
SELECT nama_kabupaten_kota AS `nama_kabupaten`, SUM(jumlah_penduduk) AS `total_penduduk`
FROM kesehatan
WHERE nama_kabupaten_kota LIKE 'kabupaten%'
GROUP BY 1
ORDER BY 2 ASC;

-- 8. Buatkan Data penduduk berdasarkan APBN & APBD setiap Kabupaten
SELECT 
    nama_kabupaten_kota AS `nama_kabupaten`, 
    SUM(IF(jaminan_kesehatan LIKE '%APBN', jumlah_penduduk, 0)) AS `Total_APBN`,
    SUM(IF(jaminan_kesehatan LIKE '%APBD', jumlah_penduduk, 0)) AS `Total_APBD`
FROM kesehatan
WHERE nama_kabupaten_kota LIKE 'kabupaten%'
GROUP BY nama_kabupaten_kota
ORDER BY `Total_APBN` ASC;

-- 9. Bandingkan Total Jaminan Pekerja setiap Kabupaten
SELECT
    nama_kabupaten_kota AS `nama_kabupaten`,
    SUM(IF(jaminan_kesehatan LIKE '%(PPU)', jumlah_penduduk, 0)) AS `Total_PPU`,
    SUM(IF(jaminan_kesehatan LIKE '%Mandiri', jumlah_penduduk, 0)) AS `Total_PBPU`,
    SUM(IF(jaminan_kesehatan LIKE '%(BP)', jumlah_penduduk, 0)) AS `Total_BP`
FROM kesehatan
WHERE nama_kabupaten_kota LIKE 'kabupaten%'
GROUP BY nama_kabupaten_kota
ORDER BY `Total_PPU` ASC;

-- 10. Buatkan Data Total kesehatan penduduk setiap Kota
SELECT nama_kabupaten_kota AS `nama_kota`, SUM(jumlah_penduduk) AS `total_penduduk`
FROM kesehatan
WHERE nama_kabupaten_kota LIKE 'kota%'
GROUP BY 1
ORDER BY 2 ASC;

-- 11. Buatkan Data penduduk berdasarkan APBN & APBD setiap Kota
SELECT 
    nama_kabupaten_kota AS `nama_kota`, 
    SUM(IF(jaminan_kesehatan LIKE '%APBN', jumlah_penduduk, 0)) AS `Total_APBN`,
    SUM(IF(jaminan_kesehatan LIKE '%APBD', jumlah_penduduk, 0)) AS `Total_APBD`
FROM kesehatan
WHERE nama_kabupaten_kota LIKE 'kota%'
GROUP BY nama_kabupaten_kota
ORDER BY `Total_APBN` ASC;

-- 12. Bandingkan Total Jaminan Pekerja setiap Kota
SELECT
    nama_kabupaten_kota AS `nama_kota`,
    SUM(IF(jaminan_kesehatan LIKE '%(PPU)', jumlah_penduduk, 0)) AS `Total_PPU`,
    SUM(IF(jaminan_kesehatan LIKE '%Mandiri', jumlah_penduduk, 0)) AS `Total_PBPU`,
    SUM(IF(jaminan_kesehatan LIKE '%(BP)', jumlah_penduduk, 0)) AS `Total_BP`
FROM kesehatan
WHERE nama_kabupaten_kota LIKE 'kota%'
GROUP BY nama_kabupaten_kota
ORDER BY `Total_PPU` ASC;