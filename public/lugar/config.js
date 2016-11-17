(function(angular){
	'use strict';

	angular.module('lugarModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/admin/lugares',{
					resolve: {
						"check":function($location,sessionService,$rootScope) {
							if(sessionService.get('user') != 'admin')
								$location.path('/usuario');
							$rootScope.c_admin = true;
						}
					},
					templateUrl: 'public/lugar/views/list-lugar.view.html'
				}).
				when('/admin/lugares/:id',{
					resolve: {
						"check":function($location,sessionService,$rootScope) {
							if(sessionService.get('user') != 'admin')
								$location.path('/usuario');
							$rootScope.c_admin = true;
						}
					},
					templateUrl: 'public/lugar/views/edit-lugar.view.html'
				});
		}
	]);

})(window.angular);
