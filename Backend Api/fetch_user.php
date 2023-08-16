 <?php
//$conn= mysqli_connect(host, username, password, dbname, port, socket);

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $Email = $_POST['Email'];
    $stmt = $conn->prepare("SELECT * FROM users where `Email`=:email");
    $stmt->bindParam(':email', $Email);
    $stmt->execute();

    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

    header('Content-Type: application/json');
    echo json_encode($data);
}
catch(PDOException $e) {
    echo "Error: " . $e->getMessage();
}

$conn = null;
?>
