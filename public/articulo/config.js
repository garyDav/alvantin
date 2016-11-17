(function(angular){
	'use strict';

	angular.module('articuloModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/admin/articulos',{
					templateUrl: 'public/articulo/views/list-articulos.view.html'
				}).
				when('/admin/articulos/:id',{
					templateUrl: 'public/articulo/views/edit-articulos.view.html'
				});
		}
	]);

})(window.angular);
