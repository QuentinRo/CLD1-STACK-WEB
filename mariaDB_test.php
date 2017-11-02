<?php

  if(empty($_POST['userdb'])){
    ?>
    <h1>Enter your database identifiers</h1>
    <form action="mariaDB_test.php" method="POST">
      <input type="text" name="username">
      <input type="text" name="userpass">
      <input type="text" name="userdb">

      <input type="submit">
    </form>
    <?php
  } else {

    $username = $_POST['username'];
    $userpass = $_POST['userpass'];
    $userdb = $_POST['userdb'];

    try{
      $DB = new PDO('mysql:dbname=dudelist;host=localhost', $username, $userpass, $userdb);

      $DB->exec('CREATE TABLE IF NOT EXISTS `tutu` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `hello` varchar(256) DEFAULT NULL,
      )');

      $DB->exec('INSERT INTO `tutu` (`hello`) VALUES (`HEHEHEH this insert works well !`)');

      $stmt = $DB->query('SELECT * FROM tutu');
      print_r($stmt->fetchAll());

    } catch(PDOexeption $e) {
      return $e;
    }

  }