<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<String[]> complaints = (List<String[]>) request.getAttribute("complaints");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - CivicTrack</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #eef2f7; padding: 20px; }
        h2 { text-align: center; margin-bottom: 20px; color: #2c3e50; }
        .actions { text-align: right; margin-bottom: 10px; }
        input[type="text"] { padding: 6px; width: 200px; }
        .btn {
            padding: 8px 14px;
            margin-left: 5px;
            border: none;
            color: #fff;
            cursor: pointer;
            border-radius: 5px;
        }
        .delete { background: #e74c3c; }
        .update { background: #2980b9; }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background: #3498db;
            color: white;
            cursor: pointer;
        }
        tr:hover { background: #f9f9f9; }
    </style>
</head>
<body>

<h2>Admin Dashboard - Complaint Overview</h2>

<div class="actions">
    <input type="text" id="searchInput" placeholder="Search..." onkeyup="searchTable()">
    <button class="btn delete" onclick="bulkDelete()">Delete</button>
    <button class="btn update" onclick="bulkUpdateStatus()">Update Status</button>
</div>

<form id="bulkForm" method="post">
    <table id="complaintTable">
        <thead>
            <tr>
                <th><input type="checkbox" onclick="toggleSelectAll(this)"></th>
                <th onclick="sortTable(1)">Reporter</th>
                <th onclick="sortTable(2)">Type</th>
                <th>Description</th>
                <th>Location</th>
                <th>Status</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (complaints != null) {
                for (String[] c : complaints) {
        %>
            <tr>
                <td><input type="checkbox" name="complaintIds" value="<%= c[0] %>"></td>
                <td><%= c[1] %></td>
                <td><%= c[2] %></td>
                <td><%= c[3] %></td>
                <td><%= c[4] %></td>
                <td><%= c[5] %></td>
                <td><%= c[6] %></td>
            </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</form>

<script>
function toggleSelectAll(source) {
    document.querySelectorAll('input[name="complaintIds"]').forEach(cb => cb.checked = source.checked);
}
function searchTable() {
    const input = document.getElementById("searchInput").value.toLowerCase();
    document.querySelectorAll("#complaintTable tbody tr").forEach(row => {
        row.style.display = row.innerText.toLowerCase().includes(input) ? "" : "none";
    });
}
function bulkDelete() {
    document.getElementById("bulkForm").action = "BulkDeleteServlet";
    document.getElementById("bulkForm").submit();
}
function bulkUpdateStatus() {
    const newStatus = prompt("Enter new status:");
    if (newStatus) {
        const form = document.getElementById("bulkForm");
        const statusInput = document.createElement("input");
        statusInput.type = "hidden";
        statusInput.name = "newStatus";
        statusInput.value = newStatus;
        form.appendChild(statusInput);
        form.action = "BulkUpdateStatusServlet";
        form.submit();
    }
}
function sortTable(colIndex) {
    const table = document.getElementById("complaintTable");
    const rows = Array.from(table.rows).slice(1);
    rows.sort((a, b) =>
        a.cells[colIndex].innerText.localeCompare(b.cells[colIndex].innerText)
    );
    const tbody = table.tBodies[0];
    tbody.innerHTML = "";
    rows.forEach(row => tbody.appendChild(row));
}
</script>

</body>
</html>
