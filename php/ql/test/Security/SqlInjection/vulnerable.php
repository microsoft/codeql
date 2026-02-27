<?php
// VULNERABLE: Direct use of $_GET in SQL query
// Should be detected
$id = $_GET['id'];
$result = mysql_query("SELECT * FROM users WHERE id = " . $id);

// VULNERABLE: Direct superglobal in query string
// Should be detected
$query = "SELECT * FROM products WHERE name = '" . $_POST['name'] . "'";
mysqli_query($conn, $query);

// VULNERABLE: User input in PDO query
// Should be detected
$search = $_REQUEST['search'];
$pdo->query("SELECT * FROM items WHERE title LIKE '%" . $search . "%'");

// VULNERABLE: Cookie data in SQL
// Should be detected
$token = $_COOKIE['session_token'];
$pdo->prepare("SELECT * FROM sessions WHERE token = '" . $token . "'");

// SAFE: Parameterized query (not detected as vulnerable)
$stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
$stmt->execute([$_GET['id']]);

// SAFE: Integer cast sanitization
$id = (int)$_GET['id'];
$result = mysql_query("SELECT * FROM users WHERE id = " . $id);

// VULNERABLE: Direct $_GET in mysql_query
// Should be detected
mysql_query("DELETE FROM logs WHERE id = " . $_GET['log_id']);
