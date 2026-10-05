#import "shared.typ": *

/*
#pagebreak()
= Verifica e validazione <verifica-validazione>

#placeholder
#placeholder

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
