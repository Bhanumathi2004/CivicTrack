<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Complaint - Civic Track</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(120deg, #3498db, #8e44ad);
            font-family: 'Segoe UI', sans-serif;
            color: #fff;
            min-height: 100vh;
        }
        .container {
            max-width: 600px;
            margin-top: 60px;
            background-color: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 15px;
            backdrop-filter: blur(8px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
        }
        label {
            color: #fff;
            font-weight: 500;
        }
        .form-control, .form-select {
            background-color: rgba(255,255,255,0.15);
            color: #fff;
            border: 1px solid rgba(255,255,255,0.3);
        }
        .form-control::placeholder {
            color: #ddd;
        }
        input[type="file"] {
            background-color: transparent;
        }
        .btn-submit {
            background-color: #28a745;
            border: none;
            font-weight: 600;
        }
        .btn-submit:hover {
            background-color: #218838;
        }
        h2 {
            font-weight: 700;
            text-align: center;
            margin-bottom: 25px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Raise a Complaint</h2>
    <form action="viewcomplaint" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="type">Complaint Type</label>
            <select class="form-select" id="type" name="type" required>
                <option value="">Select Type</option>
                <option value="Garbage">Garbage</option>
                <option value="Road Damage">Road Damage</option>
                <option value="Water Leakage">Water Leakage</option>
                <option value="Electricity">Electricity</option>
                <option value="Other">Other</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="description">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3" placeholder="Enter details..." required></textarea>
        </div>

        <div class="mb-3">
            <label for="location">Location</label>
            <input type="text" class="form-control" id="location" name="location" placeholder="e.g. Gandhi Nagar, Chennai" required>
        </div>

        <div class="mb-3">
            <label for="image">Upload Image (optional)</label>
            <input type="file" class="form-control" id="image" name="image" accept="image/*">
        </div>
        <form action="viewcomplaint.jsp" method="post">
    <!-- Your form fields for complaint submission -->

    <div class="d-grid">
        <button type="submit" class="btn btn-submit btn-lg">Submit Complaint</button>
    </div>
</form>
        
    </form>
</div>

</body>
</html>
