-- Schemat tabel platformy onboardingowej (Neon / Postgres)
-- Uruchom raz w konsoli Neon (SQL Editor) zanim użyjesz panelu /admin-langer/onboarding.html
--
-- Model treści jest celowo prosty: JEDNA tabela kart wiedzy napędza
-- dwa tryby nauki w aplikacji — fiszki (front/back) ORAZ quiz
-- (pytanie = front, poprawna odpowiedź = back, dystraktory losowane z innych kart).
-- Dzięki temu redaktor utrzymuje tylko jedno źródło prawdy.

CREATE TABLE IF NOT EXISTS onboarding_cards (
  id          SERIAL PRIMARY KEY,
  module      INTEGER NOT NULL,                 -- numer modułu 0..4
  topic       TEXT,                             -- grupa, np. "Piana Langer 70"
  front       TEXT NOT NULL,                    -- przód fiszki / treść pytania
  back        TEXT NOT NULL,                    -- tył fiszki / poprawna odpowiedź
  tags        TEXT[] DEFAULT '{}',              -- np. {Langer, piany}
  sort_order  INTEGER NOT NULL DEFAULT 0,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_onboarding_cards_module ON onboarding_cards (module, sort_order, id);

-- Wygodne czyszczenie modułu przy ponownym imporcie z panelu:
-- DELETE FROM onboarding_cards WHERE module = 1;
