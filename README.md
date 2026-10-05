# Tesi di laurea triennale - Roberto Mariano Doroftei

<p align="center">
  <img src="img/logo_unipd.jpeg" alt="Logo dell'Università degli Studi di Padova" width="180">
</p>

**Titolo:** Interfaccia UI per dispositivi ESP32 per la visualizzazione di informazioni in tempo reale

**Autore:** Roberto Mariano Doroftei

**Relatore:** Prof. Zanella Marco

## Compilazione

Installa [Typst](https://typst.app/) e dalla radice della repo esegui:

```sh
typst compile --root . src/main.typ tesi.pdf
```

Il PDF generato non viene versionato; il template di esempio in `template/` è mantenuto.

## Pubblicazione online

Ogni push su `main` compila la tesi e pubblica automaticamente il PDF con GitHub Pages. Dopo la prima pubblicazione, il relatore può aprirlo sempre allo stesso indirizzo:

```text
https://<utente>.github.io/<repository>/tesi.pdf
```

Per attivare la pubblicazione la prima volta, nelle impostazioni del repository seleziona **Settings → Pages → Build and deployment → Source → GitHub Actions**. Le pull request continuano a verificare la compilazione, ma non pubblicano il PDF.

## Struttura

- `src/main.typ`: impostazioni, frontespizio, sommario e indice; include i capitoli.
- `src/chapters/`: un file Typst per capitolo, inclusa la bibliografia.
- `img/`: immagini utilizzate dalla tesi.
- `template/`: template PDF di riferimento.
- `.github/workflows/build.yml`: compilazione automatica a ogni push e pull request e pubblicazione del PDF su GitHub Pages a ogni push su `main`.

`main` contiene la tesi completa e compilabile. Usa branch brevi per le modifiche trasversali e non un branch distinto per ogni capitolo.
