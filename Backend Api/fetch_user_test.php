<?php
//connecting to server
// mysqli_connect(host, username, password, dbname, port, socket);

mysqli_select_db($conn, "timetable");
$data = [];
//creating first json array
$qry = "SELECT `Prn`,`Roll No`,`Branch`,`Division` FROM `users` WHERE `Email`='Darpan.neve21@pccoepune.org'";
//crearting second json array
$raw = mysqli_query($conn, $qry);
//gettting data if data is present
while ($res = mysqli_fetch_array($raw)) {
	$data[] = $res;
}
print(json_encode($data));
