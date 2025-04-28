<?php
session_start();
include 'connect.php';


if (!isset($_SESSION['user'])) {
    header("Location: Loginpage.php");
    exit();
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>SMC Clinic Dashboard</title>
    <style>
        .student-id {
            background-color: #2c7df7;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
        }
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
        .logout-link:hover {
            background-color: #174bb4;
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
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>SMC Clinic</h2>
        <a href="#" class="active">Profile</a>
        <a href="studentClinic.php">Clinic</a>
        <a href="studentInventory.php">Medicines</a>
    </div>
    <div class="header">
        SMC Clinic Dashboard
        <a href="logout.php" class="logout-link">Log Out</a>
    </div>
    <div class="main-content">
        <div class="profile">
            <img src="ambot.png" alt="Profile Picture" />
            <div style="display: flex; align-items: center;">
                <h2 style="margin: 0; margin-right: 10px;"><?php echo $_SESSION['name']; ?></h2>
                <div class="student-id"><?php echo $_SESSION['username']; ?></div>
            </div>
        </div>
        <div class="tabs">
            <a href="#" class="tab active">Records</a>
            <a href="studentAppointment.php" class="tab">Appointments</a>
        </div>
        <div class="content">
            <table>
                <tr>
                    <th>Reason</th>
                    <th>Medicine / Equipment</th>
                    <th>Quantity</th>
                    <th>Date</th>
                </tr>
                <tbody id="record-table-body"></tbody>
            </table>
        </div>
    </div>
    <script>
        function loadRecords() {
            const studentId = "C23-0232";
            const records = JSON.parse(localStorage.getItem("manageRecords")) || [];
            const tableBody = document.getElementById("record-table-body");
            tableBody.innerHTML = "";

            const filteredRecords = records.filter(record => record.studentId === studentId);

            filteredRecords.forEach(record => {
                const row = document.createElement("tr");

                const reasonCell = document.createElement("td");
                reasonCell.textContent = record.reason;

                const medicineCell = document.createElement("td");
                medicineCell.textContent = record.medicine;

                const quantityCell = document.createElement("td");
                quantityCell.textContent = "x" + record.quantity;

                const dateCell = document.createElement("td");
                dateCell.textContent = record.date || new Date().toLocaleDateString();

                row.appendChild(reasonCell);
                row.appendChild(medicineCell);
                row.appendChild(quantityCell);
                row.appendChild(dateCell);

                tableBody.appendChild(row);
            });
        }

        window.onload = loadRecords;
    </script>
</body>
</html>