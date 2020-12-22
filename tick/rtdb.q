/ RTDB
/// launch using the below command:
/// q tick/r.q [host]:port[:usr:pwd] [host]:port[:usr:pwd]

"Starting kdb-tick-marketdata RTDB on port ",.z.X[5]

/ Checks the operating system, and if it is not Windows, the appropriate OS command is invoked to sleep for one second.
/ This is required as the RDB will soon try to establish a connection to the TP and a non-Windows OS may need some time
/ to register the RDB before such an interprocess communication (TCP/IP) connection can be established.
if[not "w"=first string .z.o;system "sleep 1"];

upd:insert;

/ get the ticker plant and history ports, defaults are 5010,5012
/.z.x is a system variable which stores the custom command-line arguments, supplied to the process upon startup
.u.x:.z.x,(count .z.x)_(":5010";":5012");

/ end of day: save, clear, hdb reload
.u.end:{
    /input x: input to .u.end as supplied by TP: the partition to write to, ie a date

    /Return a list of the names of all tables defined in the default namespace and assign to the local variable t
    t:tables`.;

    / Obtains the subset of tables in t that have the grouped attribute on their sym column.
    / This is done because later these tables will be emptied out and their attribute information will be lost.
    / Therefore we store this attribute information now so the attributes can be re-applied after the clear out.
    / As an aside, the g attribute of the sym column makes queries that filter on the sym column run faster.
    t@:where `g=attr each t@\:`sym;

    / .Q.hdpf is a high-level function which saves all in-memory tables to disk in partitioned format,
    / empties them out and then instructs the HDB to reload.
    .Q.hdpf[`$":",.u.x 1;`:.;x;`sym];

    /This line applies the g attribute to the sym column of each table as previously discussed.
    @[;`sym;`g#] each t;
    };

/ init schema and sync up from log file;cd to hdb(so client save can run)
/ This function is invoked at startup once the RDB has connected/subscribed to the TP
/ .u.rep takes two arguments. The first, x, is a list of two-item lists, each containing a table name (as a symbol) and
/ an empty schema for that table. The second argument to .u.rep, y, is a single two-item list.
/ y is a pair where the last element is the TP logfile and the first element is the number of messages written to this logfile so far
/ These arguments are supplied by the TP upon subscription.
.u.rep:{
    / This line just loops over the table name/empty table pairs and initializes these tables accordingly within the current working namespace (default namespace)
    (.[;();:;].)each x; /actually =(set[;].) each x;

    /Checks if no messages have been written to the TP logfile.
    /If that is the case, the RDB is ready to go and the function returns (arbitrarily with an empty list).
    /Otherwise, proceed to the next line
    if[null first y;:()];
    /This line simply replays an appropriate number of messages from the start of the TP logfile
    -11!y;
    /Changes the current working directory of the RDB to the root of the on-disk partitioned database.
    / Therefore, when .Q.hdpf is invoked at EOD, the day’s records will be written to the correct place.
    system "cd ",1_-10_string first reverse y
    };

/ HARDCODE \cd if other than logdir/db

/ connect to ticker plant for (schema;(logcount;log))
/ (hopen `$":",.u.x 0) -> handle to TP
/ .u.sub[`;`]; = Subscribe to all tables and to all symbols.
/// .u.sub is a binary function defined on the tickerplant.
/// If passed null symbols (as is the case here), it will return a list of pairs (table name/empty table),
/// consistent with the first argument to .u.rep as discussed previously.
/// At this point the RDB is subscribed to all tables and to all symbols on the tickerplant and will therefore receive all intraday updates from the TP.
/ `.u `i`L = Obtain name/location of TP logfile and number of messages written by TP to said logfile.

.u.rep .(hopen `$":",.u.x 0)"(.u.sub[`;`];`.u `i`L)";

