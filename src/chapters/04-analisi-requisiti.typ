#import "shared.typ": *

/*
#pagebreak()
= Analisi dei requisiti <analisi-requisiti>

== Casi d'uso
Per lo studio dei casi di utilizzo del prodotto sono stati creati dei diagrammi. I diagrammi dei casi d'uso (_Use Case Diagram_) sono diagrammi di tipo _UML_ dedicati alla descrizione delle funzioni o servizi offerti da un sistema, cosi come sono percepiti dagli attori che interagiscono col sistema stesso.

#usecase(0, [Scenario principale], [Sviluppatore applicativi.], [Lo sviluppatore e entrato nel plugin di simulazione all'interno dell'IDE.], [La finestra di simulazione mette a disposizione i comandi per configurare, registrare o eseguire un test.], [Il sistema e pronto per permettere una nuova interazione.]) <uc-scenario-principale>

#usecase(1, [Gestione Utente], [Amministratore, Utente Registrato.], [L'utente deve essere autenticato nel sistema.], [L'utente puo gestire le informazioni del proprio profilo.], [Le modifiche vengono salvate nel sistema.], alternative: [Se l'utente non e autenticato, viene visualizzato un messaggio di errore.]) <uc-casi-uso>

#usecase(2, [Creazione Prodotto], [Amministratore.], [L'amministratore ha effettuato l'accesso al sistema.], [L'amministratore puo aggiungere un nuovo prodotto al catalogo.], [Il nuovo prodotto viene aggiunto con successo.], alternative: [Se i campi obbligatori non sono compilati, viene visualizzato un messaggio di errore.]) <uc-creazione-prodotto>

== Tracciamento dei requisiti
Da un'attenta analisi dei requisiti e degli use case effettuata sul progetto e stata stilata la tabella che traccia i requisiti in rapporto agli use case.

Il codice dei requisiti, dove ogni requisito e identificato con il carattere *R*, e cosi strutturato:

+ *F:* Funzionale.
+ *Q:* Qualitativo.
+ *V:* Di vincolo.
+ *N:* Obbligatorio (necessario).
+ *D:* Desiderabile.
+ *Z:* Opzionale.

Nelle tabelle seguenti sono riassunti i requisiti e il loro tracciamento con gli use case delineati in fase di analisi.

== Tabelle dei requisiti
#requirement-table((
  ([RFN-1], [L'interfaccia permette di configurare il tipo di sonde del test], [UC1]),
), caption: [Tabella del tracciamento dei requisiti funzionali.]) <tab-requisiti-funzionali>

#requirement-table((
  ([RQD-1n], [Le prestazioni del simulatore hardware devono garantire la giusta esecuzione dei test e non la generazione di falsi negativi], [-]),
  ([RQD-2n], [Le prestazioni del simulatore hardware devono essere monitorate durante l'esecuzione], [-]),
  ([RQD-3n], [Il sistema deve notificare eventuali anomalie], [-]),
), caption: [Tabella del tracciamento dei requisiti qualitativi.]) <tab-requisiti-qualitativi>

#requirement-table((
  ([RVO-1], [La libreria per l'esecuzione dei test automatici deve essere riutilizzabile], [-]),
), caption: [Tabella del tracciamento dei requisiti di vincolo.]) <tab-requisiti-vincolo>
*/
