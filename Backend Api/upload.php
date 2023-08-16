<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_FILES['file'])) {
    $file_name = $_FILES['file']['name'];
    $file_size = $_FILES['file']['size'];
    $file_tmp = $_FILES['file']['tmp_name'];
    $file_type = $_FILES['file']['type'];
    $file_ext = strtolower(pathinfo($file_name, PATHINFO_EXTENSION));
    
    // Define allowed file extensions
    $allowed_ext = array("pdf", "doc", "docx", "txt", "jpg", "jpeg", "png", "gif","xlsx");

    // Check if the file extension is allowed
    if (in_array($file_ext, $allowed_ext)) {
        // Define upload path
        $upload_path = "files/" . $file_name;

        // Move the file to the upload path
        if (move_uploaded_file($file_tmp, $upload_path)) {
    // File uploaded successfully
    $response = array(
        'status' => 'success',
        'message' => 'File uploaded successfully.'
    );
} else {
    // Error uploading file
    $response = array(
        'status' => 'error',
        'message' => 'Error uploading file: ' . $_FILES['file']['error']
    );
}
    } else {
        // Invalid file type
        $response = array(
            'status' => 'error',
            'message' => 'Invalid file type.'
        );
    }
    
    // Send JSON response to the client
    header('Content-Type: application/json');
    echo json_encode($response);
} else {
    // Invalid request
    header("HTTP/1.1 400 Bad Request");
}
?>
