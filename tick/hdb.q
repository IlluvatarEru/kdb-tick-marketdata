/ HDB
/// launch using the below command:
/// q hdb.q C:/dev/marketdata/sym -p 5002

"Starting kdb-tick-marketdata HDB on port ",.z.X[4]

if[1>count .z.x;show"Supply directory of historical database";exit 0];

hdb:.z.x 0

/Mount the Historical Date Partitioned Database
@[{system"l ",x};hdb;{show "Error message - ",x;exit 0}]