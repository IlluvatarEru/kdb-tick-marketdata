# kdb-tick-marketdata

This is built from code.kx.com/wsvn/kx/kdb+tick

## Set up

This project expects the below folder structure

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
- TP: `q tick.q sym C:/dev/kdb-tick-marketdata/TPlogs -p 5000`
- RTDB: `q tick/rtdb.q localhost:5000 localhost:5002 -p 5001`
- HDB: `q tick/hdb.q C:/dev/kdb-tick-marketdata/TPlogs/sym -p 5002`

## Tables
