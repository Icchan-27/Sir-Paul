<?php
session_start();
include 'connect.php';

$id_number = $_POST['id_number'] ?? '';
$password = $_POST['password'] ?? '';

$stmt_nurse = $conn->prepare("SELECT * FROM nurse WHERE id_number = ? AND password = ?");
$stmt_nurse->bind_param("ss", $id_number, $password);
$stmt_nurse->execute();
$nurse_result = $stmt_nurse->get_result();

$stmt_patient = $conn->prepare("SELECT * FROM patient WHERE id_number = ? AND password = ?");
$stmt_patient->bind_param("ss", $id_number, $password);
$stmt_patient->execute();
$patient_result = $stmt_patient->get_result();

if ($nurse_result->num_rows > 0) {
    $nurse = $nurse_result->fetch_assoc();
    $_SESSION['admin'] = true;
    $_SESSION['username'] = $id_number;
    $_SESSION['nurse_id'] = $nurse['nurse_id']; 
    $_SESSION['name'] = $nurse['firstName'] . ' ' . $nurse['lastName'];
    header("Location: nurseDashBoard.php");
    exit();
}
elseif ($patient_result->num_rows > 0) {
    $patient = $patient_result->fetch_assoc();
    $_SESSION['user'] = true;
    $_SESSION['username'] = $id_number; 
    $_SESSION['patient_id'] = $patient['patient_id'];
    $_SESSION['name'] = $patient['firstName'] . ' ' . $patient['lastName'];
    header("Location: loginDashboard.php");
    exit();
} else {
    echo "<script>
            alert('Invalid ID Number or Password!');
            window.location.href='Loginpage.php';
        </script>";
}

$stmt_nurse->close();
$stmt_patient->close();
$conn->close();
?>
