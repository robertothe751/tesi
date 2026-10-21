1 -> Lista generale dei casi d'uso:

    UC1 – Configurazione Wi‑Fi

        UC1.1 – Nessuna rete disponibile

        UC1.2 – Credenziali non valide

    

    ////fino a qua fatto

    UC3 – Consultazione stato del dispositivo

    UC4 – Condivisione Wi-Fi tramite QR Code

    UC5 – Riavvio del dispositivo

    UC6 - Reset di sistema

    UC2 – Visualizzazione dei pannelli informativi a display


2 -> Trattazione dettagliata dei casi d'uso:

UC1 - Configurazione della connessione Wi‑Fi

Attore principale:
Utente / Installatore.

Descrizione:
Il caso d'uso consente all'utente di configurare la connessione Wi‑Fi del dispositivo mediante una pagina web accessibile tramite Captive Portal. Al termine della procedura, il dispositivo memorizza le credenziali ed effettua la connessione alla rete selezionata.

Precondizioni:

    Il dispositivo ESP32 è acceso e correttamente alimentato.

    Il Captive Portal è attivo.

    L'utente è connesso alla rete generata dal dispositivo.

    È disponibile almeno una rete Wi‑Fi nelle vicinanze.

Scenario principale:

    L'utente si connette all'Access Point generato dal dispositivo.

    Il sistema reindirizza automaticamente l'utente alla pagina di configurazione.

    Il sistema esegue la scansione delle reti Wi‑Fi disponibili.

    L'utente seleziona la rete desiderata.

    L'utente inserisce la password della rete selezionata.

    L'utente conferma la configurazione.

    Il sistema verifica i dati ricevuti.

    Il sistema salva le credenziali nella memoria persistente.

    Il sistema effettua la connessione alla rete Wi‑Fi selezionata.

    Il sistema conferma l'avvenuta configurazione.

Postcondizioni:

    Le credenziali della rete Wi‑Fi sono memorizzate nella memoria persistente del dispositivo.

    Il dispositivo risulta connesso alla rete selezionata.

    Il dispositivo è pronto per comunicare con le API del CRM RelAi.

Scenari alternativi:

a. Nessuna rete disponibile

    La scansione non restituisce alcuna rete.

    Il sistema informa l'utente dell'impossibilità di completare l'operazione.

    L'utente può ripetere una nuova scansione.

b. Credenziali non valide

    Il tentativo di connessione fallisce.

    Il sistema visualizza un messaggio di errore.

    Il Captive Portal rimane attivo.

    L'utente può modificare i parametri inseriti e ripetere la procedura.

Trigger:
L'utente desidera configurare o aggiornare i parametri di accesso alla rete Wi‑Fi del dispositivo.

UC1.1 - Nessuna rete disponibile

Attore principale:
Utente / Installatore.

Descrizione:
Caso d'uso alternativo che si verifica quando il dispositivo non rileva alcuna rete Wi‑Fi disponibile durante la fase di scansione.

Precondizioni:

    Il dispositivo è acceso.

    Il Captive Portal è attivo.

    L'utente è connesso all'Access Point del dispositivo.

Scenario principale:

    L'utente accede alla pagina di configurazione Wi‑Fi.

    Il sistema avvia la scansione delle reti disponibili.

    La scansione non restituisce alcuna rete utilizzabile.

    Il sistema mostra un messaggio informativo all'utente.

    L'utente può richiedere una nuova scansione.

Postcondizioni:

    Nessuna configurazione Wi‑Fi viene salvata.

    Il Captive Portal rimane disponibile.

Trigger:
Avvio della scansione delle reti Wi‑Fi.

UC1.2 - Credenziali non valide

Attore principale:
Utente / Installatore.

Descrizione:
Caso d'uso alternativo che si verifica quando le credenziali inserite non consentono il collegamento alla rete selezionata.

Precondizioni:

    È stata selezionata una rete Wi‑Fi.

    Sono stati inseriti SSID e password.

Scenario principale:

    L'utente conferma la configurazione Wi‑Fi.

    Il sistema tenta di connettersi alla rete selezionata.

    La connessione fallisce.

    Il sistema visualizza un messaggio di errore.

    L'utente modifica i dati inseriti.

    L'utente ripete la procedura di configurazione.

Postcondizioni:

    Nessuna connessione Wi‑Fi attiva.

    Nessuna credenziale errata viene utilizzata dal sistema.

    Il Captive Portal rimane disponibile.

Trigger:
Tentativo di connessione a una rete Wi‑Fi.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

UC2 - Visualizzazione dei pannelli informativi a display

Attore principale:
Utente / Installatore / Visore (Passivo).

Descrizione:
Il caso d'uso descrive la modalità con cui il dispositivo gestisce la presentazione visiva delle informazioni relative agli eventi aziendali sincronizzati dal CRM RelAi. Il sistema mostra in modo sequenziale i pannelli configurati, alternando i contenuti tramite rotazione automatica o navigazione manuale.

Precondizioni:

    Il dispositivo ESP32 è alimentato e correttamente avviato.

    Il display e il sistema grafico LVGL sono inizializzati.

    Sono presenti dati validi in cache locale o ricevuti dalle API del CRM RelAi.

Scenario principale:

    Il sistema avvia la visualizzazione ciclica dei pannelli informativi basata su un timer di rotazione configurabile.

    Ciascun pannello mostra a schermo i dati strutturati dell'evento (quali nome, ID, contatore delle prenotazioni e dei partecipanti).

    Il sistema consente all'utente di consultare la tile associata contenente il codice QR dinamico di riferimento (es. per l'iscrizione o il check-in).

    L'utente può interagire direttamente con l'interfaccia touch per scorrere manualmente i pannelli o mettere in pausa la rotazione automatica.

Postcondizioni:

    I dati aggiornati dell'evento risultano correttamente renderizzati e visibili a schermo.

    Il sistema mantiene la rotazione o lo stato di visualizzazione attivo in base alle preferenze dell'utente.

Scenari alternativi:

a. Assenza di connessione o dati non aggiornati:

    Il dispositivo perde la connessione di rete con il server remoto.

    Il sistema intercetta l'anomalia e carica in automatico i dati salvati in precedenza nella cache locale.

    L'interfaccia continua a mostrare le informazioni valide senza causare blocchi o arresti anomali a schermo.

Trigger:
Completamento dell'avvio del dispositivo o scadenza del timer di rotazione dei pannelli.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

UC3 – Consultazione stato del dispositivo

Attore principale:
Utente / Installatore.

Descrizione:
Il caso d'uso consente all'utente di consultare in tempo reale le informazioni diagnostiche e lo stato operativo corrente del dispositivo direttamente tramite l'interfaccia a display.

Precondizioni:

    Il dispositivo ESP32 è acceso e correttamente avviato.

    L'interfaccia grafica e il menu di diagnostica sono accessibili.

Scenario principale:

    L'utente apre il menu di diagnostica sul display.

    L'utente seleziona l'opzione per la visualizzazione dello stato del sistema.

    Il sistema interroga i moduli interni e recupera i parametri correnti (stato della rete Wi-Fi, SSID connesso, versione del firmware e tempo trascorso dall'ultima sincronizzazione).

    Il sistema apre un riquadro modale a schermo mostrando le informazioni aggregate.

    L'utente prende visione dello stato e chiude la finestra modale per tornare alla schermata principale.

Postcondizioni:

    L'utente è informato sullo stato di salute e connettività del dispositivo.

    Il sistema riprende la normale rotazione dei pannelli alla chiusura del modale.

Trigger:
L'utente seleziona la voce "Stato Sistema" dal menu touch locale.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

UC4 – Condivisione Wi-Fi tramite QR Code

Attore principale:
Utente / Installatore.

Descrizione:
Il caso d'uso permette al dispositivo di generare e mostrare a schermo un codice QR contenente le credenziali della rete Wi-Fi a cui è attualmente connesso, facilitando la condivisione rapida con altri dispositivi o utenti.

Precondizioni:

    Il dispositivo ESP32 è acceso e connesso a una rete Wi-Fi.

    L'interfaccia grafica locale è attiva.

Scenario principale:

    L'utente accede al menu di diagnostica sul display.

    L'utente seleziona l'opzione per la condivisione della rete Wi-Fi tramite QR Code.

    Il sistema recupera l'SSID e la password della rete attiva.

    Il sistema genera dinamicamente un codice QR formattato secondo lo standard di connessione Wi-Fi.

    Il display mostra il codice QR consentendone la scansione da parte di un dispositivo esterno.

    L'utente chiude il riquadro modale al termine dell'operazione.

Postcondizioni:

    Il codice QR risulta visibile a schermo con le credenziali correnti.

    Alla chiusura del modale, il sistema ripristina la visualizzazione operativa standard.

Scenari alternativi:

a. Dispositivo non connesso alla rete:

    Il sistema rileva l'assenza di una connessione Wi-Fi attiva.

    Il sistema mostra a schermo un messaggio o un QR code indicando lo stato disconnesso.

Trigger:
L'utente seleziona la voce "QR Condivisione Rete" dal menu touch locale.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

UC5 – Riavvio del dispositivo

Attore principale:
Utente / Installatore.

Descrizione:
Il caso d'uso descrive la procedura di riavvio software del microcontrollore ESP32 richiesta localmente dall'utente tramite l'interfaccia touch, senza alterare i dati di configurazione o le preferenze salvate.

Precondizioni:

    Il dispositivo ESP32 è acceso e funzionante.

    L'interfaccia grafica e il menu di diagnostica sono accessibili.

Scenario principale:

    L'utente accede al menu di diagnostica sul display.

    L'utente seleziona l'opzione per il riavvio del dispositivo.

    Il sistema avvia un timer temporizzato per la chiusura delle attività in corso.

    Il sistema esegue il comando software di riavvio del microcontrollore.

    Il dispositivo si riavvia ricaricando il firmware e ripristinando le connessioni.

Postcondizioni:

    Il dispositivo viene riavviato pulitamente preservando le configurazioni e le preferenze salvate in memoria persistente.

Trigger:
L'utente seleziona la voce "Riavvio ESP32" dal menu touch locale.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

UC6 - Reset di sistema

Attore principale:
Utente / Installatore.

Descrizione:
Il caso d'uso descrive l'operazione di ripristino di fabbrica o azzeramento delle configurazioni del dispositivo, che comporta la cancellazione di tutte le preferenze salvate (credenziali Wi-Fi, cache API e impostazioni generali) e il successivo riavvio della scheda.

Precondizioni:

    Il dispositivo ESP32 è acceso e operativo.

    L'utente ha accesso al menu di diagnostica locale.

Scenario principale:

    L'utente accede al menu di diagnostica sul display.

    L'utente seleziona l'opzione di reset o ripristino di fabbrica del sistema.

    Il sistema avvia la procedura di cancellazione dei dati memorizzati nei namespace di configurazione presenti nella memoria flash.

    Il sistema ripulisce le preferenze salvate e disconnette le interfacce di rete.

    Il sistema esegue il riavvio automatico del dispositivo portandolo allo stato iniziale di fabbrica.

Postcondizioni:

    Tutte le preferenze e i dati memorizzati in precedenza risultano cancellati.

    Il dispositivo torna allo stato di configurazione iniziale con l'Access Point di provisioning attivo.

Trigger:
L'utente seleziona la voce di reset ("Reset Wi-Fi" o "Reset ESP32") dal menu touch locale.