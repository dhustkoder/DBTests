<!DOCTYPE html>
<html>
	<head>
		<title>Page Title</title>
	</head>
	<body>
		<h1>Listing Agend Table</h1>
		<?php
			if ($db = new SQLite3("agend.db")) {
				$result = $db->query("SELECT * FROM agend");
				while($row = $result->fetchArray(SQLITE3_ASSOC)) {
					echo "<h2>Name: {$row["name"]}</h2>";
					echo "<p>ID: {$row["id"]}</p>";
					echo "<p>Phone: {$row["phone"]}</p>";
				}

			} else {
				echo "<p>{$errormsg}</p>";
			}
		?>

	</body>
</html>
