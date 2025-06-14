-- CreateEnum
CREATE TYPE "Peran" AS ENUM ('siswa', 'guru', 'pustakawan');

-- CreateEnum
CREATE TYPE "FormatBuku" AS ENUM ('hardcopy', 'ebook');

-- CreateTable
CREATE TABLE "Anggota" (
    "id" SERIAL NOT NULL,
    "sandi" VARCHAR(255) NOT NULL,
    "nama" TEXT NOT NULL,
    "jenisKelamin" VARCHAR(10) NOT NULL,
    "peran" "Peran" NOT NULL DEFAULT 'siswa',
    "tglDaftar" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Anggota_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Siswa" (
    "id" INTEGER NOT NULL,
    "nis" VARCHAR(20) NOT NULL,
    "kelas" VARCHAR(20) NOT NULL,

    CONSTRAINT "Siswa_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Guru" (
    "id" INTEGER NOT NULL,
    "nip" VARCHAR(20) NOT NULL,
    "mapel" VARCHAR(50) NOT NULL,

    CONSTRAINT "Guru_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pustakawan" (
    "id" INTEGER NOT NULL,
    "kodeStaf" VARCHAR(20) NOT NULL,

    CONSTRAINT "Pustakawan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Kategori" (
    "ddc" VARCHAR(20) NOT NULL,
    "nama" VARCHAR(100) NOT NULL,

    CONSTRAINT "Kategori_pkey" PRIMARY KEY ("ddc")
);

-- CreateTable
CREATE TABLE "KategoriBuku" (
    "bukuId" INTEGER NOT NULL,
    "kategoriId" TEXT NOT NULL,

    CONSTRAINT "KategoriBuku_pkey" PRIMARY KEY ("bukuId","kategoriId")
);

-- CreateTable
CREATE TABLE "Buku" (
    "id" SERIAL NOT NULL,
    "judul" VARCHAR(255) NOT NULL,
    "penulis" VARCHAR(100) NOT NULL,
    "penerbit" VARCHAR(100) NOT NULL,
    "tglTerbit" TIMESTAMP(3) NOT NULL,
    "isbn" VARCHAR(20) NOT NULL,
    "rak" VARCHAR(50) NOT NULL,
    "jumlah" INTEGER NOT NULL DEFAULT 0,
    "jumlahTersedia" INTEGER NOT NULL DEFAULT 0,
    "format" "FormatBuku" NOT NULL DEFAULT 'hardcopy',
    "urlFile" VARCHAR(255),
    "urlSampul" VARCHAR(255),
    "tglInput" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Buku_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PeminjamanBuku" (
    "id" SERIAL NOT NULL,
    "bukuId" INTEGER NOT NULL,
    "anggotaId" INTEGER NOT NULL,
    "tglPinjam" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tglJatuhTempo" TIMESTAMP(3) NOT NULL,
    "tglKembali" TIMESTAMP(3),
    "denda" DOUBLE PRECISION DEFAULT 0,

    CONSTRAINT "PeminjamanBuku_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Siswa_nis_key" ON "Siswa"("nis");

-- CreateIndex
CREATE UNIQUE INDEX "Guru_nip_key" ON "Guru"("nip");

-- CreateIndex
CREATE UNIQUE INDEX "Pustakawan_kodeStaf_key" ON "Pustakawan"("kodeStaf");

-- CreateIndex
CREATE UNIQUE INDEX "Kategori_nama_key" ON "Kategori"("nama");

-- CreateIndex
CREATE UNIQUE INDEX "Buku_isbn_key" ON "Buku"("isbn");

-- CreateIndex
CREATE INDEX "PeminjamanBuku_bukuId_idx" ON "PeminjamanBuku"("bukuId");

-- CreateIndex
CREATE INDEX "PeminjamanBuku_anggotaId_idx" ON "PeminjamanBuku"("anggotaId");

-- AddForeignKey
ALTER TABLE "Siswa" ADD CONSTRAINT "Siswa_id_fkey" FOREIGN KEY ("id") REFERENCES "Anggota"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Guru" ADD CONSTRAINT "Guru_id_fkey" FOREIGN KEY ("id") REFERENCES "Anggota"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pustakawan" ADD CONSTRAINT "Pustakawan_id_fkey" FOREIGN KEY ("id") REFERENCES "Anggota"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "KategoriBuku" ADD CONSTRAINT "KategoriBuku_bukuId_fkey" FOREIGN KEY ("bukuId") REFERENCES "Buku"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "KategoriBuku" ADD CONSTRAINT "KategoriBuku_kategoriId_fkey" FOREIGN KEY ("kategoriId") REFERENCES "Kategori"("ddc") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PeminjamanBuku" ADD CONSTRAINT "PeminjamanBuku_bukuId_fkey" FOREIGN KEY ("bukuId") REFERENCES "Buku"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PeminjamanBuku" ADD CONSTRAINT "PeminjamanBuku_anggotaId_fkey" FOREIGN KEY ("anggotaId") REFERENCES "Anggota"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
