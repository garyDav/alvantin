(function(angular) {

	'use strict';
	angular.module('menuModule').controller('menuCtrl',['$scope','menuService',
		function($scope,menuService) {
			console.log('Entra a lugarCtrl');
			
			$scope.cargarDatos = function() {
				var obj = menuService.query();
				obj.$promise.then(function(response){
					$scope.garra = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			}

			$scope.guardar = function(lugar) {
				var obj = new menuService(lugar);
				obj.$save(function(response) {
					var newLugar = {
						id: response.id,
						nombre: lugar.nombre,
						descripcion: lugar.descripcion,
						tipo: lugar.tipo
					};
					console.log(response);
					$scope.mensaje = response.error;
					//$scope.garra.unshift(lugar);
					$scope.garra.push(newLugar);
					console.log($scope.garra);
				},function(response) {
					console.log(response);
				});
			}
			$scope.cancelar = function() {
				$scope.lugar = {};
			}
			$scope.delete = function(id) {
				var eliminar = confirm('¿Está seguro de eliminar el registro?');
				if(eliminar) {
					var obj = new menuService({id:id});
					obj.$remove(function(response) {
						//console.log(response);
						for(var g in $scope.garra) {
							if( $scope.garra[g].id === id ) {
								$scope.garra.splice(g,1);
							}
						}
					},
					function(response) {
						console.log(response);
					});
				}
			}

		}
	]);

})(window.angular);
