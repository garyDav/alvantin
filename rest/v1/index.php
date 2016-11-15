<?php
//Libreria de Slim
require '../vendor/Slim/Slim.php';
//end Libreria.

\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

session_start();

define('SPECIALCONSTANT',true);

//EntidadesRESTFULL
require 'models/connect.php';

require 'models/User.php';
require 'models/Articulo.php';
require 'models/Lugar.php';
require 'models/Menu.php';
require 'models/Reservacion.php';
//end EntidadesRESTFULL

$app->run();



?>

