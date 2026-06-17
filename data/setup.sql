-- =====================================================================
-- Langer Dystrybucja — pełny setup bazy (Neon / Postgres)
-- Wklej CAŁOŚĆ do Neon → SQL Editor i uruchom RAZ na nowym projekcie.
-- Tworzy tabele i wgrywa dane startowe (produkty + onboarding Moduł 1).
-- Bezpieczne do ponownego uruchomienia (IF NOT EXISTS + ON CONFLICT / brak duplikatów).
-- =====================================================================

-- ---------- TABELA 1: produkty (zasila stronę i /admin-langer/) ----------
CREATE TABLE IF NOT EXISTS products (
  sku        TEXT PRIMARY KEY,
  name       TEXT NOT NULL,
  brand      TEXT NOT NULL,
  category   TEXT NOT NULL,
  variant    TEXT,
  pack       TEXT,
  role       TEXT NOT NULL DEFAULT 'neutral',
  tags       TEXT[] NOT NULL DEFAULT '{}',
  image_url  TEXT
);

-- ---------- TABELA 2: karty onboardingu (fiszki + quiz) ----------
CREATE TABLE IF NOT EXISTS onboarding_cards (
  id          SERIAL PRIMARY KEY,
  module      INTEGER NOT NULL,
  topic       TEXT,
  front       TEXT NOT NULL,
  back        TEXT NOT NULL,
  tags        TEXT[] NOT NULL DEFAULT '{}',
  sort_order  INTEGER NOT NULL DEFAULT 0,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_onboarding_cards_module ON onboarding_cards (module, sort_order, id);

-- ---------- DANE: produkty (22) ----------
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('AC-SDL-CLN500','Czyścik do pian 500 ml','Soudal','akcesoria','Aerozol · 500 ml','12 szt. / karton','neutral',ARRAY['Czyścik'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('AC-SDL-GUN','Pistolet do pian Soudal Pro','Soudal','akcesoria','Metalowy · teflonowany','1 szt.','neutral',ARRAY['Pistolet'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('AK-DB-ROOF310','Den Braven Akryl dekarski 310 ml','Den Braven','akryle','Dekarski · 310 ml','24 szt. / karton','neutral',ARRAY['Dekarski','Zewnętrzny'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('AK-SDL-PAINT300','Soudal Akryl malarski 300 ml','Soudal','akryle','Malarski · 300 ml','24 szt. / karton','magnet',ARRAY['Malarski','Do przemalowania'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('KL-LNG-TUR-280','Klej montażowy Langer Tur 280 ml','Langer','kleje','Klej montażowy · 280 ml','25 szt. / karton','margin',ARRAY['Silne wiązanie','Uniwersalny','Trwałe połączenie'],'https://zapianowany.pl/environment/cache/images/productGfx_504_0_0/Klej-montazowy-Langer-Tur.webp') ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('KL-PEN-PU300','Penosil Klej PU 300 ml','Penosil','kleje','Poliuretanowy · 300 ml','12 szt. / karton','neutral',ARRAY['Poliuretanowy'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('KL-SDL-MAX290','Soudal Fix All High Tack 290 ml','Soudal','kleje','Hybrydowy · 290 ml','12 szt. / karton','premium',ARRAY['Hybrydowy','Mocne chwyty'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('KL-TYT-MS290','Tytan MS Polymer 290 ml','Tytan','kleje','Hybrydowy · 290 ml','12 szt. / karton','neutral',ARRAY['MS Polymer'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('PU-LNG-70-870','Piana montażowa Langer 70 870 ml','Langer','piany','Pistoletowa · 870 ml','12 szt. / karton','margin',ARRAY['Wydajność do 70 l','Sezon letni','Doskonała przyczepność'],'https://zapianowany.pl/environment/cache/images/productGfx_503_0_0/736a6deaa04386a82083b423c697f189.webp') ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('PU-LNG-70W-870','Piana montażowa Langer 70 zimowa -10°C 870 ml','Langer','piany','Pistoletowa · zimowa · 870 ml','12 szt. / karton','margin',ARRAY['Do -10°C','Wydajność do 70 l','Praca zimowa'],'https://zapianowany.pl/userdata/public/gfx/699/Pianka-zimowa-Langer-70--10.webp') ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('PU-LNG-ECO-760','Piana montażowa Langer Economy Line 760 ml','Langer','piany','Pistoletowa · 760 ml','12 szt. / karton','margin',ARRAY['Ekonomiczna','Uniwersalna','Łatwa aplikacja'],'https://zapianowany.pl/userdata/public/gfx/673/Piana-montazowa-Langer-Economy-Line.webp') ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('PU-LNG-EXP-760','Pianoklej Langer Express 60 sekund 760 ml','Langer','kleje','Pianoklej · pistoletowy · 760 ml','12 szt. / karton','margin',ARRAY['Wiązanie 60 s','Szybki montaż','Wysoka przyczepność'],'https://zapianowany.pl/userdata/public/gfx/510/Pianoklej-Langer-Express-60-sekund.webp') ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('PU-LNG-STP-760','Pianoklej Langer do styropianu 760 ml','Langer','kleje','Pianoklej do styropianu · 760 ml','12 szt. / karton','margin',ARRAY['Do styropianu','Mocne klejenie','Termoizolacja'],'https://zapianowany.pl/userdata/public/gfx/672/Langer-Pianoklej-do-styropianu.webp') ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('PU-PEN-GLD750','Penosil Gold Gun 750 ml','Penosil','piany','Pistoletowa · 750 ml','12 szt. / karton','neutral',ARRAY['Pistoletowa'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('PU-SDL-CL750','Soudal Classic 750 ml TURBOULTRA','Soudal','piany','Pistoletowa · 750 ml','12 szt. / karton','magnet',ARRAY['Pistoletowa','Całoroczna','Szybkoschnąca'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('PU-SDL-GUN870','Soudal Gun Foam 870 ml','Soudal','piany','Pistoletowa · 870 ml','12 szt. / karton','neutral',ARRAY['Pistoletowa','Wysoka wydajność'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('PU-TYT-O2750','Tytan O2 Professional 750 ml','Tytan','piany','Pistoletowa · 750 ml','12 szt. / karton','neutral',ARRAY['Pistoletowa'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('PU-TYT-WIN750','Tytan Zima 750 ml','Tytan','piany','Pistoletowa · 750 ml','12 szt. / karton','neutral',ARRAY['Zimowa','do −10°C'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('SI-DB-HT300','Den Braven High-Temp 300 ml','Den Braven','silikony','Wysokotemperaturowy · 300 ml','12 szt. / karton','premium',ARRAY['do 300°C','Kominkowy'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('SI-SDL-SAN300','Soudal Sanitary 300 ml','Soudal','silikony','Sanitarny · 300 ml','24 szt. / karton','magnet',ARRAY['Sanitarny','Grzybobójczy'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('SI-SDL-UNI300','Soudal Uniwersalny 300 ml','Soudal','silikony','Octowy · 300 ml','24 szt. / karton','neutral',ARRAY['Uniwersalny'],NULL) ON CONFLICT (sku) DO NOTHING;
INSERT INTO products (sku,name,brand,category,variant,pack,role,tags,image_url) VALUES ('SI-TYT-CON310','Tytan Budowlany 310 ml','Tytan','silikony','Octowy · 310 ml','24 szt. / karton','neutral',ARRAY['Budowlany'],NULL) ON CONFLICT (sku) DO NOTHING;

-- ---------- DANE: onboarding Moduł 1 (26 kart) ----------
-- (pomijane jeśli karty modułu 1 już są w bazie)
INSERT INTO onboarding_cards (module,topic,front,back,tags,sort_order)
SELECT * FROM (VALUES
  (1, 'Zasada sprzedaży', 'Którą markę proponujemy domyślnie tam, gdzie mamy kontakt z klientem?', 'Langer (marka własna) — ma wyższą marżę niż dystrybucja.', ARRAY['Strategia','Langer']::text[], 1),
  (1, 'Zasada sprzedaży', 'Jaka jest rola Soudala w sprzedaży?', 'Kotwica zaufania — znana marka dla tych, którzy nie chcą zmieniać.', ARRAY['Strategia','Soudal']::text[], 2),
  (1, 'Piana Langer 70', 'Piana Langer 70 — wydajność?', 'Do 70 l (standard to ~45 l).', ARRAY['Langer','Piany']::text[], 10),
  (1, 'Piana Langer 70', 'Piana Langer 70 — czas cięcia?', '15–30 min.', ARRAY['Langer','Piany']::text[], 11),
  (1, 'Piana Langer 70', 'Piana Langer 70 — główne zastosowanie?', 'Montaż ościeżnic okien i drzwi.', ARRAY['Langer','Piany']::text[], 12),
  (1, 'Piana Langer 70', 'Piana Langer 70 — czego się nie trzyma?', 'PE, PP, silikonu, teflonu, tłustych podłoży.', ARRAY['Langer','Piany']::text[], 13),
  (1, 'Langer Economy Line', 'Langer Economy — wydajność?', 'Do 45 l.', ARRAY['Langer','Piany']::text[], 20),
  (1, 'Langer Economy Line', 'Langer Economy — wzrost objętości?', '~30% — niskoprężna, bez odkształceń.', ARRAY['Langer','Piany']::text[], 21),
  (1, 'Langer Economy Line', 'Po co mamy Langer Economy?', 'Najtańsze wejście marki własnej — opcja dla patrzących na cenę.', ARRAY['Langer','Piany']::text[], 22),
  (1, 'Langer XL Fast', 'Langer XL Fast — czym różni się od Langer 70?', 'Szybsze wiązanie (~30 min), nastawiona na montaż stolarki.', ARRAY['Langer','Piany']::text[], 30),
  (1, 'Langer XL Fast', 'Langer XL Fast — wydajność?', 'Do 65 l.', ARRAY['Langer','Piany']::text[], 31),
  (1, 'Langer XL Fast', 'Langer XL Fast — kluczowa cecha przy ramach?', 'Niska rozszerzalność wtórna = minimalne naprężenia na ościeżnice.', ARRAY['Langer','Piany']::text[], 32),
  (1, 'Langer 70 Zimowa', 'Langer 70 Zimowa — kiedy oferujemy?', 'Sezonowo zimą, do montażu w mrozie do −10°C.', ARRAY['Langer','Piany','Sezon']::text[], 40),
  (1, 'Klej Langer Tur', 'Langer Tur — baza chemiczna?', 'MS Polimer.', ARRAY['Langer','Kleje']::text[], 50),
  (1, 'Klej Langer Tur', 'Langer Tur — chwyt początkowy?', 'Do 500 kg/m² — bez podpierania.', ARRAY['Langer','Kleje']::text[], 51),
  (1, 'Klej Langer Tur', 'Langer Tur — główna korzyść dla wykonawcy?', 'Koniec z podpieraniem = szybsza praca.', ARRAY['Langer','Kleje']::text[], 52),
  (1, 'Klej Langer Tur', 'Langer Tur — wytrzymałość końcowa?', '22 kg/cm².', ARRAY['Langer','Kleje']::text[], 53),
  (1, 'Pianoklej Langer Express 60s', 'Express 60s — po ilu sekundach start utwardzania?', '60 sekund.', ARRAY['Langer','Pianokleje']::text[], 60),
  (1, 'Pianoklej Langer Express 60s', 'Express 60s — czas na korektę?', '2 minuty.', ARRAY['Langer','Pianokleje']::text[], 61),
  (1, 'Pianoklej Langer Express 60s', 'Express 60s — max szerokość spoiny?', '30 mm.', ARRAY['Langer','Pianokleje']::text[], 62),
  (1, 'Pianoklej Langer do styropianu', 'Langer do styropianu — wydajność?', 'Do 10 m² z puszki.', ARRAY['Langer','Pianokleje']::text[], 70),
  (1, 'Pianoklej Langer do styropianu', 'Langer do styropianu — λ (lambda)?', '0,034 W/(m·K).', ARRAY['Langer','Pianokleje']::text[], 71),
  (1, 'Pianoklej Langer do styropianu', 'Langer do styropianu — do czego głównie?', 'Klejenie styropianu EPS na fasadach.', ARRAY['Langer','Pianokleje']::text[], 72),
  (1, 'Pistolet T400 PTFE', 'Pistolet T400 — dlaczego proponować przy piankach?', 'Kontrola aplikacji + oszczędność piany; naturalny dodatek do koszyka.', ARRAY['Akcesoria','Dosprzedaż']::text[], 80),
  (1, 'Soudal — piany', 'Które piany Soudal najwięcej schodzą w punktach?', 'Soudal Classic i Soudal Yellow.', ARRAY['Soudal','Piany']::text[], 90),
  (1, 'Distyk', 'Jak pozycjonujemy markę Distyk?', 'Tańsza alternatywa dla Soudala (silikony, akryle) — wyższa marża.', ARRAY['Distyk']::text[], 100)
) AS v(module,topic,front,back,tags,sort_order)
WHERE NOT EXISTS (SELECT 1 FROM onboarding_cards WHERE module = 1);
