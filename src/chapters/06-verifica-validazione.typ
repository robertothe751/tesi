#import "shared.typ": *

/*
#pagebreak()
= Verifica e validazione <verifica-validazione>

#placeholder
#placeholder
Alcune funzioni richiedono ulteriori verifiche prima di un rilascio operativo. In particolare, l'aggiornamento OTA è attivabile da comando remoto ma non dispone di un controllo autonomo periodico; il trasferimento usa un client non cifrato e il codice esaminato non implementa una verifica esplicita della firma del firmware. Inoltre, le operazioni chiamate “reset” non eliminano gli stessi dati: il reset dal menu, il comando remoto e l'endpoint `/reset_factory` hanno effetti diversi, come dettagliato nel capitolo 5. Questi aspetti, insieme all'assenza di metriche quantitative, costituiscono i principali limiti residui della validazione.
Esempio di importazione di un file contenente codice:
#figure(```python
# Il contenuto di code/example.py viene riportato qui per mantenere il file Typst autonomo.
def recur_fibo(n):
    if n <= 1:
        return n
    return recur_fibo(n - 1) + recur_fibo(n - 2)

nterms = 10
for i in range(nterms):
    print(recur_fibo(i))
```, caption: [Fibonacci recursive], kind: raw) <listing-py-fibo>

#placeholder
*/
