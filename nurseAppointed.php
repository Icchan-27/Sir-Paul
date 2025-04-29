<?php
session_start();

if (!isset($_SESSION['admin'])) {
    header("Location: Loginpage.php");
    exit();
}

include('connect.php');

$sql = "SELECT * FROM appointments INNER JOIN patient ON appointments.patient_id = patient.patient_id WHERE appointments.status = 'Accepted' ORDER BY appointments.appointmentDate, appointments.appointmentTime";
$result = $conn->query($sql);
$appointments = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $appointments[] = $row;
    }
}

$conn->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>SMC Clinic Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .sidebar {
            width: 200px;
            height: 100vh;
            background-color: #f5f5f5;
            position: fixed;
            left: 0;
            top: 0;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .sidebar h2 {
            font-size: 18px;
            color: #333;
            margin-bottom: 20px;
        }
        .sidebar a {
            display: block;
            text-decoration: none;
            color: #333;
            padding: 10px;
            margin-bottom: 5px;
            border-radius: 5px;
        }
        .sidebar a:hover,
        .sidebar a.active {
            background-color: #2c7df7;
            color: white;
        }
        .header {
            background-color: #2c7df7;
            color: white;
            padding: 15px;
            font-size: 20px;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            z-index: 1;
        }
        .logout-link {
            color: white;
            text-decoration: none;
            position: absolute;
            right: 50px;
            top: 15px;
            font-size: 15px;
            background-color: #1f5edb;
            padding: 5px 10px;
            border-radius: 5px;
            transition: background 0.3s ease;
        }
        .main-content {
            margin-left: 220px;
            padding: 100px 20px 20px 20px;
        }
        .profile {
            display: flex;
            align-items: center;
            background-color: #dce6ff;
            padding: 15px;
            border-radius: 10px;
            width: 90%;
            margin: 0 auto;
        }
        .profile img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-right: 15px;
        }
        .tabs {
            margin-top: 20px;
            display: flex;
            border-bottom: 2px solid #2c7df7;
        }
        .tab {
            padding: 10px 20px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            color: #333;
        }
        .tab:hover,
        .tab.active {
            background-color: #2c7df7;
            color: white;
            border-radius: 5px 5px 0 0;
        }
        .content {
            background: white;
            padding: 20px;
            border-radius: 5px;
            margin-top: -2px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #2c7df7;
            color: white;
        }
        button {
            padding: 6px 12px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        button:hover {
            opacity: 0.9;
        }
        .done-btn {
            background-color: #28a745;
            color: white;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>SMC Clinic</h2>
        <a href="nurseDashBoard.php" class="tab">Pending</a>
        <a href="#" class="tab active">Appointed</a>
        <a href="nurseDone.php" class="tab">Done</a>
        <a href="nurseRejected.php" class="tab">Rejected</a>
    </div>
    <div class="header">
        SMC Clinic Dashboard
        <a href="logout.php" class="logout-link">Log Out</a>
    </div>
    <div class="main-content">
        <div class="profile">
            <img src="ambot.png" alt="Profile Picture" />
            <h2><?php echo $_SESSION['name']; ?></h2>
        </div>
        <div class="tabs">
            <a href="nurseDashBoard.php" class="tab">Pending</a>
            <a href="#" class="tab active">Appointed</a>
            <a href="nurseDone.php" class="tab">Done</a>
            <a href="nurseRejected.php" class="tab">Rejected</a>
        </div>
        <div class="content">
            <table>
    <thead>
        <tr>
            <th>Requester</th>
            <th>Reason</th>
            <th>Date</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody id="appointmentTableBody">
        <?php foreach ($appointments as $appointment): ?>
            <tr>
                <td><?= htmlspecialchars($appointment['firstName']) ?> <?= htmlspecialchars($appointment['lastName']) ?></td>
                <td><?= htmlspecialchars($appointment['Reason']) ?></td>
                <td><?= htmlspecialchars($appointment['appointmentDate']) ?> at <?= htmlspecialchars($appointment['appointmentTime']) ?></td>
                <td><?= htmlspecialchars($appointment['Status']) ?></td>
                <td><button class="done-btn" onclick="markAsDone('<?= $appointment['appointmentDate'] ?>', '<?= $appointment['appointmentTime'] ?>')">Done</button></td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>

        </div>
    </div>
    <script>
        function markAsDone(date, time) {
        }
    </script>
</body>
</html>
