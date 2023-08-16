<?php
//$conn= mysqli_connect(host, username, password, dbname, port, socket);
mysqli_select_db($conn, "timetable");
$empty = [];
$data = [];

$qry = "SELECT `Start`,`End`,`Subject`,`Teacher`,`Classroom` FROM `timetable` WHERE `Day`='Monday'&&
`Division`='E'&&(`Batch`='0'or`Batch`='1' or`Batch`='2'or`Batch`='3') && `Start`>6
order by `Start` asc ";
$qry1 = "SELECT `Start`,`End`,`Subject`,`Teacher`,`Classroom` FROM `timetable` WHERE `Day`='Monday'&&
`Division`='E'&&(`Batch`='0'or`Batch`='1' or`Batch`='2'or`Batch`='3') && `Start`<=6
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
