/*
  Warnings:

  - The primary key for the `Meta` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `data_fim` on the `Meta` table. All the data in the column will be lost.
  - You are about to drop the column `data_inicio` on the `Meta` table. All the data in the column will be lost.
  - You are about to drop the column `descricao` on the `Meta` table. All the data in the column will be lost.
  - You are about to drop the column `tempo_diario` on the `Meta` table. All the data in the column will be lost.
  - You are about to drop the column `titulo` on the `Meta` table. All the data in the column will be lost.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `Registro` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `dailyMinutes` to the `Meta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `endDate` to the `Meta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `startDate` to the `Meta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `title` to the `Meta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Meta" DROP CONSTRAINT "Meta_userId_fkey";

-- DropForeignKey
ALTER TABLE "Registro" DROP CONSTRAINT "Registro_metaId_fkey";

-- AlterTable
ALTER TABLE "Meta" DROP CONSTRAINT "Meta_pkey",
DROP COLUMN "data_fim",
DROP COLUMN "data_inicio",
DROP COLUMN "descricao",
DROP COLUMN "tempo_diario",
DROP COLUMN "titulo",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "dailyMinutes" INTEGER NOT NULL,
ADD COLUMN     "description" TEXT,
ADD COLUMN     "endDate" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "startDate" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "title" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "userId" SET DATA TYPE TEXT,
ADD CONSTRAINT "Meta_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Meta_id_seq";

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "password" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "User_id_seq";

-- DropTable
DROP TABLE "Registro";

-- CreateTable
CREATE TABLE "Study" (
    "id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "minutes" INTEGER NOT NULL,
    "completed" BOOLEAN NOT NULL DEFAULT false,
    "metaId" TEXT NOT NULL,

    CONSTRAINT "Study_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Meta" ADD CONSTRAINT "Meta_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Study" ADD CONSTRAINT "Study_metaId_fkey" FOREIGN KEY ("metaId") REFERENCES "Meta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
