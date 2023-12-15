<?php
//$conn= mysqli_connect(host, username, password, dbname, port, socket);
mysqli_select_db($conn, "timetable");
$data = [];
$Classroom = $_POST['Classroom'];
$Day = $_POST['Day'];
$qry = "SELECT * FROM `timetable` WHERE `Day`='$Day' &&
`Classroom`='$Classroom'  && `Start`>6
order by `Start` asc ";
$qry1 = "SELECT * FROM `timetable` WHERE `Day`='$Day'&&
`Classroom`='$Classroom' && `Start`<=6
order by `Start` asc ";

$raw = mysqli_query($conn, $qry);
$raw1 = mysqli_query($conn, $qry1);

while ($res = mysqli_fetch_array($raw)) {
	$data[] = $res;
}
while ($res1 = mysqli_fetch_array($raw1)) {
	$data1[] = $res1;
}
if (count($data) != 0)
	$data = array_merge($data, $data1);
print(json_encode($data));
