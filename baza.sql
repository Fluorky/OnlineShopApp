-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Czas generowania: 17 Sty 2022, 14:22
-- Wersja serwera: 10.1.19-MariaDB
-- Wersja PHP: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `baza`
--

DELIMITER $$
--
-- Funkcje
--
CREATE DEFINER=`root`@`localhost` FUNCTION `bez_pl_diakrytycznych` (`t` TEXT) RETURNS TEXT CHARSET utf8 COLLATE utf8_polish_ci BEGIN
    SET t = REPLACE(t, 'ą', 'a');
    SET t = REPLACE(t, 'Ą', 'A');
    SET t = REPLACE(t, 'ć', 'c');
    SET t = REPLACE(t, 'Ć', 'C');
    SET t = REPLACE(t, 'ę', 'e');
    SET t = REPLACE(t, 'Ę', 'E');
    SET t = REPLACE(t, 'ł', 'l');
    SET t = REPLACE(t, 'Ł', 'L');
    SET t = REPLACE(t, 'ń', 'n');
    SET t = REPLACE(t, 'Ń', 'N');
    SET t = REPLACE(t, 'ó', 'o');
    SET t = REPLACE(t, 'Ó', 'O');
    SET t = REPLACE(t, 'ś', 's');
    SET t = REPLACE(t, 'Ś', 'S');
    SET t = REPLACE(t, 'ż', 'z');
    SET t = REPLACE(t, 'Ż', 'Z');
    SET t = REPLACE(t, 'ź', 'z');
    SET t = REPLACE(t, 'Ź', 'Z');
    return t;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `idBuyer` int(11) NOT NULL,
  `buyerName` varchar(90) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `orders`
--

INSERT INTO `orders` (`id`, `idBuyer`, `buyerName`, `date`) VALUES
(1, 4, 'Mariusz Haler', '2021-12-27 15:19:48'),
(2, 5, 'Pawel Kowalczyk', '2021-12-27 15:25:46'),
(16, 14, 'Karol Dominik', '2021-12-27 16:29:12'),
(17, 9, 'Janusz Nowicki', '2021-12-28 18:19:02'),
(18, 4, 'Mariusz Haler', '2021-12-31 12:54:24'),
(19, 1, 'Maciej B', '2022-01-03 18:14:41'),
(20, 1, 'Maciej B', '2022-01-04 10:42:51'),
(21, 1, 'Maciej B', '2022-01-10 12:57:00'),
(22, 1, 'Maciej B', '2022-01-10 13:36:42'),
(23, 1, 'Maciej B', '2022-01-17 14:00:54'),
(24, 1, 'Maciej B', '2022-01-17 14:07:58'),
(25, 13, 'Arianna Grande', '2022-01-17 14:09:04');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `order_products`
--

CREATE TABLE `order_products` (
  `orderid` int(11) NOT NULL,
  `productid` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `orderStatus` int(11) NOT NULL DEFAULT '5',
  `buyerReadNot` tinyint(4) NOT NULL DEFAULT '1',
  `sellerReadNot` tinyint(4) NOT NULL DEFAULT '0',
  `adminReadNot` tinyint(4) NOT NULL DEFAULT '0',
  `problemDescription` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `order_products`
--

INSERT INTO `order_products` (`orderid`, `productid`, `quantity`, `orderStatus`, `buyerReadNot`, `sellerReadNot`, `adminReadNot`, `problemDescription`) VALUES
(1, 1, 3, 5, 0, 0, 0, ''),
(2, 5, 2, 2, 0, 0, 1, 'Problemem zajal sie administrator'),
(16, 3, 4, 5, 1, 0, 0, NULL),
(17, 2, 1, 1, 0, 0, 1, 'Problemem zajal sie administrator'),
(18, 177, 1, 5, 1, 0, 0, NULL),
(20, 45, 1, 5, 1, 0, 0, NULL),
(21, 183, 8, 5, 1, 0, 0, NULL),
(22, 183, 3, 5, 1, 0, 0, NULL),
(23, 160, 1, 5, 1, 0, 0, NULL),
(24, 183, 2, 5, 1, 0, 0, NULL),
(25, 18, 1, 3, 0, 0, 1, 'Problemem zajal sie administrator');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pictures`
--

CREATE TABLE `pictures` (
  `id` int(11) NOT NULL,
  `name` varchar(90) NOT NULL,
  `id_Product` int(11) DEFAULT NULL,
  `id_Owner` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `pictures`
--

INSERT INTO `pictures` (`id`, `name`, `id_Product`, `id_Owner`) VALUES
(1, 'galaxy-s7-black.png', 1, 1),
(2, 'galaxy-s7-black.png', 2, 1),
(3, 'samsuns7leftangle.jpeg', 1, 1),
(4, 'Fender American Vintage ''65 Jazzmaster.jpg', 5, 1),
(5, 'Fender American Professional Stratocaster HSS.jpg', 6, 1),
(6, 'Gibson Les Paul Classic T 2017 Lemon Burst.jpg', 7, 1),
(7, 'reloop rhp 5 ltd.jpg', 18, 1),
(8, 't-shirt in cotone con maxi stampa.jpg', 11, 1),
(9, 't-shirt in jersey tinto in capo.jpg', 12, 1),
(10, 'ultimate lto-1000 qr laptop dj stand.jpg', 17, 1),
(11, 'sneakers uomo delmor.jpg', 15, 1),
(12, 'sneakers mid-cut uomo vurton.jpg', 16, 1),
(13, 'jeans skinny fit jondrill.jpeg', 14, 1),
(14, 'giubbotto in cotone con patch.jpg', 10, 1),
(15, 'giubbotto dark stretch denim.jpg', 9, 1),
(16, 'jeans skinny fit maestro jondrill.jpg', 13, 1),
(17, 'sony entertainment ps4 500gb d chassis black.jpg', 26, 1),
(18, 'microsoft xbox one 1tb.jpg', 27, 1),
(19, 'hp 15-ay501nl.jpg', 22, 1),
(20, 'iphone-7-matt-black_sku-header.png', 3, 1),
(21, 'samsung-galaxy-s7-edge-2.jpg', 4, 1),
(22, 'asus vivobook pro n552vx_fw131t.jpg', 23, 1),
(23, 'roland fp-80-bk.jpg', 19, 1),
(24, 'pioneer DDJ-RX.jpg', 8, 1),
(25, 'apple macbook pro retina 15.jpg', 21, 1),
(26, 'macbook air 13.jpg', 20, 1),
(27, 'sony bravia kd55a1.jpg', 25, 1),
(28, 'sony kd55a1.jpg', 24, 1),
(29, '28.png', 28, 1),
(30, '29.jpeg', 29, 1),
(31, '31.png', 31, 1),
(32, '33.jpg', 33, 1),
(33, '34.jpeg', 34, 1),
(34, '35.jpeg', 35, 1),
(35, '36.jpeg', 36, 1),
(36, '37.png', 37, 1),
(37, '38.jpg', 38, 1),
(38, '39.jpg', 39, 1),
(39, '40.jpg', 40, 1),
(40, '41.jpg', 41, 1),
(41, '42.jpg', 42, 1),
(42, '43.jpg', 43, 1),
(43, '44.jpg', 44, 1),
(44, '45.jpg', 45, 1),
(45, '46.jpg', 46, 1),
(46, '47.jpg', 47, 1),
(47, '48.jpg', 48, 1),
(48, '49.jpg', 49, 1),
(49, '50.jpg', 50, 1),
(50, '51.jpg', 51, 1),
(51, '52.jpg', 52, 1),
(52, '53.jpg', 53, 1),
(53, '54.png', 54, 1),
(54, '55.jpg', 55, 1),
(55, '56.jpg', 56, 1),
(56, '57.jpg', 57, 1),
(57, '58.jpg', 58, 1),
(58, '59.jpg', 59, 1),
(59, '60.png', 60, 1),
(60, '61.jpg', 61, 1),
(61, '62.jpeg', 62, 1),
(62, '63.jpg', 63, 1),
(63, '65.jpg', 65, 1),
(64, '66.jpg', 66, 1),
(65, '67.jpg', 67, 1),
(66, '68.jpeg', 68, 1),
(67, '69.png', 69, 1),
(68, '70.jpg', 70, 1),
(69, '71.jpg', 71, 1),
(70, '72.jpg', 72, 1),
(71, '73.jpg', 73, 1),
(72, '75.jpg', 75, 1),
(73, '76.jpg', 76, 1),
(74, '77.jpeg', 77, 1),
(75, '78.jpg', 78, 1),
(76, '79.jpg', 79, 1),
(77, '80.png', 80, 1),
(78, '30.jpg', 30, 1),
(79, '32.jpg', 32, 1),
(80, '64.jpg', 64, 1),
(81, '86.jpg', 86, 1),
(82, '100.jpg', 100, 1),
(83, '117.jpg', 117, 1),
(84, '121.jpg', 121, 1),
(85, '128.jpg', 128, 1),
(86, '137.jpg', 137, 1),
(87, '148.jpg', 148, 1),
(88, '153.jpg', 153, 1),
(89, '195.jpg', 195, 1),
(90, '202.jpg', 202, 1),
(91, '210.jpg', 210, 1),
(92, '218.jpg', 218, 1),
(93, '74.png', 74, 1),
(94, '89.png', 89, 1),
(95, '115.png', 115, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `description` varchar(600) COLLATE utf8_polish_ci NOT NULL,
  `price` double DEFAULT NULL,
  `id_shop` int(11) DEFAULT NULL,
  `categoria` varchar(100) COLLATE utf8_polish_ci NOT NULL,
  `InStock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `id_shop`, `categoria`, `InStock`) VALUES
(1, 'Samsung S7 32 GB', 'Czteropasmowy — 3G — 4G — Wi-Fi\r\n12-megapikselowy aparat z dwoma pikselami\r\nProcesor czterordzeniowy 2,3 GHz + czterordzeniowy 1,6 GHz\r\nAndroid 6.0 Marshmallow - pamiec 32 GB - GPS\r\n5,1-calowy wyswietlacz Quad HD Super Amoled, ekran dotykowy\r\nDystrybucja: Samsung Wlochy', 544.99, 1, 'Smartphony', 2),
(2, 'Samsung S7 32 GB', 'Czteropasmowy — 3G — 4G — Wi-Fi\r\n12-megapikselowy aparat z dwoma pikselami\r\nProcesor czterordzeniowy 2,3 GHz + czterordzeniowy 1,6 GHz\r\nAndroid 6.0 Marshmallow - pamiec 32 GB - GPS\r\n5,1-calowy wyswietlacz Quad HD Super Amoled, ekran dotykowy\r\nDystrybucja: Samsung Wlochy', 550, 2, 'Smartphony', 15),
(3, 'iPhone 7 32 GB', 'Czteropasmowy — 3G — 4G LTE Advanced — Wi-Fi\r\n12-megapikselowa kamera iSight — wideo 4K\r\nSystem operacyjny IOS10 — wspomagany GPS i GLONASS\r\nWyswietlacz Retina HD 4,7" - pamiec 32 GB\r\nProcesor A10 Fusion — Touch ID\r\nDystrybuowane przez Apple Wlochy', 669, 1, 'Smartphony', 8),
(4, 'Samsung S7 Edge 32 GB', 'Czteropasmowy — 3G — 4G — Wi-Fi\r\n12-megapikselowy aparat z dwoma pikselami\r\nProcesor czterordzeniowy 2,3 GHz + czterordzeniowy 1,6 GHz\r\nAndroid 6.0 Marshmallow - pamiec 32 GB - GPS\r\nEkran dotykowy Quad HD Super Amoled 5,5"\r\nDystrybucja: Samsung Wlochy', 680, 1, 'Smartphony', 9),
(5, 'Fender American Vintage  ''65 Jazzmaster', 'Seria Vintage.\r\nCialo olchy.\r\nGryf klonowy z laminowana podstrunnica z palisandru\r\nOrzech w kosci.\r\nSkala 25,5”, inkrustacje ze sciegu perlowego.\r\n2 przetworniki American Vintage ''65 z pojedyncza cewka Jazzmaster.\r\nRegulacja glosnosci, tony + 1 3-pozycyjny przelacznik.\r\nAmerican Vintage Bridge z Tremolo.\r\nTunery w stylu vintage „Fender Deluxe”\r\n4-warstwowa maskownica szylkretowa.\r\nZawiera: twardy futeral (Deluxe Vintage Black), pasek na ramie, liny, kabel, sciereczke do czyszczenia.', 1940, 3, 'Instrumenty muzyczne', 0),
(6, 'Fender American Professional Stratocaster HSS', 'Korpus jesionowy, wykonczenie poliuretanowe na polysk.\r\nSzyja klonowa, gleb. C.\r\nPodstrunnica z palisandru\r\nLuski 25,5”, inkrustacje w biale kropki.\r\nOrzech w kosci.\r\n2 jednocewkowe przetworniki V-Mode\r\n1 przystawka mostkowa Shawbucker ™ 1\r\nRegulacja glosnosci/tonu + 1 5-pozycyjny przelacznik.\r\nMostek: tremolo\r\nTunery: Standardowy blotnik.\r\n3-warstwowa maskownica pergaminowa\r\nW zestawie elitarne etui.', 1520, 3, 'Instrumenty muzyczne', 20),
(7, 'Gibson Les Paul Classic T 2017 Lemon Burst', 'Mahoniowy korpus z gladkim klonowym blatem.\r\nMahoniowy gryf z palisandrowa podstrunnica\r\nSkala 24,75”, akrylowe wstawki trapezowe.\r\n1 klasyczny pickup pod szyja 57.\r\n1 klasyczny 57 plus podbicie z mostu.\r\nSterowanie: glosnosc / ton-\r\n1 3-pozycyjny selektor.\r\nMostek Tune-o-matic + chromowany stoper.\r\nMechanika Grovera\r\nKolor Powierzchni - zielony ', 1499, 3, 'Instrumenty muzyczne', 1),
(8, 'Pioneer DDJ-RX', 'PIONEER DDJ-RX\r\n\r\nPierwszy kontroler na swiecie (wraz z ddj-rz) zoptymalizowany pod katem rekordbox dj.\r\n\r\nWyposazony w intuicyjny uklad, ktory odzwierciedla oprogramowanie, przyciski z dostosowywanymi parametrami rytmu oraz tryby Sampler Cue i Sequencer do nagrywania i odtwarzania bezposrednio z pada.', 1060, 3, 'Instrumenty muzyczne', 7),
(17, 'Ultimate LPT-1000QR Laptop/DJ Stand', 'Stojak na laptopa lub sprzet DJ-ski.\r\nWysokosc 12,5" (318mm)\r\nWaga 3,1 kg.', 99, 3, 'Instrumenty muzyczne', 0),
(18, 'Reloop Rhp 5 - LTD', 'RELOOP RHP 5 LIMITOWANY\r\nUltrakompaktowy profesjonalny zestaw sluchawkowy z malowanej gumy, z obrotowymi nausznikami (srednica 70 mm), przetwornikiem o wysokiej izolacji akustycznej, wysuwanym wspornikiem, cisnieniem akustycznym 96 dB, pasmem przenoszenia 10 Hz - 22 kHz, zintegrowanym mikrofonem kompatybilnym ze wszystkimi obecnie uzywanymi telefonami komorkowymi wyposazonymi w mini 3,5 mm jack (iPhone i inne smartfony), waga 136g Bialy kolor.\r\nKARTA DANYCH:\r\nPasmo przenoszenia: 10Hz - 22kHz\r\nCisnienie akustyczne: 96 dB\r\nZlacza: jack 3,5 / 6,3 mm\r\nKable: spirala 1,3 m', 25, 3, 'Audio/Video', 5),
(19, 'Roland FP80bk', 'Przenosny i nowoczesny FP-80 zapewnia bogaty, potezny dzwiek, ktorym moga sie cieszyc wszyscy milosnicy pianina. Klawiatura Ivory Feel-S i generator fortepianow SuperNATURAL gwarantuja maksymalna ekspresje, podczas gdy zintegrowany system wzmocnienia, dzieki technologii Acoustic Projection firmy Roland, uwalnia potezny i otaczajacy dzwiek. Funkcja Rhythm dodaje radosci podczas gry dzieki licznym i szczegolowym automatycznym akompaniamentom, ktore beda sledzic Twoje wystepy w czasie rzeczywistym. Dostepny zarowno w kolorze czarnym, jak i bialym, wszechstronny FP-80 jest idealny na kilka minut', 870, 3, 'IT', 15),
(20, 'APPLE MACBOOK AIR 13'''' MQD42T/A\n', 'Procesor Intel® Core™ i5 (1,8/2,9 GHz, 3 MB L3)\r\nDysk SSD HD 256 GB - 8 GB RAM - 13,3" podswietlany wyswietlacz LED\r\nWi-Fi 802.11a / b / g / n / ac - Bluetooth 4.0 - Mac OS Sierra\r\nKarta graficzna Intel® HD Graphics 6000\r\nGladzik wielodotykowy — kamera FaceTime HD', 1199, 1, 'IT', 10),
(21, 'APPLE MACBOOK PRO RETINA 15" MJLQ2T/A\n', 'Procesor: czterordzeniowy procesor Intel® Core ™ i7 (2,2 GHz, pamiec podreczna: 6 MB) - HD: GB - RAM: 16 GB - Wyswietlacz: 15,4 ''Format: 16:10 - Bluetooth: Bluetooth 4.0 - System operacyjny: Mac OS X Yosemite - Karta graficzna: Intel Iris Pro Graphics', 2299, 1, 'IT', 11),
(22, 'HP 15-AY501NL\n', 'Procesor Intel® Core ™ i3-6006U (2 GHz - 3 MB L3)\r\nDysk twardy 500 GB - RAM 4 GB - Wyswietlacz 15,6" WLED\r\nWi-Fi IEEE 802.11b/g/n - Bluetooth 4.0 - Windows 10 Home 64-bit\r\nKarta graficzna AMD Radeon R5 M430 (dedykowane 2 GB)', 399, 1, 'IT', 95),
(23, 'ASUS VivoBook Pro N552VX-FW131T\n', 'Procesor Intel® Core ™ i7-6700HQ (2,6 / 3,5 GHz, 6 MB L3)\r\nHD 1000 GB - RAM 8 GB - Wyswietlacz LED Full HD 15,6"\r\nWi-Fi 802.11a / b / g / n / ac - Bluetooth 4.0 - Windows 10\r\nKarta graficzna NVidia GeForce GTX 950M (4 GB dedykowane)', 799, 1, 'IT', 6),
(24, 'SONY BRAVIA KD55A1\n', 'Telewizor Sony BRAVIA 55" OLED 4K HDR\r\nProcesor 4K HDR X1 Extreme, wyswietlacz Triluminos\r\nNawierzchnia akustyczna ze zintegrowanym subwooferem\r\nJeden projekt lupkow, AndroidTV\r\nTuner HD DVB-T2, DVB-S2 i DVB-C, Premium SMART CAM Ready\r\nTivůsat, HEVC. Wbudowane Wi-Fi, wbudowany Chromecast, Screen Mirroring do bezprzewodowego udostepniania ekranu smartfona\r\nGniazdo CI +, siec domowa, 4 HDMI, 3 USB\r\nDystrybuowane przez Sony Wlochy', 3499, 1, 'Urzadzenia domowe', 0),
(25, 'SONY KD-55A1', 'Rozmiar ekranu (cale) 55 - Technologia FULL HD - Smart TV - Rozdzielczosc UHD 4K', 3480, 2, 'Urzadzenia domowe', 0),
(26, 'SONY ENTERTAINMENT PS4 500GB D Chassis Black', 'Najlepiej sprzedajaca sie konsola na swiecie, teraz z nowym wygladem i oszalamiajacymi obrazami HDR. Przechowuj gry, aplikacje i migawki, wybierajac modele od 500 GB do 1 TB. Najlepsze programy telewizyjne, filmy i nie tylko z Twoich ulubionych aplikacji rozrywkowych.', 279, 115, 'Gry na konsole', 0),
(27, 'MICROSOFT XBOX ONE 1TB', 'Xbox One ma elegancki, nowoczesny sprzet i ma wspolczynnik proporcji 16: 9 przy orientacji poziomej zoptymalizowanej pod katem szybkiego odtwarzacza Blu-ray. Konsola w cieplym i glebokim blyszczacym czarnym kolorze ma charakterystyczny design z zaokraglonymi naroznikami. Konsola Xbox One zostala zaprojektowana, aby dostarczac zupelnie nowa generacje gier, programow telewizyjnych i rozrywki za posrednictwem jednego, wydajnego urzadzenia typu wszystko w jednym o specjalnej, nowoczesnej architekturze, ktora dodaje odrobine prostoty do salonu.', 327, 2, 'Gry na konsole', 0),
(37, 'FIFA 18', 'EA SPORTS ™ FIFA 18 zaciera granice miedzy swiatem rzeczywistym i wirtualnym, ozywiajac bohaterow, druzyny i atmosfere najlepszej gry na swiecie.\r\nFIFA 18 wprowadza najwieksza innowacje do systemu gry w historii serii, technologie animacji Real Player, innowacyjny system, ktory odblokowuje nowy poziom responsywnosci i osobowosci dla graczy.\r\nTeraz Cristiano Ronaldo i pozostali mistrzowie poruszaja sie dokladnie tak, jak na prawdziwym boisku.', 70.98, 10, 'Gry na konsole', 0),
(38, 'GTA V', 'Los Santos: Ogromna, sloneczna metropolia pelna samozwanczych guru, aktorek i celebrytow na bulwarze zachodzacego slonca. Kiedys byl przedmiotem zazdrosci zachodniego swiata, ale teraz musi sie zadowolic, by utrzymac sie na powierzchni w dobie niepewnosci gospodarczej i taniej telewizji kablowej.\r\nW tym wszystkim trzech bardzo roznych przestepcow walczy o przetrwanie i spelnienie, kazdy na swoj sposob: ambitny Franklin poszukuje pieniedzy i mozliwosci; Michael, byly zawodowy przestepca, zmaga sie z mniej rozowa „emerytura” niz oczekiwano; i Trevor, maniak', 74.98, 70, 'Gry na konsole', 0),
(39, 'Kontroler Wireless DUALSHOCK®4 - Steel Black', 'Wchodz w interakcje z grami w sposob, ktory juz znasz i w sposob, ktorego nigdy sobie nie wyobrazales. Bardziej precyzyjne drazki, wbudowane czujniki ruchu, wbudowany glosnik i sterowanie dotykowe to tylko niektore z funkcji, ktore sprawiaja, ze bezprzewodowy kontroler DUALSHOCK 4 oddaje w Twoje rece intuicyjna i kompletna gre.\r\nNowy sposob na gre. Najlepszy projekt w historii', 74.98, 28, 'Gry na konsole', 0),
(43, 'Audi A1', '1.0 TFSI 82cv', 18.15, 12, 'Samochody', 0),
(44, 'Audi A3', '1.0 TFSI', 24.8, 12, 'Samochody', 0),
(45, 'Audi A5', '2.0 TFSI 140KW', 40.75, 12, 'Samochody', 0),
(54, 'Apple iPhone 7', 'iPhone 7.', 919.9, 19, 'Smartphony', 0),
(59, 'Glosnik przenosny SONY GTK-XB5', 'GLEBOKIE I PRZYTLACZAJACE BASY KONFIGURACJA PIONOWA LUB POZIOMA BLUETOOTH, NFC, EFEKTY SWIATLA', 149.9, 25, 'Audio/Video', 0),
(61, 'Huawei P8 Lite 4G 16GB Nero', 'Sistema operativo incluso Android \nModello del processore Kirin 620 \nDimensioni schermo 5  "\nCapacitŕ memoria interna 16  GB\nCapacitŕ RAM 2048  MB\nNear Field Communication (NFC) Si \nBluetooth Si \nColore del prodotto Nero ', 149.9, 27, 'Smartphony', 0),
(62, 'JOHN LENNON - VINYL BOX', 'John Lennon - v inyl box 8 LP', 40, 29, 'Audio/Video', 0),
(82, 'Duże AGD - dowolne pozycjonowanie', 'Szeroki wybor duzych urzadzen, takze do zabudowy: duzych, cichych i ekonomicznych, dzieki ktorym zaoszczedzisz wiele cennego czasu. Jestesmy w stanie zaspokoic wszystkie Twoje potrzeby.\r\nNajwazniejsze pozycje w asortymencie:\r\nPralki, suszarki, zmywarki, plyty grzewcze, piekarniki, okapy, lodowki i zamrazarki.', 550, 52, 'Urzadzenia domowe', 0),
(83, 'Apple\niPhone SE', 'Najpotezniejszy 4-calowy telefon, jaki kiedykolwiek powstal, ma niezwykle udana kompaktowa konstrukcje, dodajac dwa zaawansowane aparaty i niesamowita moc przetwarzania.\r\nZaprojektowany tak, aby wygodnie lezal w dloni i byl przyjemny w dotyku, dzieki satynowemu wykonczeniu powloki z mikropiaskowanego aluminium.\r\n4-calowy wyswietlacz Retina, czip A9 o architekturze 64-bitowej klasy komputerowej, czytnik linii papilarnych Touch ID, kamera iSight 12 MP, kamera FaceTime HD z lampa blyskowa Retina, zdjecia na zywo oraz szybkie polaczenia Wi-Fi i 4G. I wiecej, iOS 9 i iCloud .', 575, 53, 'Smartphony', 0),
(84, 'Huawei P10', 'Przejrzysty design HUAWEI P10 rozwija sie wokol lekkiej struktury o grubosci zaledwie 7 mm z wykonczeniem, ktore zapewnia odpornosc i kolor, podczas gdy podwojny aparat do splukiwania podkresla miekkie i zaokraglone krzywe.\r\nPodwojny aparat opracowany z Leica jest wyposazony w dwa obiektywy z przyslona F2.2 i sensorami 20MP + 12MP z OIS. Najwyzszej jakosci obrazy w warunkach slabego oswietlenia.\r\nAkumulator o duzej pojemnosci 3200 mAh w HUAWEI P10 obsluguje technologie ladowania HUAWEI SuperCharge. Dzieki ochronie 5 bramek ladowanie jest teraz szybkie i bezpieczne.\r\nUltra mem', 885, 54, 'Smartphony', 0),
(99, 'MacBook', 'Dwurdzeniowy procesor Intel Core m3 1,2 GHz 7. generacji (Turbo Boost do 3,0 GHz)\r\n8 GB pamieci LPDDR3 1866 MHz\r\n256 GB pamieci SSD\r\nKarta graficzna Intel HD 615\r\nPodswietlana klawiatura – polska', 1549, 71, 'IT', 0),
(111, 'MIRO’ JOAN', 'Oryginalna litografia z 1975 roku na specjalnym papierze artystycznym wydrukowana przez Mourlot.', 350, 85, 'Przedmioty kolekcjonerskie', 0),
(135, 'Rowenta Air Force 360 - RH9059', 'Codzienne odkurzanie to najlepszy sposob, aby zawsze miec idealny dom. Aby sprzatac bez wysilku, Rowenta wprowadza na rynek AIR FORCE™ 360. Jednoczesnie elektryczna miotla i mocny bezprzewodowy odkurzacz, to „wszystko w 1” urzadzenie szybko stanie sie Twoim codziennym towarzyszem w domu. Lekki i ultrawydajny, moze byc uzywany codziennie, aby wyeliminowac nawet kurz znajdujacy sie w najtrudniej dostepnych punktach!', 249.9, 111, 'Urzadzenia domowe', 0),
(149, 'Eko CS 5 Pack', 'Blister zawierajacy: gitare CS-5, pokrowiec z paskiem na ramie, rurke smolowa, 3 kostki.', 59, 127, 'Instrumenty muzyczne', 0),
(154, 'PIEKARNIK ELEKTRYCZNY', 'PIEKARNIKI ELEKTRYCZNE DO Pizzerii DWUKOMOROWE STEROWANIE ELEKTROMECHANICZNE', 2400, 134, 'Sprzet do pracy', 0),
(160, 'A-10 ', 'Symetrycznie skonstruowane wzmacniacze A-10 z Direct Energy Design zapewniaja pierwszorzedny, wysokiej jakosci dzwiek, okryty dyskretna techniczna elegancja.\r\n\r\nPanel przedni wyposazony jest w pokretla do regulacji glosnosci, tonow niskich/wysokich/balansu oraz wyboru zrodel wejsciowych. Dotykowe przyciski umozliwiaja precyzyjne dostrojenie natezenia dzwieku, trybu bezposredniego i glosnika A/B. Z drugiej strony tylny panel umozliwia natychmiastowe podlaczenie urzadzen „Source Direct Mode”, Aux-In, sieci, rejestratora i glosnikow A + B.\r\n', 201.54, 140, 'Audio/Video', 0),
(161, 'Robot sprzatajacy 2713 Ariete', '- Czas trwania cyklu czyszczenia 110 minut,\r\n-Czas ladowania: 3 godziny,\r\n- Program AUTO: losowe ruchy okrezne / zygzakowate / dlugie sciany,\r\n- Pojemnosc zbiornika 0,3 litra,\r\n-Akcesoria: 2 dodatkowe szczotki boczne, 1 szczotka do czyszczenia, 1 dodatkowy filtr hepa', 139.9, 141, 'Urzadzenia domowe', 0),
(168, 'BOSE\r\nUB-20 II Uchwyt scienny / sufitowy', 'Wspornik scienny/sufitowy - Wysokiej jakosci odlew cynkowy - Przeznaczony do montazu na scianie glosnikow Bose cube - Umozliwia regulacje glosnikow w pionie i poziomie - Kompatybilny ze wszystkimi systemami rozrywki domowej Bose 2 i 5', 33.76, 148, 'Audio/Video', 0),
(177, 'Etui PURO - Cover Crystal iPhone 6 - Comp', 'Etui Crystal, stworzone dla iPhone’a 6 4,7”, charakteryzuje sie przezroczysta tylna obudowa, ktora pozwala zachowac ultra smukly profil, pozostawiajac niezmieniony design Apple, jednoczesnie gwarantujac calkowita ochrone przed zarysowaniami. Odporna, elegancka i z minimalistycznym stylem, idealnie przylega do ksztaltow urzadzenia.', 13.9, 158, 'Smartphony', 0),
(183, 'ASUS GeForce GTX 1080 Ti 11GB GDDR5X Pci-E 2 ', 'Karta graficzna Asus GeForce GTX 1080 Ti STRIX to najpotezniejszy i najwydajniejszy sprzet do gier z 3584 rdzeniami NVIDIA CUDA, ktory jest do 35% szybszy niz GeForce GTX 1080 i jest jeszcze szybszy w grach niz NVIDIA TITAN X. Karta cechuje sie bardzo szybka pamiecia GDDR5X 11 Gb/s z buforem ramki 11 GB. GTX 1080 Ti STRIX zostal specjalnie zaprojektowany, aby oferowac okreslone funkcje dla swiata gier. Dzieki wiekszej mocy obliczeniowej jest w stanie zaoferowac nowe doznania w VR, uzyskujac wyniki uznawane do tej pory za nieosiagalne. GPU Tweak', 919.99, 1, 'IT', 0),
(184, 'Telefon NOKIA 3310 new 2017', 'Nokia 3310 powraca! Tak, od historycznej marki NOKIA, ktora na przelomie lat 2000, zmonopolizowala swiat telefonii komorkowej. Wraca telefon komorkowy, ktory byl praktycznie w kazdej kieszeni! Nokia 3310. Podstawowe funkcje techniczne, ale najwyzsza praktycznosc, zaden smartfon nie gwarantuje 22 godzin rozmow i 30 dni czuwania !!!', 35, 1, 'Smartphony', 0),
(190, 'Zestaw sluchawkowy Nokia bluetooth bh 105', 'Prosty, ale elegancki', 15, 171, 'Audio/Video', 0),
(194, 'ACER - Monitor K2 - K222HQLbd', 'Wyjatkowe przedstawienie.\r\nBedziesz mogl wykonywac swoje czynnosci w najlepszy mozliwy sposob i w pelni cieszyc sie chwilami wypoczynku, dzieki podswietlanemu LED wyswietlaczowi. Szczegoly beda jeszcze wyrazniejsze w rozdzielczosci Full HD. Doskonala wizualizacja jest dodatkowo wzmocniona jasnymi kolorami dzieki Acer Adaptive Contrast Management.', 99.99, 175, 'IT', 0),
(204, 'Rower Rider', 'Typ z podwojna amortyzacja. Stalowa rama tig. Stalowy mechanizm korbowy, widelec i piasty, aluminiowe kola. Rozmiar 26'' - kolor zielony/zolty. Hamulce typu V-Brake. 18 Predkosc.\r\nDostepna w kolorach: Czerwony / Czarny.', 139, 187, 'Rowery', 0),
(216, 'EKO RANGER 6 BROWN SUNBURST', 'Ranger to z pewnoscia slowo, ktore najbardziej rozbrzmiewa w historii Eko i ktore pomoglo jej ugruntowac pozycje marki na poziomie europejskim. Urodzona pod nazwa J-52 ta gitara jest aktualizowana i ulepszana za kazdym razem do wersji J-54 (6 strun) i J-56 (12 strun), ktore w 1967 roku zostaly nazwane odpowiednio Ranger VI i Ranger XII. Slynace z doskonalego stosunku jakosci do ceny i niezniszczalnosci, do dzis sa obecne w domach wielu gitarzystow, byc moze w kacie salonu jako mebel.\r\n\r\nTa wersja ma klasyczny ksztalt Dre', 79, 201, 'Instrumenty muzyczne', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(600) DEFAULT NULL,
  `id_product` int(11) NOT NULL,
  `id_creator` int(11) NOT NULL,
  `date_creation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `reviews`
--

INSERT INTO `reviews` (`id`, `rate`, `name`, `description`, `id_product`, `id_creator`, `date_creation`) VALUES
(1, 5, 'Marta', 'Ladny telefon', 1, 1, '2021-02-05 15:35:37'),
(2, 4, 'Mikolaj', 'Swietny telefon', 1, 1, '2021-05-05 15:35:37'),
(3, 4, 'Mariusz', 'Piekna gitara', 5, 1, '2017-01-05 15:35:37'),
(4, 2, 'Mario', 'Cena za wysoka', 5, 1, '2021-06-05 16:12:37'),
(5, 5, 'Lucja', 'Bardzo wygodny', 17, 1, '2020-02-04 17:45:37'),
(7, 5, 'Mateusz', 'Bardzo ladny', 23, 1, '2021-03-09 22:45:37'),
(9, 3, 'Marta', 'OK', 23, 1, '2021-03-30 13:15:56'),
(10, 4, 'Mikolaj', 'Dobry produkt', 27, 1, '2021-03-03 11:21:37'),
(12, 3, 'Antoni', 'Produkt mogl byc lepszy', 2, 1, '2010-10-10 08:35:37'),
(13, 4, 'Janusz', 'Dobra gitara', 7, 1, '2021-05-13 17:56:45'),
(14, 1, 'Alex', 'Zly zestaw sluchawkowy', 18, 1, '2019-07-25 12:46:37'),
(15, 5, 'Alex', 'Optymalny', 21, 1, '2020-08-12 23:26:37'),
(16, 4, 'Maria', 'Bardzo ?adny', 21, 1, '2021-08-10 11:26:37'),
(17, 4, 'Jan', 'Dobry telefon', 2, 1, '2021-08-03 15:35:37'),
(18, 5, 'Maria', 'Swietny telefon komórkowy', 3, 1, '2021-12-03 13:35:37'),
(19, 5, 'Martina', 'Bardzo ?adny', 3, 1, '2021-08-03 13:35:37'),
(20, 5, 'Karol', 'Optymalny', 4, 1, '2021-08-03 15:35:37'),
(21, 1, 'Pawel', 'Dobry telefon', 4, 1, '2021-08-03 15:35:37'),
(22, 4, 'Paula', 'Pracuje bardzo dobrze', 6, 1, '2018-04-03 15:25:21'),
(23, 4, 'Stefan', 'Ok', 8, 1, '2021-07-15 15:35:58'),
(32, 3, 'Dawid', 'Nawet ok', 19, 1, '2021-08-03 15:35:37'),
(33, 5, 'Tadeusz', 'Zarabiste', 24, 1, '2021-08-03 15:35:37'),
(34, 3, 'Marta', 'Przecietny', 24, 1, '2021-08-03 15:35:37'),
(35, 3, 'Mateusz', 'Za drogie', 25, 1, '2022-01-17 13:09:37'),
(36, 5, 'Paola', 'Dobry telewizor\r\n', 25, 1, '2022-01-17 13:09:38'),
(37, 4, 'Valentina', 'Dobry', 25, 1, '2022-01-17 13:09:38'),
(38, 4, 'Krystyna', 'Ok, ale nie bardzo dobry', 26, 1, '2022-01-17 13:09:37'),
(39, 4, 'Katarzyna', 'XD', 27, 1, '2022-01-17 13:09:37'),
(40, 2, 'Anna', 'Nie polecam', 19, 1, '2022-01-17 13:09:37'),
(57, 5, 'Maria', 'Bardzo dobry produkt', 37, 1, '2022-01-17 13:09:37'),
(58, 3, 'Iwona', 'Przecietne', 37, 1, '2022-01-17 13:09:37'),
(59, 5, 'Aleksanda', 'Przecietne', 38, 1, '2022-01-17 13:09:37'),
(60, 4, 'Ryszard', 'ok', 38, 1, '2022-01-17 13:09:37'),
(61, 5, 'David', 'BD', 39, 1, '2022-01-17 13:09:37'),
(62, 4, 'Martyna', 'Dobre, pomaranczowe', 39, 1, '2022-01-13 13:09:37'),
(67, 2, 'Mariusz', 'Fatalna jakosc', 43, 1, '2017-08-30 17:53:51'),
(68, 5, 'Mokebe', 'wyborne', 44, 1, '2022-01-17 13:09:37'),
(69, 4, 'Mariola', 'Dobre', 45, 1, '2022-01-17 13:09:37'),
(78, 5, 'Ola', 'Ok', 54, 1, '2022-01-17 13:09:37'),
(83, 2, 'Weronika', 'Malo funckjonalne', 59, 1, '2022-01-17 13:28:39'),
(85, 4, 'Maciej', 'Wygodne', 61, 1, '2022-01-17 13:29:37'),
(86, 4, 'Eliza', 'Dobre', 62, 1, '2022-01-17 13:19:37'),
(106, 4, 'Ula', 'Dobry \r\n', 82, 1, '2022-01-17 13:09:37'),
(107, 5, 'Elonora', 'Bardzo dobre', 83, 1, '2022-01-17 13:09:37'),
(108, 3, 'Sandra', 'Przecietny', 84, 1, '2022-01-17 13:09:37'),
(123, 5, 'Maria', 'Zarabisty', 99, 1, '2022-01-17 13:09:37'),
(135, 5, 'Julia', 'Za malo gwiazdek by oddac jak produkt jest dobry', 111, 1, '2022-01-17 13:22:59'),
(159, 5, 'Sara', 'jest git \r\n', 135, 1, '2022-01-17 13:19:43'),
(173, 4, 'Andrzej', 'GIT', 149, 1, '2022-01-17 13:19:21'),
(178, 4, 'Natalia', 'Nawet funkcjonalny produkt', 154, 1, '2021-02-05 15:35:37'),
(184, 4, 'Tadeusz', 'takie 4 z plusem', 160, 1, '2022-01-17 13:23:37');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `shops`
--

CREATE TABLE `shops` (
  `id` int(11) NOT NULL,
  `name` varchar(45) CHARACTER SET cp1250 COLLATE cp1250_polish_ci DEFAULT NULL,
  `description` varchar(600) CHARACTER SET cp1250 COLLATE cp1250_polish_ci DEFAULT NULL,
  `web_Site_Url` varchar(150) CHARACTER SET cp1250 COLLATE cp1250_polish_ci DEFAULT NULL,
  `address` varchar(200) CHARACTER SET cp1250 COLLATE cp1250_polish_ci DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `id_Owner` int(11) DEFAULT NULL,
  `id_Creator` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `shops`
--

INSERT INTO `shops` (`id`, `name`, `description`, `web_Site_Url`, `address`, `rate`, `id_Owner`, `id_Creator`) VALUES
(1, 'MediaMarkt Polska', 'Media Markt', 'http://www.mediamarkt.pl', 'Oporowska 8, 99-300 Kutno', 5, 9, 1),
(2, 'RTV EURO AGD', 'AGD, RTV, IT', 'https://www.euro.com.pl/', 'Żwirki i Wigury 2, 99-300 Kutno', 5, 6, 1),
(3, 'Musicsklep.pl', 'Sklep muzyczny', 'https://Musicsklep.pl', 'Łęczycka 60a, 99-300 Kutno', 0, 8, 1),
(10, 'Empik Games', 'Kupuj online i korzystaj z ofert na najlepsze nowe i uzywane gry wideo na Nintendo 3DS, Switch, PS3, PS4, Xbox ...', 'https://www.empik.pl', 'Galeria Różana, Tadeusza Kościuszki 73, 99-300 Łódź', 5, 6, 1),
(12, 'Salon Samochodów Używanych Dudki 11', 'Dealer Porsche, Audi, Volkswagen, SKODA, SEAT Samochody nowe i uzywane. Samochody uzytkowe i warsztat Volkswagena!', 'http://www.dudki11.pl/', '99-300 Leszczynek', 3, 9, 1),
(19, 'Netstar s.c. A.J. Malinowscy', 'Sklep z telefonami komorkowymi i sprzetem IT. Dostawca intenetu', 'https://netstar.pl', 'Plac Wolności 21, 99-300 Kutno', 1, 6, 6),
(25, 'Neonet', 'Sklep elektroniczny', 'https://neonet.pl', 'Żwirki i Wigury 4, 99-300 Kutno', 2, 6, 6),
(27, 'Media Ekspert', 'Sklep elektroniczny ', 'https://mediaekspert.pl', 'Tadeusza Kościuszki 73, 99-300 Kutno', 4, 6, 6),
(28, 'Alsen', 'Siec sprzedazy nowych i uzywanych gier wideo, konsol, kontrolerow i akcesoriow.', 'https://www.alsen.pl/', 'Plac Marszałka Józefa Piłsudskiego 1, 99-300 Kutno', 5, 6, 6),
(29, 'Muzycznykomis.pl', 'Sklep muzyczny ', 'https://www.muzycznykomis.pl/', 'Łęczycka 60a, 99-300 Kutno', 1, 6, 6),
(52, 'Kakto Sklep AGD RTV Kutno', 'Sklep RTV AGD', 'https://www.kakto.pl/', 'Norberta Barlickiego 27, 99-300 Kutno', 4, 7, 7),
(53, 'Salon Play ', 'Sklep z telefonami komorkowymi', 'http://www.play.pl/', 'Królewska 4, 99-300 Kutno', 5, 7, 7),
(54, 'Gastrostar Jerzy Malinowski', 'Dostawca uslug internetowych', 'http://www.gastrostar.pl/', 'Plac Wolności 22, 99-300 Kutno', 1, 7, 7),
(65, 'MPC Paweł Oleksiewicz', 'Sklep RTV AGD IT', 'http://www.grupampc.pl/', 'Zygmunta Noskowskiego 1, 99-300 Kutno', 2, 6, 6),
(70, 'Mobisoft – Sklep z grami i konsolami', 'Siec sprzedazy nowych i uzywanych gier wideo, konsol, kontrolerow i akcesoriow.', 'https://mobisoft.com.pl/', 'al. Marszałka Józefa Piłsudskiego 45, 90-307 Łódź', 2, 6, 6),
(71, 'PHU Przyloga', 'Sklep i serwis komputerowy i IT', 'http://przyloga.pl/', 'http://przyloga.pl/', 3, 6, 6),
(85, 'Polonica. Biernaciak-Kmieciak D.', 'Ksiegarnia', 'http://kutno.pl', 'Podrzeczna 7, 99-300 Kutno', 2, 7, 7),
(104, 'Domer AGD', 'Sklep elektroniczny', 'https://kominki.domer.com.pl/', 'Warszawskie Przedmieście 16, 99-300 Kutno', 1, 7, 7),
(111, 'x-kom', 'Sklep elektroniczny', 'http://www.x-kom.pl/', 'al. Marszałka Józefa Piłsudskiego 15/23, 90-307 Łódź', 3, 6, 6),
(115, 'Komputronik', 'Sklep elektroniczny', 'https://www.komputronik.pl/', 'Towarowa 22, 00-839 Warszawa', 2, 6, 6),
(127, 'Metro. Sklep muzyczny', 'Sklep z instrumentami muzycznymi', 'http://muzycznymetro.pl/', 'Stacja Metro Centrum, plac Defilad 1/2001B, 00-110 Warszawa', 4, 6, 6),
(134, 'Vonart', 'Producent mebli do sklepow i supermarketow', 'https://www.vonart.com.pl/', '53-609 Wrocław, ul.Fabryczna 10', 1, 6, 6),
(140, 'iSpot', 'Dealer autoryzowany APPLE', 'http://ispot.pl/', 'Ostrobramska 75C, 04-175 Warszawa', 2, 6, 6),
(141, 'Zabka', 'Sklep spozywczy', 'https://www.zabka.pl/', 'Norberta Barlickiego 19, 99-300 Kutno', 3, 7, 7),
(148, 'Centrum Agd Rtv Firma Handlowa Bartek', 'Sklep elektroniczny', 'https://www.kakto.pl/market/sklep-agd-i-rtv-kutno-siec-kakto-bartek', 'Norberta Barlickiego 27, 99-300 Kutno', 5, 7, 7),
(158, 'Foton. PH.', 'Sklep komputerowy', 'http://www.foton.kutno.pl/', 'Plac Wolności 20, 99-300 Kutno', 5, 6, 6),
(171, 'Domex Lodz', 'Sklep elektroniczny', 'https://www.opendi.pl/lodz/282052.html', 'gen. Jaroslawa Dabrowskiego 50\r\n93-208  Lodz', 3, 6, 6),
(175, 'RTV AGD MARKET Marcin Pietrzykowski', 'Sklep AGD', 'https://www.gowork.pl/opinie_czytaj,23557658', 'Zachodnia 10, 90-001 Lodz', 2, 6, 6),
(187, 'CCC', 'Sklep obuwniczy', 'https://ccc.eu/pl/?utm_source=google&utm_medium=mybusiness&utm_campaign=1725', 'Tadeusza Kościuszki 73, 99-300 Kutno', 4, 7, 7),
(201, 'Sklep Muzyczny Guitar Center', 'Sklep z instrumentami muzycznymi', 'https://guitarcenter.pl/', 'Gdanska 54, 90-612 Lodz', 3, 7, 7);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(45) NOT NULL,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL DEFAULT 'registrato',
  `password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`id`, `email`, `firstName`, `lastName`, `role`, `password`) VALUES
(1, 'maciej@testhub.com', 'Maciej', 'B', 'admin', 'admin'),
(2, 'andrzej@andrzej.pl', 'Andrzej', 'G', 'registered', 'a'),
(3, 'marek@marek.com', 'Marek', 'Marzec', 'registered', 'a'),
(4, 'mariuszH@gmail.com', 'Mariusz', 'Haler', 'registered', 'a'),
(5, 'pawelkowalczyk@gmail.com', 'Pawel', 'Kowalczyk', 'registered', 'a'),
(6, 'alexalex@gmail.com', 'Alex', 'Swat', 'salesperson', 'a'),
(7, 'antonio@sejm.gov', 'Antonio', 'M', 'salesperson', 'a'),
(8, 'lukaszwajda@gmail.com', 'Lukasz', 'Wajda', 'salesperson', 'a'),
(9, 'janusznowicki@wp.pl', 'Janusz', 'Nowicki', 'salesperson', 'a'),
(10, 'KatarzynaW@onet.pl', 'Katarzyna', 'Waskiewicz', 'registered', 'a'),
(11, 'ronniee@ronnie.com', 'Ronnie', 'Ferrari', 'registered', 'a'),
(12, 'goaskalice@wykop.pl', 'Alicja', 'Sitko', 'registered', 'a'),
(13, 'arianna@arianka.com', 'Arianna', 'Grande', 'registered', 'a'),
(14, 'KarolD@o2.pl', 'Karol', 'Dominik', 'registered', 'a'),
(15, 'ccarla@elite.com', 'Carla', 'Caleruega', 'registered', 'a'),
(16, 'elizad@gmail.com', 'Eliza', 'Drzewo', 'registered', 'a'),
(17, 'krystyna@tvp.pl', 'Krystyna', 'Czubuwna', 'salesperson', 'a'),
(18, 'DawidG@wp.pl', 'Dawid', 'Goliat', 'registered', 'a'),
(19, 'elizaK@interia.pl', 'Elisa', 'Kasztanowa', 'salesperson', 'a'),
(20, 'francesca@witcher.com', 'Francesca', 'Findabair', 'registered', 'a'),
(21, 'FC@Costaconcordia.com', 'Francesco', 'Schettini', 'registered', 'a'),
(22, 'ZodiakCK@gmail.com', 'Michal', 'Domzal', 'registered', 'a');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users_pictures`
--

CREATE TABLE `users_pictures` (
  `id` int(11) NOT NULL,
  `name` varchar(90) NOT NULL,
  `id_Product` int(11) NOT NULL,
  `id_Owner` int(11) NOT NULL,
  `nameOwner` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `users_pictures`
--

INSERT INTO `users_pictures` (`id`, `name`, `id_Product`, `id_Owner`, `nameOwner`) VALUES
(6, 'idUser=9_fotoprova.png', 54, 9, 'User 9');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idBuyerOrders_idx` (`idBuyer`);

--
-- Indexes for table `order_products`
--
ALTER TABLE `order_products`
  ADD PRIMARY KEY (`orderid`,`productid`),
  ADD KEY `productid_idx` (`productid`);

--
-- Indexes for table `pictures`
--
ALTER TABLE `pictures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_product_pictures_idx` (`id_Product`),
  ADD KEY `id_product_owner_idx` (`id_Owner`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_shop_idx` (`id_shop`),
  ADD KEY `id_shop_products` (`id_shop`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCreatorReviews_idx` (`id_creator`),
  ADD KEY `idProductReviews_idx` (`id_product`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_Owner_idx` (`id_Owner`),
  ADD KEY `id_Creator_idx` (`id_Creator`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username_UNIQUE` (`email`);

--
-- Indexes for table `users_pictures`
--
ALTER TABLE `users_pictures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `UsersPictutresidProduct_idx` (`id_Product`),
  ADD KEY `UsersPictutresidProduct_idx1` (`id_Owner`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT dla tabeli `pictures`
--
ALTER TABLE `pictures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;
--
-- AUTO_INCREMENT dla tabeli `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;
--
-- AUTO_INCREMENT dla tabeli `shops`
--
ALTER TABLE `shops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=202;
--
-- AUTO_INCREMENT dla tabeli `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT dla tabeli `users_pictures`
--
ALTER TABLE `users_pictures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `idBuyerOrders` FOREIGN KEY (`idBuyer`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `order_products`
--
ALTER TABLE `order_products`
  ADD CONSTRAINT `orderid` FOREIGN KEY (`orderid`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `productid` FOREIGN KEY (`productid`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
