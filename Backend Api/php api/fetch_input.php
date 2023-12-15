<?php
//connecting to server
// mysqli_connect(host, username, password, dbname, port, socket);
mysqli_select_db($conn, "timetable");
$Division = $_POST['Division'];
$Day = $_POST['Day'];
$Batch = $_POST['Batch'];
$data = [];
//creating first json array
$qry = "SELECT * FROM `timetable` WHERE `Day`='$Day'&&`Division`='$Division'&&(`Batch`='$Batch'or`Batch`='0')
&&(`Type`='P'or`Type`='T' or`Type`='S')&& `Start`>7
order by `Start` asc ";
//crearting second json array
$qry1 = "SELECT * FROM `timetable` WHERE `Day`='$Day'&&`Division`='$Division'&&(`Batch`='$Batch'or`Batch`='0')
&&(`Type`='P'or`Type`='T'or`Type`='S')&& `Start`<=7
order by `Start` asc ";
$raw = mysqli_query($conn, $qry);
$raw1 = mysqli_query($conn, $qry1);
//gettting data if data is present
while ($res = mysqli_fetch_array($raw)) {
	$data[] = $res;
}
while ($res1 = mysqli_fetch_array($raw1)) {
	$data1[] = $res1;
}
//merging the both json array
if (count($data) != 0)
	$data = array_merge($data, $data1);
//pprinting the json array
print(json_encode($data));
