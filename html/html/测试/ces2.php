<!DOCTYPE html>
<html>

<head>
	<title>显示表单数据</title>
</head>

<body>

	<?php
	// 获取表单数据
	$username = $_POST["username"];
	$password = $_POST["password"];

	// 显示表单数据
	echo "用户名: " . $username . "<br>";
	echo "密码: " . $password;
	?>

</body>

</html>