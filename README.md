# kdb-tick-marketdata

This is a kdb repo for persisting market data.
It is an adaptation from https://github.com/KxSystems/kdb-tick/tree/master/tick and https://code.kx.com/q/wp/rt-tick/.

## Set up

This project expects you ot have `kdb+/q` installed and the below folder structure:

```
C:/dev/kdb-tick-marketdata/
├── tick/
│   ├── rtdb.q
│   ├── hdb.q
│   ├── sym.q
│   └── u.q
├── TPlogs/
└── tick.q
└── README.md
````

To setup the kdb instances, open your command line and go to `C:/dev/kdb-tick-marketdata`
- to start the TP, run: `q tick.q sym C:/dev/kdb-tick-marketdata/TPlogs -p 5000`
- to start the RTDB, run: `q tick/rtdb.q localhost:5000 localhost:5002 -p 5001`
- to start the HDB, run: `q tick/hdb.q C:/dev/kdb-tick-marketdata/TPlogs/sym -p 5002`

## Tables
Tables are defined in `tick/sym.q`.

## How does it work?
You need to setup a Feedhandler that writes data to the TP. The RTDB subscribes to the TP and the data in the TP is published to the RTDB.
At the end of the day the RTDB data is rolled to the HDB. You can create realtime applications that subscribe to the TP as well. 

In case the RTDB goes down just restart it and it will replay the TP log files located in `TPlogs/`


NB: The RTDB is in memory so it's fast to be queried while the HDB is partitioned so when querying it, always filter by `date` and `sym` first.
