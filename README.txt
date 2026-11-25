VIRGIN CITY – Neon-Konten + Cloud-Spielstände

Backend
- Datenbank: Neon Postgres (Projekt virgin-city, Region EU Central)
- Konten: Neon Managed Better Auth
- Spielstände: Neon Data API + PostgreSQL Row-Level Security
- Hosting: Vercel
- Kein Supabase, kein GitHub nötig.

Vercel Environment Variables (Production, Preview und Development)
NEON_AUTH_BASE_URL = https://…neonauth…/neondb/auth
NEON_DATA_API_URL = https://…apirest…/neondb/rest/v1

Diese beiden Variablen sind bereits im Vercel-Projekt virgin-city hinterlegt.
Die Werte sind öffentliche Endpunkt-URLs, keine Datenbankpasswörter. Es gibt keinen
Service-Role-Key im Browser. Die Datenbank schützt Spielstände mit RLS: Jeder Account
kann ausschließlich seine eigenen fünf Slots lesen, schreiben und löschen.

Projektdateien
- index.html: Virgin City mit Anmeldung, Registrierung, Cloud-Slots und Offline-Queue
- api/config.js: gibt die beiden öffentlichen Neon-Endpunkte aus Vercel Environment Variables aus
- database.sql: Schema und RLS-Regeln für game_saves
- vercel.json: Vercel Function-Konfiguration
- sw.js: Offline-App-Shell-Cache

Verhalten
- Konto erstellen und erstmalig anmelden benötigt Internet.
- Nach erfolgreicher Anmeldung wird die lokale Sitzung in IndexedDB zwischengespeichert.
- Danach lässt sich das Spiel mit dem bereits angemeldeten Browser auch offline starten.
- Offline-Spielstände und Löschvorgänge werden in IndexedDB vorgemerkt.
- Sobald Internet zurückkommt, werden alle fünf Slots automatisch synchronisiert.
- Die Cloud-Daten liegen serverseitig in Neon Postgres; RLS trennt die Benutzer.
- Alte Spielstände aus früheren LocalStorage-Schlüsseln werden nicht automatisch importiert.
- Grafik-/Steuerungseinstellungen bleiben lokal in localStorage.

Bereitstellung
1. Den Inhalt dieses Pakets in das Vercel-Projekt virgin-city übernehmen.
2. Neu deployen (Vercel-Dashboard: Deployments / Redeploy oder Dateien im Projekt aktualisieren).
3. Danach https://virgin-city.vercel.app öffnen und ein Konto erstellen.

Hinweis: Der Neon-Datenbankbereich, Neon Auth, Data API, die game_saves-Tabelle,
RLS-Regeln und die zwei Vercel Environment Variables sind bereits eingerichtet.
