<!DOCTYPE html>
<?php

if (isset($db) === false) {
	$db = new SQLite3("agend.db");
	if ($db === false)
		die("failed to open database");
}


?>


<html>
	<head>
		<title>SQLite Agend</title>
	</head>
	<body>
		<h1>Agend Lookup</h1>
		<form action="sqlite.php" method="post">
			<b>Name:</b> <input type="text" name="name"><input type="submit"><br>
		</form>
		<?php
			if (isset($_POST["name"])) {
				if ($result = $db->query("SELECT * FROM agend WHERE name = \"{$_POST["name"]}\"")) {
					while ($row = $result->fetchArray(SQLITE3_ASSOC)) {
						echo "<h4>Name - {$row["name"]}</h4>";
						echo "<p>ID - {$row["id"]}</p>";
						echo "<p>Phone - {$row["phone"]}</p>";
					}
				} else {
					echo "<p>{$_POST["name"]} not found!</p>";
				}

				unset($_POST["name"]);
			}
		?>
	</body>
</html>

