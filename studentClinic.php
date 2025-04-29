<?php
session_start();
include('connect.php'); 

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_SERVER["HTTP_X_REQUESTED_WITH"])) {
    header('Content-Type: application/json');

    if (!isset($_SESSION['user']) || !isset($_SESSION['patient_id'])) {
        echo json_encode(["status" => "error", "message" => "Unauthorized access."]);
        exit();
    }

    $patient_id = $_SESSION['patient_id'];
    $date = $_POST['date'];
    $time = $_POST['time'];
    $reason = $_POST['reason'];
    $status = 'Pending';
    $remarks = 'To be accepted by the nurse';

    $checkConflicting = $conn->prepare("SELECT appointment_id FROM appointments WHERE appointmentDate = ? AND appointmentTime = ?");
    $checkConflicting->bind_param("ss", $date, $time);
    $checkConflicting->execute();
    $checkConflicting->store_result();

    if ($checkConflicting->num_rows > 0) {
        echo json_encode(["status" => "error", "message" => "Already have an appointment at that date and time."]);
        $checkConflicting->close();
        $conn->close();
        exit();
    }
    $checkConflicting->close();

    $stmt = $conn->prepare("INSERT INTO appointments (patient_id, appointmentDate, appointmentTime, reason, status, remarks) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("isssss", $patient_id, $date, $time, $reason, $status, $remarks);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Appointment booked successfully!"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to book appointment."]);
    }

    $stmt->close();
    $conn->close();
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
html, body {
    height: 100%;
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #f2f2f2;
    overflow: hidden;
}
.sidebar {
    width: 200px;
    background-color: #f5f5f5;
    position: fixed;
    left: 0;
    top: 0;
    height: 100%;
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
}
.main-wrapper {
    margin-left: 220px;
    padding: 20px;
    height: 100%;
    overflow: hidden;
    box-sizing: border-box;
    margin-top: 70px;
}
.tab-wrapper {
    max-width: 1000px;
    margin: 0 auto;
}
.tab {
    background-color: #2c7df7;
    color: white;
    padding: 8px 13px;
    font-weight: bold;
    display: inline-block;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
    margin: 30px 10px -5px;
}
.content, .schedule {
    background: white;
    padding: 20px;
    border-radius: 10px;
    max-width: 1000px;
    margin: 10px 5px 5px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
.clinic-status {
    float: right;
    padding: 5px 10px;
    font-size: 14px;
    border-radius: 20px;
    color: white;
    font-weight: bold;
}
.open {
    background-color: #28a745;
}
.closed {
    background-color: #dc3545;
}
.appointment-form .form-row {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
}
.appointment-form label {
    width: 180px;
    font-weight: bold;
}
.appointment-form input,
.appointment-form textarea {
    flex: 1;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
}
.appointment-form textarea {
    resize: vertical;
}
.appointment-form button {
    margin-top: 10px;
    padding: 10px 20px;
    background-color: #2c7df7;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}
.appointment-form button:hover {
    background-color: #1f5edb;
}
@media (max-width: 1024px) {
    .sidebar {
        width: 180px;
        padding: 15px;
    }
    .main-wrapper {
        margin-left: 200px;
    }
}
@media (max-width: 768px) {
    .sidebar {
        width: 150px;
        padding: 10px;
    }
    .main-wrapper {
        margin-left: 170px;
    }
    .logout-link {
        font-size: 14px;
        right: 20px;
    }
    .appointment-form label {
        width: 140px;
    }
}
@media (max-width: 480px) {
    .sidebar {
        width: 120px;
        padding: 10px;
    }
    .header {
        padding: 10px;
        font-size: 18px;
    }
    .main-wrapper {
        margin-left: 140px;
    }
    .tab {
        font-size: 16px;
    }
    .appointment-form label {
        width: 120px;
    }
}
</style>
</head>
<body>
<div class="sidebar">
    <h2>SMC Clinic</h2>
    <a href="loginDashboard.php">Profile</a>
    <a href="#" class="active">Clinic</a>
    <a href="studentInventory.php">Medicines</a>
</div>

<div class="header">
    SMC Clinic Dashboard
    <a href="logout.php" class="logout-link">Log Out</a>
</div>

<div class="main-wrapper">
    <div class="tab-wrapper">
        <div class="tab">Clinic</div>
        <div class="content">
            <h3>
                <strong>Clinic Schedule</strong>
                <span class="clinic-status" id="clinicStatusDisplay"></span>
            </h3>
            <p><strong>Monday - Wednesday :</strong> 10:00 a.m - 12:00 p.m</p>
            <p><strong>Thursday - Saturday :</strong> 10:00 a.m - 5:00 p.m</p>
        </div>

        <div class="schedule">
            <h4><strong>Schedule an Appointment</strong></h4>
            <form method="POST" class="appointment-form">
                <div class="form-row">
                    <label for="date">Appointment Date:</label>
                    <input type="date" id="date" name="date" required />
                </div>
                <div class="form-row">
                    <label for="time">Time:</label>
                    <input type="time" id="time" name="time" required />
                </div>
                <div class="form-row">
                    <label for="reason">Reason for Visit:</label>
                    <textarea id="reason" name="reason" rows="4" required></textarea>
                </div>
                <button type="submit">Book Appointment</button>
            </form>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const dateInput = document.getElementById("date");
    const timeInput = document.getElementById("time");
    const reasonInput = document.getElementById("reason");
    const today = new Date().toISOString().split("T")[0];
    dateInput.setAttribute("min", today);

    const statusDisplay = document.getElementById("clinicStatusDisplay");
    let clinicStatus = localStorage.getItem("clinicStatus") || "closed";
    statusDisplay.textContent = clinicStatus.charAt(0).toUpperCase() + clinicStatus.slice(1);
    statusDisplay.classList.add(clinicStatus === "open" ? "open" : "closed");

    function toggleForm(isOpen) {
        const appointmentForm = document.querySelector(".appointment-form");
        appointmentForm.querySelectorAll("input, textarea, button").forEach(el => {
            el.disabled = !isOpen;
        });
        if (!isOpen) {
            reasonInput.value = "";
        }
    }

    window.addEventListener("storage", function (event) {
        if (event.key === "clinicStatus") {
            clinicStatus = event.newValue || "closed";
            statusDisplay.textContent = clinicStatus.charAt(0).toUpperCase() + clinicStatus.slice(1);
            statusDisplay.classList.remove("open", "closed");
            statusDisplay.classList.add(clinicStatus === "open" ? "open" : "closed");
            toggleForm(clinicStatus === "open");
        }
    });

    dateInput.addEventListener("change", function () {
        const selectedDate = new Date(this.value);
        const day = selectedDate.getDay();
        if (day === 0) {
            timeInput.value = "";
            timeInput.disabled = true;
            alert("Appointments are not allowed on Sundays.");
            return;
        }
        timeInput.disabled = false;
        if (day >= 1 && day <= 3) {
            timeInput.min = "10:00";
            timeInput.max = "12:00";
        } else if (day >= 4 && day <= 6) {
            timeInput.min = "10:00";
            timeInput.max = "17:00";
        }
    });

    const appointmentForm = document.querySelector(".appointment-form");
    appointmentForm.addEventListener("submit", function (event) {
        event.preventDefault();
        const formData = new FormData(appointmentForm);
        fetch("", {
            method: "POST",
            headers: { "X-Requested-With": "XMLHttpRequest" },
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            alert(data.message);
        });
    });
});
</script>
</body>
</html>
