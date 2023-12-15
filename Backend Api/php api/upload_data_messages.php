<?php
//$conn= mysqli_connect(host, username, password, dbname, port, socket);

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Get the input values and sanitize them
$Name = isset($_POST['Name']) ? mysqli_real_escape_string($conn, $_POST['Name']) : '';
$Title = isset($_POST['Title']) ? mysqli_real_escape_string($conn, $_POST['Title']) : '';
$Message = isset($_POST['Message']) ? mysqli_real_escape_string($conn, $_POST['Message']) : '';
$Docs = isset($_POST['Docs']) ? mysqli_real_escape_string($conn, $_POST['Docs']) : '';

// Check if Name field is empty
if (empty($Name)) {
    echo "Error: Name field cannot be empty";
    exit;
}

// Define SQL query using prepared statement
$stmt = mysqli_prepare($conn, "INSERT INTO user_chat (Name,Title,Message,Docs) VALUES (?, ?, ?, ?)");
mysqli_stmt_bind_param($stmt, "ssss", $Name, $Title, $Message, $Docs);

// Execute query
if (mysqli_stmt_execute($stmt)) {
    echo "New record created successfully";
} else {
    echo "Error: " . mysqli_error($conn);
}

mysqli_stmt_close($stmt);
mysqli_close($conn);
?>

