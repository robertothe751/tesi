#import "shared.typ": *


#pagebreak()
= Analisi dei requisiti <analisi-requisiti>
\ 
Il presente capitolo è dedicato all'analisi dei requisiti del sistema, attività essenziale per definire gli obiettivi funzionali e i vincoli progettuali della soluzione. Vengono illustrati gli attori coinvolti, i casi d'uso e i requisiti funzionali e non funzionali individuati durante la fase di studio. Le informazioni raccolte costituiscono il punto di partenza per le successive attività di progettazione e implementazione del sistema.
\
== Analisi degli utenti
\
Il sistema sviluppato nel contesto dello stage consiste in un dispositivo basato su ESP32, dotato di display e integrato con il CRM RelAi. Il suo scopo è mostrare in tempo reale informazioni relative a organizzazioni ed eventi, quali codici QR, contatori degli iscritti e dei partecipanti, prenotazioni e dati di stato del dispositivo.
\
L'utilizzo del sistema coinvolge un unico attore principale, identificato nell'utente dell'organizzazione cliente presso la quale il dispositivo viene installato. Tale soggetto è responsabile della configurazione iniziale del pannello, che comprende il collegamento alla rete Wi-Fi, l'associazione al CRM RelAi e la gestione delle principali impostazioni operative del dispositivo.
\
Una volta completata la fase di configurazione, l'utente interagisce con il sistema principalmente attraverso la consultazione delle informazioni visualizzate sul display. Pur essendo pensato per un utilizzo semplice e immediato, il dispositivo mette inoltre a disposizione strumenti di supporto alla manutenzione e alla diagnostica, utili per verificare lo stato della connessione, la corretta sincronizzazione dei dati e il funzionamento generale del sistema.
\
Poiché il progetto è destinato a contesti operativi nei quali gli utilizzatori potrebbero non possedere particolari competenze tecniche, l'interfaccia e i flussi di interazione sono stati progettati privilegiando chiarezza, semplicità di utilizzo e rapidità delle operazioni di configurazione e gestione. Tale approccio consente di ridurre la complessità percepita e di facilitare l'adozione del dispositivo presso le organizzazioni clienti.
\
== Casi d'uso
Per lo studio dei casi di utilizzo del prodotto sono stati definiti i diagrammi e le relative specifiche funzionali. I diagrammi dei casi d'uso (_Use Case Diagram_) sono diagrammi di tipo _UML_ dedicati alla descrizione delle funzioni o servizi offerti dal sistema, così come sono percepiti dagli attori che interagiscono con esso.
\
=== Elenco dei casi d'uso
- 
*UC1* – Configurazione Wi‑Fi
- 
*UC1.1* – Nessuna rete disponibile
- 
*UC1.2* – Credenziali non valide
- 
*UC3* – Consultazione stato del dispositivo
- 
*UC4* – Condivisione Wi-Fi tramite QR Code
- 
*UC5* – Riavvio del dispositivo
- 
*UC6* – Reset di sistema
- 
*UC2* – Visualizzazione dei pannelli informativi a display
\
=== Trattazione dettagliata dei casi d'uso

#usecase(1, [Configurazione della connessione Wi‑Fi], [Utente / Installatore.], [
- Il dispositivo ESP32 è acceso e correttamente alimentato.
- Il Captive Portal è attivo.
- L'utente è connesso alla rete generata dal dispositivo.
- È disponibile almeno una rete Wi‑Fi nelle vicinanze.
*Trigger:* L'utente desidera configurare o aggiornare i parametri di accesso alla rete Wi‑Fi del dispositivo.
], [
1. L'utente si connette all'Access Point generato dal dispositivo.
2. Il sistema reindirizza automaticamente l'utente alla pagina di configurazione.
3. Il sistema esegue la scansione delle reti Wi‑Fi disponibili.
4. L'utente seleziona la rete desiderata.
5. L'utente inserisce la password della rete selezionata.
6. L'utente conferma la configurazione.
7. Il sistema verifica i dati ricevuti.
8. Il sistema salva le credenziali nella memoria persistente.
9. Il sistema effettua la connessione alla rete Wi‑Fi selezionata.
10. Il sistema conferma l'avvenuta configurazione.
], [
- Le credenziali della rete Wi‑Fi sono memorizzate nella memoria persistente del dispositivo.
- Il dispositivo risulta connesso alla rete selezionata.
- Il dispositivo è pronto per comunicare con le API del CRM RelAi.
]) <uc-config-wifi>
\
#usecase(1.1, [Nessuna rete disponibile], [Utente / Installatore.], [
- Il dispositivo è acceso.
- Il Captive Portal è attivo.
- L'utente è connesso all'Access Point del dispositivo.
*Trigger:* Avvio della scansione delle reti Wi‑Fi.
], [
1. L'utente accede alla pagina di configurazione Wi‑Fi.
2. Il sistema avvia la scansione delle reti disponibili.
3. La scansione non restituisce alcuna rete utilizzabile.
4. Il sistema mostra un messaggio informativo all'utente.
5. L'utente può richiedere una nuova scansione.
], [
- Nessuna configurazione Wi‑Fi viene salvata.
- Il Captive Portal rimane disponibile.
]) <uc-wifi-nessuna-rete>
\
#usecase(1.2, [Credenziali non valide], [Utente / Installatore.], [
- È stata selezionata una rete Wi‑Fi.
- Sono stati inseriti SSID e password.
*Trigger:* Tentativo di connessione a una rete Wi‑Fi.
], [
1. L'utente conferma la configurazione Wi‑Fi.
2. Il sistema tenta di connettersi alla rete selezionata.
3. La connessione fallisce.
4. Il sistema visualizza un messaggio di errore.
5. L'utente modifica i dati inseriti.
6. L'utente ripete la procedura di configurazione.
], [
- Nessuna connessione Wi‑Fi attiva.
- Nessuna credenziale errata viene utilizzata dal sistema.
- Il Captive Portal rimane disponibile.
]) <uc-wifi-credenziali-errate>
\
#usecase(3, [Consultazione stato del dispositivo], [Utente / Installatore.], [
- Il dispositivo ESP32 è acceso e correttamente avviato.
- L'interfaccia grafica e il menu di diagnostica sono accessibili.
*Trigger:* L'utente seleziona la voce "Stato Sistema" dal menu touch locale.
], [
1. L'utente apre il menu di diagnostica sul display.
2. L'utente seleziona l'opzione per la visualizzazione dello stato del sistema.
3. Il sistema interroga i moduli interni e recupera i parametri correnti (stato della rete Wi-Fi, SSID connesso, versione del firmware e tempo trascorso dall'ultima sincronizzazione).
4. Il sistema apre un riquadro modale a schermo mostrando le informazioni aggregate.
5. L'utente prende visione dello stato e chiude la finestra modale per tornare alla schermata principale.
], [
- L'utente è informato sullo stato di salute e connettività del dispositivo.
- Il sistema riprende la normale rotazione dei pannelli alla chiusura del modale.
]) <uc-consultazione-stato>
\
#usecase(4, [Condivisione Wi-Fi tramite QR Code], [Utente / Installatore.], [
- Il dispositivo ESP32 è acceso e connesso a una rete Wi-Fi.
- L'interfaccia grafica locale è attiva.
*Trigger:* L'utente seleziona la voce "QR Condivisione Rete" dal menu touch locale.
], [
1. L'utente accede al menu di diagnostica sul display.
2. L'utente seleziona l'opzione per la condivisione della rete Wi-Fi tramite QR Code.
3. Il sistema recupera l'SSID e la password della rete attiva.
4. Il sistema genera dinamicamente un codice QR formattato secondo lo standard di connessione Wi-Fi.
5. Il display mostra il codice QR consentendone la scansione da parte di un dispositivo esterno.
6. L'utente chiude il riquadro modale al termine dell'operazione.
], [
- Il codice QR risulta visibile a schermo con le credenziali correnti.
- Alla chiusura del modale, il sistema ripristina la visualizzazione operativa standard.
]) <uc-condivisione-wifi>
\
#usecase(5, [Riavvio del dispositivo], [Utente / Installatore.], [
- Il dispositivo ESP32 è acceso e funzionante.
- L'interfaccia grafica e il menu di diagnostica sono accessibili.
*Trigger:* L'utente seleziona la voce "Riavvio ESP32" dal menu touch locale.
], [
1. L'utente accede al menu di diagnostica sul display.
2. L'utente seleziona l'opzione per il riavvio del dispositivo.
3. Il sistema avvia un timer temporizzato per la chiusura delle attività in corso.
4. Il sistema esegue il comando software di riavvio del microcontrollore.
5. Il dispositivo si riavvia ricaricando il firmware e ripristinando le connessioni.
], [
- Il dispositivo viene riavviato pulitamente preservando le configurazioni e le preferenze salvate in memoria persistente.
]) <uc-riavvio-dispositivo>
\
#usecase(6, [Reset di sistema], [Utente / Installatore.], [
- Il dispositivo ESP32 è acceso e operativo.
- L'utente ha accesso al menu di diagnostica locale.
*Trigger:* L'utente seleziona la voce di reset ("Reset Wi-Fi" o "Reset ESP32") dal menu touch locale.
], [
1. L'utente accede al menu di diagnostica sul display.
2. L'utente seleziona l'opzione di reset o ripristino di fabbrica del sistema.
3. Il sistema avvia la procedura di cancellazione dei dati memorizzati nei namespace di configurazione presenti nella memoria flash.
4. Il sistema ripulisce le preferenze salvate e disconnette le interfacce di rete.
5. Il sistema esegue il riavvio automatico del dispositivo portandolo allo stato iniziale di fabbrica.
], [
- Tutte le preferenze e i dati memorizzati in precedenza risultano cancellati.
- Il dispositivo torna allo stato di configurazione iniziale con l'Access Point di provisioning attivo.
]) <uc-reset-sistema>
\
#usecase(2, [Visualizzazione dei pannelli informativi a display], [Utente / Installatore / Visore (Passivo).], [
- Il dispositivo ESP32 è alimentato e correttamente avviato.
- Il display e il sistema grafico LVGL sono inizializzati.
- Sono presenti dati validi in cache locale o ricevuti dalle API del CRM RelAi.
*Trigger:* Completamento dell'avvio del dispositivo o scadenza del timer di rotazione dei pannelli.
], [
1. Il sistema avvia la visualizzazione ciclica dei pannelli informativi basata su un timer di rotazione configurabile.
2. Ciascun pannello mostra a schermo i dati strutturati dell'evento (quali nome, ID, contatore delle prenotazioni e dei partecipanti).
3. Il sistema consente all'utente di consultare la tile associata contenente il codice QR dinamico di riferimento (es. per l'iscrizione o il check-in).
4. L'utente può interagire direttamente con l'interfaccia touch per scorrere manualmente i pannelli o mettere in pausa la rotazione automatica.
], [
- I dati aggiornati dell'evento risultano correttamente renderizzati e visibili a schermo.
- Il sistema mantiene la rotazione o lo stato di visualizzazione attivo in base alle preferenze dell'utente.
]) <uc-visualizzazione-display>