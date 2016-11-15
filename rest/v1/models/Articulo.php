<?php if(!defined('SPECIALCONSTANT')) die(json_encode([array('id'=>'0','nombre'=>'Acceso Denegado')]));

$app->get('/articulo',function() use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM articulo;");
		
		$result->execute();
		$res = $result->fetchAll(PDO::FETCH_OBJ);
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($res));
	}catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
});

$app->get('/articulo/:id',function($id) use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM articulo WHERE id='$id';");

		$result->execute();
		$res = $result->fetchObject();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($res));
	}catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
});

$app->post("/articulo/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$id_reservacion = $objDatos->id_reservacion;
	$nombre = $objDatos->nombre;
	$cantidad = $objDatos->cantidad;

	try {
		$conex = getConex();

		$result = $conex->prepare("CALL pInsertArticulo('$id_reservacion','$nombre','$cantidad');");

		$result->execute();
		$res = $result->fetchObject();
		//$res = array('response'=>'success');

		$conex = null;

		$app->response->headers->set("Content-type","application/json");
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($res));
		//$app->response->body($ci);

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
});

$app->put("/articulo/:id",function($id) use($app) {
	//$objDatos = json_decode(file_get_contents("php://input"));
	$jsonmessage = \Slim\Slim::getInstance()->request();
  	$objDatos = json_decode($jsonmessage->getBody());

	$id_reservacion = $objDatos->id_reservacion;
	$nombre = $objDatos->nombre;
	$cantidad = $objDatos->cantidad;

	try {
		$conex = getConex();
		$result = $conex->prepare("UPDATE articulo SET id_reservacion='$id_reservacion',nombre='$nombre',cantidad='$cantidad' WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));

$app->delete('/articulo/:id',function($id) use($app) {
	try {
		$conex = getConex();
		$result = $conex->prepare("DELETE articulo WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));

	} catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));
