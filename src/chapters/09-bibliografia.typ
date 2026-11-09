#import "shared.typ": *

#pagebreak()
#set heading(numbering: none)
= Riferimenti bibliografici e sitografici <bibliografia>
\
Per la descrizione delle tecnologie, delle interfacce di programmazione e delle librerie impiegate nello sviluppo del firmware (inclusi driver hardware, gestione display AMOLED, touch, rete Wi-Fi, WebSocket, OTA e parsing JSON) sono state consultate le documentazioni ufficiali e i repository dei rispettivi progetti. I collegamenti seguenti rimandano alle pagine di riferimento utilizzate.
\
== Documentazione tecnica e piattaforme
\
+ Espressif Systems, _ESP32-S3: Datasheet_, documentazione tecnica del microcontrollore. #link("https://www.espressif.com/sites/default/files/documentation/esp32-s3_datasheet_en.pdf")[https://www.espressif.com/sites/default/files/documentation/esp32-s3_datasheet_en.pdf]. Consultato il 9 novembre 2026.

+ Espressif Systems, _Arduino ESP32 Core Documentation_, documentazione generale delle API e librerie di sistema per ESP32 (Wi-Fi Access Point, Station e scansione, WebServer, DNSServer, LittleFS e Preferences). #link("https://docs.espressif.com/projects/arduino-esp32/en/latest/")[https://docs.espressif.com/projects/arduino-esp32/en/latest/]. Consultato il 9 novembre 2026.

+ Espressif Systems, _ESP-IDF Programming Guide — FreeRTOS_, documentazione dei task FreeRTOS e dei meccanismi di sincronizzazione (mutex) per ESP32-S3. #link("https://docs.espressif.com/projects/esp-idf/en/stable/esp32s3/api-reference/system/freertos.html")[https://docs.espressif.com/projects/esp-idf/en/stable/esp32s3/api-reference/system/freertos.html]. Consultato il 9 novembre 2026.

+ LVGL, _LVGL Documentation_, documentazione ufficiale della libreria grafica embedded (v9), inclusi widget, tileview, QR code e gestione del display. #link("https://lvgl.io/docs/open")[https://lvgl.io/docs/open]. Consultato il 9 novembre 2026.

+ PlatformIO, _PlatformIO Documentation_, documentazione dell'ambiente di sviluppo, della piattaforma ESP32 e del file di configurazione `platformio.ini`. #link("https://docs.platformio.org/en/latest/")[https://docs.platformio.org/en/latest/]. Consultato il 9 novembre 2026.

== Librerie e driver hardware
\
+ MoonOnOurNation, _Arduino_GFX_, libreria grafica per display QSPI e driver CO5300 utilizzata per il rendering a 16-bit (`display_config.cpp`). #link("https://github.com/moononournation/Arduino_GFX")[https://github.com/moononournation/Arduino_GFX]. Consultato il 9 novembre 2026.

+ Lewis He, _TouchDrv_, libreria di gestione per il chip touch CST92XX (`display_config.cpp`). #link("https://github.com/lewisxhe/TouchDrv")[https://github.com/lewisxhe/TouchDrv]. Consultato il 9 novembre 2026.

+ Lode Vandevenne, _LodePNG_, libreria per la decodifica e il parsing di immagini PNG in formato raw per il logo aziendale (`interfaccia_ui.cpp`). #link("https://github.com/lvandeve/lodepng")[https://github.com/lvandeve/lodepng]. Consultato il 9 novembre 2026.

+ Benoît Blanchon, _ArduinoJson_, documentazione della libreria per la serializzazione e il parsing JSON in sistemi embedded (`api.cpp`, `wifi_conessione.cpp`). #link("https://arduinojson.org/")[https://arduinojson.org/]. Consultato il 9 novembre 2026.

+ Links2004, _arduinoWebSockets_, repository e documentazione della libreria WebSocket Client utilizzata per la comunicazione in tempo reale con il server (`api.cpp`). #link("https://github.com/Links2004/arduinoWebSockets")[https://github.com/Links2004/arduinoWebSockets]. Consultato il 9 novembre 2026.

== Strumenti di supporto
\
+ draw.io, _diagrams.net Documentation_, documentazione dell'editor utilizzato per la stesura dei diagrammi UML e di flusso. #link("https://www.drawio.com/docs/")[https://www.drawio.com/docs/]. Consultato il 9 novembre 2026.

+ Typst, _Typst Documentation_, riferimento per l'impaginazione, la formattazione e la gestione dei listati nel documento. #link("https://www.typst.app/docs/")[https://www.typst.app/docs/]. Consultato il 9 novembre 2026.