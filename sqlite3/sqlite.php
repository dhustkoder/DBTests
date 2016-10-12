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
				echo "<p>ID    NAME    PHONE</p>";
				while($row = $result->fetchArray(SQLITE3_ASSOC)) {
					echo "<p>{$row["id"]}   {$row["name"]}    {$row["phone"]}</p>";
				}

			} else {
				echo "<p>{$errormsg}</p>";
			}
		?>

	</body>
</html>
