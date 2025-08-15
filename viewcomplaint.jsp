<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Complaints - CMS</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Header Section */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .header-left h1 {
            color: #333;
            font-size: 2.2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .header-left p {
            color: #666;
            font-size: 1.1rem;
        }

        .header-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-secondary {
            background: rgba(102, 126, 234, 0.1);
            color: #667eea;
            border: 1px solid rgba(102, 126, 234, 0.3);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        /* Search and Filter Section */
        .controls {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
        }

        .controls-row {
            display: flex;
            gap: 1rem;
            align-items: center;
            flex-wrap: wrap;
            margin-bottom: 1.5rem;
        }

        .search-box {
            flex: 1;
            min-width: 300px;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 1rem 1rem 1rem 3rem;
            border: 2px solid rgba(102, 126, 234, 0.2);
            border-radius: 12px;
            font-size: 1rem;
            background: white;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }

        .filter-group {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .filter-select {
            padding: 0.75rem 1rem;
            border: 2px solid rgba(102, 126, 234, 0.2);
            border-radius: 12px;
            background: white;
            font-size: 0.95rem;
            cursor: pointer;
            transition: all 0.3s ease;
            min-width: 140px;
        }

        .filter-select:focus {
            outline: none;
            border-color: #667eea;
        }

        /* Status Stats */
        .stats-row {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .stat-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 12px;
            font-weight: 600;
        }

        .stat-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
        }

        .stat-pending { background: #ffc107; }
        .stat-progress { background: #007bff; }
        .stat-resolved { background: #28a745; }
        .stat-rejected { background: #dc3545; }

        /* Table Section */
        .table-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            overflow: hidden;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .header-controls {
            display: flex;
            align-items: center;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .bulk-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.75rem 1.5rem;
            background: rgba(102, 126, 234, 0.1);
            border: 1px solid rgba(102, 126, 234, 0.2);
            border-radius: 12px;
            animation: slideDown 0.3s ease-out;
        }

        .selected-count {
            font-weight: 600;
            color: #667eea;
        }

        .bulk-actions .btn {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
        }

        /* Details row styling */
        .details-row {
            animation: slideDown 0.3s ease-out;
        }

        .details-row td {
            border-top: none !important;
        }

        /* Checkbox styling */
        input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #667eea;
            cursor: pointer;
        }

        /* Enhanced table styling */
        .complaints-table tr:hover {
            background: linear-gradient(90deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
            transform: scale(1.002);
            cursor: pointer;
        }

        .complaints-table tbody tr:hover .action-buttons {
            opacity: 1;
        }

        .action-buttons {
            opacity: 0.7;
            transition: opacity 0.3s ease;
        }

        /* Animation keyframes */
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .table-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
        }

        .table-info {
            color: #666;
            font-size: 0.95rem;
        }

        .table-wrapper {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .complaints-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            min-width: 800px;
        }

        .complaints-table th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 1.25rem 1rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.95rem;
            border: none;
            white-space: nowrap;
        }

        .complaints-table th:first-child {
            border-radius: 12px 0 0 0;
        }

        .complaints-table th:last-child {
            border-radius: 0 12px 0 0;
        }

        .complaints-table td {
            padding: 1.25rem 1rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            vertical-align: top;
        }

        .complaints-table tr:hover {
            background: linear-gradient(90deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
            transform: scale(1.002);
        }

        .complaints-table tr:last-child td {
            border-bottom: none;
        }

        /* Status Badges */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-align: center;
            min-width: 90px;
            display: inline-block;
        }

        .status-pending {
            background: rgba(255, 193, 7, 0.2);
            color: #856404;
            border: 1px solid rgba(255, 193, 7, 0.3);
        }

        .status-progress {
            background: rgba(0, 123, 255, 0.2);
            color: #004085;
            border: 1px solid rgba(0, 123, 255, 0.3);
        }

        .status-resolved {
            background: rgba(40, 167, 69, 0.2);
            color: #155724;
            border: 1px solid rgba(40, 167, 69, 0.3);
        }

        .status-rejected {
            background: rgba(220, 53, 69, 0.2);
            color: #721c24;
            border: 1px solid rgba(220, 53, 69, 0.3);
        }

        /* Priority Badges */
        .priority-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .priority-high {
            background: rgba(220, 53, 69, 0.15);
            color: #721c24;
        }

        .priority-medium {
            background: rgba(255, 193, 7, 0.15);
            color: #856404;
        }

        .priority-low {
            background: rgba(40, 167, 69, 0.15);
            color: #155724;
        }

        /* Description Cell */
        .description-cell {
            max-width: 300px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            position: relative;
        }

        .description-cell:hover {
            white-space: normal;
            overflow: visible;
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            z-index: 10;
            position: relative;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.85rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        .btn-view {
            background: rgba(0, 123, 255, 0.1);
            color: #004085;
            border: 1px solid rgba(0, 123, 255, 0.2);
        }

        .btn-edit {
            background: rgba(255, 193, 7, 0.1);
            color: #856404;
            border: 1px solid rgba(255, 193, 7, 0.2);
        }

        .btn-delete {
            background: rgba(220, 53, 69, 0.1);
            color: #721c24;
            border: 1px solid rgba(220, 53, 69, 0.2);
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #666;
        }

        .empty-state i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: #333;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
        }

        .pagination-btn {
            padding: 0.75rem 1rem;
            border: 1px solid rgba(102, 126, 234, 0.3);
            background: white;
            color: #667eea;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .pagination-btn:hover:not(.disabled) {
            background: #667eea;
            color: white;
        }

        .pagination-btn.disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

            .header {
                flex-direction: column;
                text-align: center;
            }

            .header-left h1 {
                font-size: 1.8rem;
            }

            .controls-row {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                min-width: auto;
            }

            .filter-group {
                justify-content: center;
            }

            .stats-row {
                flex-wrap: wrap;
            }

            .table-section {
                padding: 1rem;
            }

            .complaints-table th,
            .complaints-table td {
                padding: 0.75rem 0.5rem;
                font-size: 0.9rem;
            }

            .action-buttons {
                flex-direction: column;
            }
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header, .controls, .table-section {
            animation: fadeInUp 0.6s ease-out;
        }

        .controls {
            animation-delay: 0.1s;
        }

        .table-section {
            animation-delay: 0.2s;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="header-left">
                <h1><i class="fas fa-list-alt"></i> All Complaints</h1>
                <p>Manage and track all submitted complaints</p>
            </div>
            <div class="header-actions">
                <button class="btn btn-secondary" onclick="exportComplaints()">
                    <i class="fas fa-download"></i> Export
                </button>
                <a href="addcomplaint.jsp" class="btn btn-primary">
                    <i class="fas fa-plus"></i> New Complaint
                </a>
                <a href="adminDashboard.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>

        <!-- Search and Filter Controls -->
        <div class="controls">
            <div class="controls-row">
                <div class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="search-input" placeholder="Search complaints by ID, reporter, type, or description..." id="searchInput">
                </div>
                <div class="filter-group">
                    <select class="filter-select" id="statusFilter">
                        <option value="">All Statuses</option>
                        <option value="Pending">Pending</option>
                        <option value="In Progress">In Progress</option>
                        <option value="Resolved">Resolved</option>
                        <option value="Rejected">Rejected</option>
                    </select>
                    <select class="filter-select" id="typeFilter">
                        <option value="">All Types</option>
                        <option value="Technical">Technical</option>
                        <option value="Service">Service</option>
                        <option value="Billing">Billing</option>
                        <option value="General">General</option>
                    </select>
                    <select class="filter-select" id="sortBy">
                        <option value="date_desc">Newest First</option>
                        <option value="date_asc">Oldest First</option>
                        <option value="priority">Priority</option>
                        <option value="status">Status</option>
                    </select>
                </div>
            </div>
            
            <div class="stats-row">
                <div class="stat-item">
                    <div class="stat-dot stat-pending"></div>
                    <span>Pending: <span id="pendingCount">0</span></span>
                </div>
                <div class="stat-item">
                    <div class="stat-dot stat-progress"></div>
                    <span>In Progress: <span id="progressCount">0</span></span>
                </div>
                <div class="stat-item">
                    <div class="stat-dot stat-resolved"></div>
                    <span>Resolved: <span id="resolvedCount">0</span></span>
                </div>
                <div class="stat-item">
                    <div class="stat-dot stat-rejected"></div>
                    <span>Rejected: <span id="rejectedCount">0</span></span>
                </div>
            </div>
        </div>

        <!-- Table Section -->
        <div class="table-section">
            <div class="table-header">
                <h2 class="table-title">Complaints List</h2>
                <div class="header-controls">
                    <div class="bulk-actions" id="bulkActions" style="display: none;">
                        <span class="selected-count">0 selected</span>
                        <button class="btn btn-secondary" onclick="bulkUpdateStatus()">
                            <i class="fas fa-edit"></i> Update Status
                        </button>
                        <button class="btn btn-danger" onclick="bulkDelete()">
                            <i class="fas fa-trash"></i> Delete Selected
                        </button>
                    </div>
                    <div class="table-info">
                        Showing <span id="showingCount">0</span> of <span id="totalCount">0</span> complaints
                    </div>
                </div>
            </div>

            <div class="table-wrapper">
                <table class="complaints-table" id="complaintsTable">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="selectAll" onchange="toggleSelectAll()">
                            </th>
                            <th><i class="fas fa-hashtag"></i> ID</th>
                            <th><i class="fas fa-user"></i> Reporter</th>
                            <th><i class="fas fa-tag"></i> Type</th>
                            <th><i class="fas fa-file-text"></i> Description</th>
                            <th><i class="fas fa-map-marker-alt"></i> Location</th>
                            <th><i class="fas fa-flag"></i> Priority</th>
                            <th><i class="fas fa-info-circle"></i> Status</th>
                            <th><i class="fas fa-calendar"></i> Date</th>
                            <th><i class="fas fa-cogs"></i> Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        List<String[]> complaints = (List<String[]>) request.getAttribute("complaints");
                        if (complaints != null && !complaints.isEmpty()) {
                            for (String[] c : complaints) {
                                String status = c[5];
                                String statusClass = "";
                                if ("Pending".equals(status)) statusClass = "status-pending";
                                else if ("In Progress".equals(status)) statusClass = "status-progress";
                                else if ("Resolved".equals(status)) statusClass = "status-resolved";
                                else if ("Rejected".equals(status)) statusClass = "status-rejected";
                                
                                // Mock priority based on complaint type or status
                                String priority = "Medium";
                                String priorityClass = "priority-medium";
                                if ("Technical".equals(c[2]) || "Billing".equals(c[2])) {
                                    priority = "High";
                                    priorityClass = "priority-high";
                                } else if ("General".equals(c[2])) {
                                    priority = "Low";
                                    priorityClass = "priority-low";
                                }
                        %>
                        <tr>
                            <td><input type="checkbox" class="row-select" value="<%= c[0] %>" onchange="updateBulkActions()"></td>
                            <td><strong><%= c[0] %></strong></td>
                            <td><%= c[1] %></td>
                            <td><%= c[2] %></td>
                            <td class="description-cell" title="<%= c[3] %>"><%= c[3] %></td>
                            <td><i class="fas fa-map-marker-alt" style="color: #667eea;"></i> <%= c[4] %></td>
                            <td><span class="priority-badge <%= priorityClass %>"><%= priority %></span></td>
                            <td><span class="status-badge <%= statusClass %>"><%= c[5] %></span></td>
                            <td><i class="fas fa-calendar" style="color: #666;"></i> <%= c[6] %></td>
                            <td>
                                <div class="action-buttons">
                                    <button class="action-btn btn-view" onclick="viewComplaint('<%= c[0] %>')">
                                        <i class="fas fa-eye"></i> View
                                    </button>
                                    <button class="action-btn btn-edit" onclick="editComplaint('<%= c[0] %>')">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="action-btn btn-delete" onclick="deleteComplaint('<%= c[0] %>')">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="10" class="empty-state">
                                <i class="fas fa-inbox"></i>
                                <h3>No Complaints Found</h3>
                                <p>There are currently no complaints to display.</p>
                            </td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <button class="pagination-btn" id="prevBtn">
                    <i class="fas fa-chevron-left"></i> Previous
                </button>
                <span class="pagination-info">Page 1 of 1</span>
                <button class="pagination-btn" id="nextBtn">
                    Next <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </div>

    <script>
        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            updateStatistics();
            updateTableInfo();
            initializeFilters();
        });

        // Update statistics
        function updateStatistics() {
            const rows = document.querySelectorAll('#complaintsTable tbody tr');
            let pending = 0, progress = 0, resolved = 0, rejected = 0;
            
            rows.forEach(row => {
                const cells = row.querySelectorAll('td');
                if (cells.length > 1) {
                    const statusCell = cells[6];
                    const status = statusCell.textContent.trim();
                    
                    if (status.includes('Pending')) pending++;
                    else if (status.includes('Progress')) progress++;
                    else if (status.includes('Resolved')) resolved++;
                    else if (status.includes('Rejected')) rejected++;
                }
            });
            
            document.getElementById('pendingCount').textContent = pending;
            document.getElementById('progressCount').textContent = progress;
            document.getElementById('resolvedCount').textContent = resolved;
            document.getElementById('rejectedCount').textContent = rejected;
        }

        // Update table info
        function updateTableInfo() {
            const rows = document.querySelectorAll('#complaintsTable tbody tr');
            const visibleRows = Array.from(rows).filter(row => row.style.display !== 'none');
            const total = rows.length;
            const showing = visibleRows.length;
            
            document.getElementById('showingCount').textContent = showing;
            document.getElementById('totalCount').textContent = total;
        }

        // Initialize filters
        function initializeFilters() {
            const searchInput = document.getElementById('searchInput');
            const statusFilter = document.getElementById('statusFilter');
            const typeFilter = document.getElementById('typeFilter');
            const sortBy = document.getElementById('sortBy');

            searchInput.addEventListener('input', filterTable);
            statusFilter.addEventListener('change', filterTable);
            typeFilter.addEventListener('change', filterTable);
            sortBy.addEventListener('change', sortTable);
        }

        // Filter table
        function filterTable() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value;
            const typeFilter = document.getElementById('typeFilter').value;
            const rows = document.querySelectorAll('#complaintsTable tbody tr');

            rows.forEach(row => {
                const cells = row.querySelectorAll('td');
                if (cells.length > 1) {
                    const id = cells[0].textContent.toLowerCase();
                    const reporter = cells[1].textContent.toLowerCase();
                    const type = cells[2].textContent;
                    const description = cells[3].textContent.toLowerCase();
                    const status = cells[6].textContent;

                    const matchesSearch = !searchTerm || 
                        id.includes(searchTerm) || 
                        reporter.includes(searchTerm) || 
                        description.includes(searchTerm);
                    
                    const matchesStatus = !statusFilter || status.includes(statusFilter);
                    const matchesType = !typeFilter || type === typeFilter;

                    if (matchesSearch && matchesStatus && matchesType) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                }
            });

            updateTableInfo();
        }

        // Sort table
        function sortTable() {
            const sortBy = document.getElementById('sortBy').value;
            const tbody = document.querySelector('#complaintsTable tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));

            rows.sort((a, b) => {
                const cellsA = a.querySelectorAll('td');
                const cellsB = b.querySelectorAll('td');
                
                if (cellsA.length <= 1 || cellsB.length <= 1) return 0;

                let valueA, valueB;

                switch (sortBy) {
                    case 'date_desc':
                        valueA = new Date(cellsA[7].textContent.trim());
                        valueB = new Date(cellsB[7].textContent.trim());
                        return valueB - valueA;
                    case 'date_asc':
                        valueA = new Date(cellsA[7].textContent.trim());
                        valueB = new Date(cellsB[7].textContent.trim());
                        return valueA - valueB;
                    case 'priority':
                        const priorityOrder = { 'High': 3, 'Medium': 2, 'Low': 1 };
                        valueA = priorityOrder[cellsA[5].textContent.trim()] || 0;
                        valueB = priorityOrder[cellsB[5].textContent.trim()] || 0;
                        return valueB - valueA;
                    case 'status':
                        valueA = cellsA[6].textContent.trim();
                        valueB = cellsB[6].textContent.trim();
                        return valueA.localeCompare(valueB);
                    default:
                        return 0;
                }
            });

            rows.forEach(row => tbody.appendChild(row));
        }

        // Action functions
        function viewComplaint(id) {
            // Show loading state
            const btn = event.target.closest('.btn-view');
            const originalText = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
            btn.disabled = true;
            
            // Simulate loading delay
            setTimeout(() => {
                window.location.href = 'complaint-detail.jsp?id=' + encodeURIComponent(id);
            }, 500);
        }

        function editComplaint(id) {
            const btn = event.target.closest('.btn-edit');
            const originalText = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
            btn.disabled = true;
            
            setTimeout(() => {
                window.location.href = 'edit-complaint.jsp?id=' + encodeURIComponent(id);
            }, 500);
        }

        function deleteComplaint(id) {
            // Create custom modal for confirmation
            const modal = createConfirmModal(
                'Delete Complaint',
                `Are you sure you want to delete complaint ${id}? This action cannot be undone.`,
                'danger',
                () => {
                    // Show loading state
                    const btn = event.target.closest('.btn-delete');
                    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Deleting...';
                    btn.disabled = true;
                    
                    // Redirect to delete servlet
                    setTimeout(() => {
                        window.location.href = 'DeleteComplaintServlet?id=' + encodeURIComponent(id);
                    }, 1000);
                }
            );
            document.body.appendChild(modal);
        }

        // Create custom confirmation modal
        function createConfirmModal(title, message, type, onConfirm) {
            const modal = document.createElement('div');
            modal.className = 'custom-modal';
            modal.innerHTML = `
                <div class="modal-overlay">
                    <div class="modal-content">
                        <div class="modal-header ${type}">
                            <h3><i class="fas fa-exclamation-triangle"></i> ${title}</h3>
                        </div>
                        <div class="modal-body">
                            <p>${message}</p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary modal-cancel">Cancel</button>
                            <button class="btn btn-danger modal-confirm">Confirm</button>
                        </div>
                    </div>
                </div>
            `;
            
            // Add modal styles
            const style = document.createElement('style');
            style.textContent = `
                .custom-modal {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    z-index: 1000;
                    animation: fadeIn 0.3s ease-out;
                }
                .modal-overlay {
                    width: 100%;
                    height: 100%;
                    background: rgba(0, 0, 0, 0.5);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 2rem;
                }
                .modal-content {
                    background: white;
                    border-radius: 12px;
                    max-width: 500px;
                    width: 100%;
                    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                    animation: slideUp 0.3s ease-out;
                }
                .modal-header {
                    padding: 1.5rem;
                    border-bottom: 1px solid #eee;
                    border-radius: 12px 12px 0 0;
                }
                .modal-header.danger {
                    background: linear-gradient(135deg, #ff6b6b, #ee5a24);
                    color: white;
                }
                .modal-header h3 {
                    margin: 0;
                    font-size: 1.2rem;
                }
                .modal-body {
                    padding: 2rem 1.5rem;
                }
                .modal-footer {
                    padding: 1rem 1.5rem;
                    display: flex;
                    gap: 1rem;
                    justify-content: flex-end;
                    border-top: 1px solid #eee;
                }
                .btn-danger {
                    background: linear-gradient(135deg, #ff6b6b, #ee5a24);
                    color: white;
                }
                @keyframes slideUp {
                    from { transform: translateY(50px); opacity: 0; }
                    to { transform: translateY(0); opacity: 1; }
                }
            `;
            modal.appendChild(style);
            
            // Add event listeners
            modal.querySelector('.modal-cancel').addEventListener('click', () => {
                modal.remove();
            });
            modal.querySelector('.modal-confirm').addEventListener('click', () => {
                modal.remove();
                onConfirm();
            });
            modal.querySelector('.modal-overlay').addEventListener('click', (e) => {
                if (e.target === e.currentTarget) {
                    modal.remove();
                }
            });
            
            return modal;
        }

        // Bulk actions functionality
        function toggleSelectAll() {
            const selectAll = document.getElementById('selectAll');
            const checkboxes = document.querySelectorAll('.row-select');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAll.checked;
            });
            
            updateBulkActions();
        }

        function updateBulkActions() {
            const selectedCheckboxes = document.querySelectorAll('.row-select:checked');
            const bulkActions = document.getElementById('bulkActions');
            const selectedCount = bulkActions.querySelector('.selected-count');
            
            if (selectedCheckboxes.length > 0) {
                bulkActions.style.display = 'flex';
                selectedCount.textContent = `${selectedCheckboxes.length} selected`;
            } else {
                bulkActions.style.display = 'none';
            }
        }

        function bulkUpdateStatus() {
            const selectedIds = Array.from(document.querySelectorAll('.row-select:checked'))
                .map(checkbox => checkbox.value);
            
            if (selectedIds.length === 0) return;
            
            const modal = createStatusModal(selectedIds);
            document.body.appendChild(modal);
        }

        function bulkDelete() {
            const selectedIds = Array.from(document.querySelectorAll('.row-select:checked'))
                .map(checkbox => checkbox.value);
            
            if (selectedIds.length === 0) return;
            
            const modal = createConfirmModal(
                'Delete Multiple Complaints',
                `Are you sure you want to delete ${selectedIds.length} complaint(s)? This action cannot be undone.`,
                'danger',
                () => {
                    // Submit form with selected IDs
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'BulkDeleteServlet';
                    
                    selectedIds.forEach(id => {
                        const input = document.createElement('input');
                        input.type = 'hidden';
                        input.name = 'complaintIds';
                        input.value = id;
                        form.appendChild(input);
                    });
                    
                    document.body.appendChild(form);
                    form.submit();
                }
            );
            document.body.appendChild(modal);
        }

        // Create status update modal
        function createStatusModal(selectedIds) {
            const modal = document.createElement('div');
            modal.className = 'custom-modal';
            modal.innerHTML = `
                <div class="modal-overlay">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3><i class="fas fa-edit"></i> Update Status</h3>
                        </div>
                        <div class="modal-body">
                            <p>Update status for ${selectedIds.length} complaint(s):</p>
                            <select id="newStatus" class="filter-select" style="width: 100%; margin-top: 1rem;">
                                <option value="Pending">Pending</option>
                                <option value="In Progress">In Progress</option>
                                <option value="Resolved">Resolved</option>
                                <option value="Rejected">Rejected</option>
                            </select>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary modal-cancel">Cancel</button>
                            <button class="btn btn-primary modal-confirm">Update Status</button>
                        </div>
                    </div>
                </div>
            `;
            
            // Add event listeners
            modal.querySelector('.modal-cancel').addEventListener('click', () => {
                modal.remove();
            });
            modal.querySelector('.modal-confirm').addEventListener('click', () => {
                const newStatus = modal.querySelector('#newStatus').value;
                
                // Submit form with selected IDs and new status
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'BulkUpdateStatusServlet';
                
                selectedIds.forEach(id => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'complaintIds';
                    input.value = id;
                    form.appendChild(input);
                });
                
                const statusInput = document.createElement('input');
                statusInput.type = 'hidden';
                statusInput.name = 'newStatus';
                statusInput.value = newStatus;
                form.appendChild(statusInput);
                
                document.body.appendChild(form);
                form.submit();
            });
            
            return modal;
        }

        // Export functionality
        function exportComplaints() {
            const btn = event.target.closest('.btn');
            const originalText = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Exporting...';
            btn.disabled = true;
            
            // Get current filter values
            const searchTerm = document.getElementById('searchInput').value;
            const statusFilter = document.getElementById('statusFilter').value;
            const typeFilter = document.getElementById('typeFilter').value;
            
            // Create export URL with filters
            const params = new URLSearchParams();
            if (searchTerm) params.append('search', searchTerm);
            if (statusFilter) params.append('status', statusFilter);
            if (typeFilter) params.append('type', typeFilter);
            
            // Simulate export delay
            setTimeout(() => {
                window.location.href = 'ExportComplaintsServlet?' + params.toString();
                btn.innerHTML = originalText;
                btn.disabled = false;
            }, 1500);
        }

        // Advanced table features
        function toggleRowDetails(row) {
            const detailsRow = row.nextElementSibling;
            if (detailsRow && detailsRow.classList.contains('details-row')) {
                detailsRow.remove();
            } else {
                createDetailsRow(row);
            }
        }

        function createDetailsRow(row) {
            const cells = row.querySelectorAll('td');
            const detailsRow = document.createElement('tr');
            detailsRow.className = 'details-row';
            detailsRow.innerHTML = `
                <td colspan="10" style="padding: 0; background: #f8f9fa;">
                    <div style="padding: 1.5rem; border-left: 4px solid #667eea;">
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem;">
                            <div>
                                <strong>Full Description:</strong>
                                <p style="margin-top: 0.5rem; color: #666;">${cells[4].textContent}</p>
                            </div>
                            <div>
                                <strong>Additional Details:</strong>
                                <p style="margin-top: 0.5rem; color: #666;">Contact: +1-234-567-8900<br>Email: ${cells[2].textContent.toLowerCase().replace(' ', '.')}@email.com</p>
                            </div>
                            <div>
                                <strong>Resolution Notes:</strong>
                                <p style="margin-top: 0.5rem; color: #666;">No resolution notes available yet.</p>
                            </div>
                        </div>
                    </div>
                </td>
            `;
            row.insertAdjacentElement('afterend', detailsRow);
        }

        // Add smooth animations to table rows
        document.querySelectorAll('.complaints-table tbody tr').forEach((row, index) => {
            row.style.animation = `fadeInUp 0.6s ease-out ${index * 0.05}s both`;
        });
    </script>
</body>
</html>