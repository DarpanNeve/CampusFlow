<?php 
//connecting to server 
//$conn= mysqli_connect(host, username, password, dbname, port, socket);
mysqli_select_db($conn, "timetable");

$Division = $_POST['Division'];
$Day = $_POST['Day'];
$Batch = $_POST['Batch'];

$data = [];

//creating first json array
$qry = "SELECT * FROM `timetable` WHERE `Day`=? AND `Division`=? AND (`Batch`=? OR `Batch`='0') AND (`Type`='P' OR `Type`='T' OR `Type`='S') AND `Start`>7 ORDER BY `Start` ASC LIMIT 100";
$stmt = mysqli_prepare($conn, $qry);
mysqli_stmt_bind_param($stmt, "sss", $Day, $Division, $Batch);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);
while ($res = mysqli_fetch_array($result)) {
  $data[] = $res;
}

//crearting second json array
$qry1 = "SELECT * FROM `timetable` WHERE `Day`=? AND `Division`=? AND (`Batch`=? OR `Batch`='0') AND (`Type`='P' OR `Type`='T' OR `Type`='S') AND `Start`<=7 ORDER BY `Start` ASC LIMIT 100";
$stmt1 = mysqli_prepare($conn, $qry1);
mysqli_stmt_bind_param($stmt1, "sss", $Day, $Division, $Batch);
mysqli_stmt_execute($stmt1);
$result1 = mysqli_stmt_get_result($stmt1);
$data1 = [];
while ($res1 = mysqli_fetch_array($result1)) {
  $data1[] = $res1;
}

//merging the both json array
if (count($data) != 0) {
  $data = array_merge($data, $data1);
}

//pprinting the json array
header("Content-Type: application/json");
echo json_encode($data);

// close the database connection
mysqli_close($conn);
?>
