# Langer Dystrybucja — strona firmowa

Strona internetowa hurtowej dystrybucji chemii budowlanej. Jeden plik HTML — bez build'a, bez konfiguracji, gotowy do wgrania gdziekolwiek.

**Live:** wdrażane przez Vercel (zobacz sekcję [Wdrożenie](#wdrożenie))

---

## Spis treści

- [Jak to działa](#jak-to-działa)
- [Paleta kolorów](#paleta-kolorów)
- [Edycja danych kontaktowych](#edycja-danych-kontaktowych)
- [Dodawanie nowych produktów](#dodawanie-nowych-produktów)
- [Zmiana statystyk w hero](#zmiana-statystyk-w-hero)
- [Wdrożenie na Vercel](#wdrożenie)
- [Struktura plików](#struktura-plików)

---

## Jak to działa

Cała strona to **jeden plik** — `index.html`. Wszystko jest w środku:

- Style CSS (paleta kolorów, layout, animacje)
- Logika React (komponenty, wyszukiwarka produktów, filtry, formularz)
- Ikony SVG (kategorie produktów, sygnet marki)
- Dane produktów (lista, marki, kategorie)

React i Babel ładują się z CDN (unpkg) — nie trzeba nic kompilować.

**Folder `project/`** zawiera oryginalne pliki źródłowe rozbite na osobne pliki — jako referencja i archiwum. Strona ich nie używa; działa wyłącznie na `index.html`.

---

## Paleta kolorów

Z brand booka Langer. Żeby zmienić jakikolwiek kolor — edytuj sekcję `:root` w `index.html` (na początku znacznika `<style>`).

| Zmienna CSS | Hex | Co to jest |
|---|---|---|
| `--flame` | `#F04E23` | **Pomarańcz Langer** — główny akcent, przyciski CTA, podkreślenia |
| `--flame-600` | `#D63F18` | Pomarańcz, hover na przyciskach |
| `--flame-700` | `#B63411` | Pomarańcz, stan wciśnięcia |
| `--flame-tint` | `#FBE7DF` | Pomarańcz, jasne tło ikon |
| `--cobalt` | `#1E3FB5` | **Kobalt** — odznaka „Marka własna" |
| `--navy` | `#0E1533` | **Granat** — tło sekcji „Proces dystrybucji", tekst nagłówków |
| `--navy-900` | `#080C22` | Granat głęboki — pasek marek, stopka |
| `--ash-700` | `#565D67` | Szary — tekst drugorzędny, opisy |
| `--light` | `#EEF0F3` | Jasnoszary — tło bazy produktów |

**Najszybsza zmiana akcentu:** podmień `#F04E23` na inny kolor w linii `--flame: #F04E23;` — automatycznie zmieni się na wszystkich przyciskach, odznakach i podkreśleniach.

---

## Edycja danych kontaktowych

Wszystkie miejsca z danymi kontaktowymi w `index.html` — wyszukaj poniższe (Ctrl+F):

| Co | Co zmienić |
|---|---|
| `+48 000 000 000` | Numer telefonu (3 miejsca: header, stopka, sekcja kontakt) |
| `biuro@langerdystrybucja.pl` | E-mail (2 miejsca: kontakt, stopka) |
| `ul. Przykładowa 00, 00-000 Miasto` | Adres magazynu (sekcja kontakt) |
| `ul. Przykładowa 00<br/>00-000 Miasto` | Adres w stopce |

---

## Dodawanie nowych produktów

Znajdź w `index.html` linię `const PRODUCTS = [` i dopisuj kolejne wiersze według tego wzoru:

```js
{
  sku:      'PU-LNG-100',                 // unikalny kod produktu
  name:     'Langer 100 PRO 750 ml',      // nazwa wyświetlana
  brand:    'Langer',                     // jedna z marek z listy BRANDS
  category: 'piany',                      // jedna z: piany | silikony | akryle | kleje | akcesoria
  variant:  'Pistoletowa · 750 ml',       // wariant / pojemność
  pack:     '12 szt. / karton',           // jednostka sprzedaży
  role:     'magnet',                     // magnet (Bestseller) | margin (Marka własna) | premium | neutral
  tags:     ['Pistoletowa', 'Całoroczna'] // tagi — wyświetlane jako pigułki
},
```

**Pole `role`** kontroluje jakie pojawi się oznaczenie na karcie:
- `magnet` → pomarańczowa odznaka **Bestseller**
- `margin` → niebieska odznaka **Marka własna**
- `premium` → granatowa odznaka **Premium**
- `neutral` → bez odznaki

**Dodanie nowej marki:** znajdź `const BRANDS = [` i dopisz nazwę. Pojawi się automatycznie jako filtr.

**Dodanie nowej kategorii:** wymaga dodania też ikony SVG do komponentu `CatIcon` — daj znać jak potrzebujesz, pomogę.

---

## Zmiana statystyk w hero

Znajdź w `index.html` linię `const stats = [` (wewnątrz `HeroStats`):

```js
const stats = [
  ['120+',   'produktów w ofercie'],
  ['6',      'marek, w tym Langer'],
  ['48 h',   'średni czas realizacji'],
  ['1 200+', 'zaopatrywanych punktów'],
];
```

Zmień liczby i opisy zgodnie ze swoją rzeczywistością.

---

## Wdrożenie

### Vercel (zalecane, darmowe)

1. Wejdź na **[vercel.com/new](https://vercel.com/new)** → zaloguj się przez GitHub
2. Wybierz repo `langer-dystrybucja` → kliknij **Deploy**
3. Po ~30 sekundach dostaniesz URL typu `langer-dystrybucja.vercel.app`

Od tej chwili każdy commit w repo → strona aktualizuje się automatycznie.

### Świeży projekt: baza Neon + zmienne środowiskowe

Strona i panele czytają produkty z bazy (`GET /api/products`), więc **na nowym
projekcie trzeba podłączyć bazę, inaczej lista produktów będzie pusta.**

1. **Baza:** w Vercelu **Storage → Create → Neon** (albo własny Neon) — Vercel sam
   doda zmienną **`DATABASE_URL`**.
2. **Tabele + dane startowe:** w Neon → **SQL Editor** wklej **całą zawartość
   `data/setup.sql`** i uruchom raz. Tworzy tabele `products` i `onboarding_cards`
   oraz wgrywa dane startowe (22 produkty + 26 kart Modułu 1). Plik jest bezpieczny
   do ponownego uruchomienia (nie duplikuje danych).
3. **Sekret admina:** w **Settings → Environment Variables** dodaj **`ADMIN_SECRET`**
   = dowolny długi losowy ciąg. To hasło do obu paneli (`/admin-langer/` i
   `/admin-langer/onboarding.html`). Po dodaniu zmiennych zrób **Redeploy**.

Po tym: strona pokazuje produkty, `/onboarding/` ciągnie karty z bazy, a treść
edytujesz w panelach. (Zamiast `setup.sql` możesz też uruchomić sam
`data/onboarding-schema.sql` i zaimportować karty przyciskiem w panelu onboardingu.)

### Własna domena

Po wdrożeniu w panelu Vercela: **Settings → Domains → Add** i podaj swoją domenę (np. `langerdystrybucja.pl`). Vercel pokaże jakie rekordy DNS ustawić u Twojego rejestratora.

---

## Platforma onboardingowa (dla pracowników)

Osobna aplikacja szkoleniowa pod adresem **`/onboarding/`** — wprowadza nowych
handlowców w firmę, produkty, segmenty i sposób sprzedaży. Plan: 5 modułów
(0 Kontekst → 1 Produkty → 2 Segmenty → 3 Rozmowy → 4 Zestawy).

**Status: Moduł 1 (Produkty) działa w pełni** — fiszki z obracaniem, system
„umiem / jeszcze raz" (postęp zapisywany w przeglądarce) oraz quiz generowany
z tych samych kart. Moduł 0 to treść do przeczytania; moduły 2–4 są oznaczone
„Wkrótce". Aplikacja ma wbudowany komplet kart (tryb demo), więc działa nawet
zanim podłączysz bazę.

**Treść w bazie + panel admina:**

1. **Schemat:** uruchom raz `data/onboarding-schema.sql` w konsoli Neon (SQL Editor) —
   tworzy tabelę `onboarding_cards`.
2. **Zasilenie startowe:** wejdź na **`/admin-langer/onboarding.html`** (login: ten sam
   `ADMIN_SECRET`), kliknij **„Zaimportuj startowy Moduł 1"** — wgra komplet kart z Vademecum.
3. **Edycja:** w panelu dodajesz / edytujesz / usuwasz karty. Jedna karta = jedna
   fiszka **i** jedno pytanie quizu (dystraktory losowane z pozostałych kart),
   więc utrzymujesz tylko jedno źródło treści.

API: `GET /api/onboarding/cards?module=1` (publiczne, czyta aplikacja) oraz
`POST/PUT/DELETE` (wymaga `Bearer ADMIN_SECRET`, jak panel produktów).

---

## Struktura plików

```
.
├── index.html              # ⭐ Strona firmowa (publiczna)
├── README.md               # Ten plik
├── onboarding/
│   └── index.html          # Aplikacja onboardingowa (fiszki + quiz)
├── admin-langer/
│   ├── index.html          # Panel admina — produkty
│   └── onboarding.html     # Panel admina — treść szkoleń (karty)
├── api/
│   ├── products.js         # API produktów (Neon)
│   ├── products/[sku].js
│   └── onboarding/
│       ├── cards.js        # API kart onboardingu (GET lista / POST)
│       └── cards/[id].js   # GET / PUT / DELETE pojedynczej karty
├── data/
│   ├── onboarding-schema.sql   # Schemat tabeli onboarding_cards (Neon)
│   ├── onboarding/module1.json # Treść startowa Modułu 1 (referencja)
│   └── products/*.json
└── project/                # Archiwum — oryginalne pliki źródłowe (rozbite)
    ├── brand.css           # Tokeny kolorów, fonty, spacing
    ├── site.css            # Style sekcji i komponentów
    ├── data.jsx            # Lista produktów, kategorii, marek
    ├── sections.jsx        # Header, logo, ikony
    ├── hero.jsx            # Hero (3 warianty), sekcje marketingowe
    ├── catalog.jsx         # Baza produktów z filtrami
    ├── app.jsx             # Główny komponent
    ├── tweaks-panel.jsx    # Panel do podglądu wariantów
    └── assets/icons/       # Ikony SVG kategorii
```

---

## Stack technologiczny

- **HTML** + **React 18** (UMD z CDN, bez build'a)
- **Babel Standalone** — kompiluje JSX w przeglądarce
- **Google Fonts** — Space Grotesk, Hanken Grotesk, JetBrains Mono
- **Vercel** — hosting statyczny
