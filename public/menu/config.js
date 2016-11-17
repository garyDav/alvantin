(function(angular){
	'use strict';

	angular.module('menuModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/admin/menu',{
					resolve: {
						"check":function($location,sessionService,$rootScope) {
							if(sessionService.get('user') != 'admin')
								$location.path('/usuario');
							$rootScope.c_admin = true;
						}
					},
					templateUrl: 'public/menu/views/list-menu.view.html'
				}).
				when('/admin/menu/:id',{
					resolve: {
						"check":function($location,sessionService,$rootScope) {
							if(sessionService.get('user') != 'admin')
								$location.path('/usuario');
							$rootScope.c_admin = true;
						}
					},
					templateUrl: 'public/menu/views/edit-menu.view.html'
				});
		}
	]);

})(window.angular);
