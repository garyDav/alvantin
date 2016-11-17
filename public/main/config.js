(function(angular){
	'use strict';

	angular.module('mainModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/',{
					resolve: {
						"check":function($location,sessionService,$rootScope) {
							if(sessionService.get('user') == 'admin')
								$rootScope.c_admin = true;
							if(sessionService.get('user') == 'user')
								$rootScope.c_user = true;
						}
					},
					templateUrl: 'public/main/views/principal.view.html'
				}).
				when('/admin',{
					resolve: {
						"check":function($location,sessionService,$rootScope) {
							if(sessionService.get('user') != 'admin')
								$location.path('/usuario');
							$rootScope.c_admin = true;
						}
					},
					templateUrl: 'public/main/views/admin.view.html'
				}).
				when('/menu',{
					resolve: {
						"check":function($rootScope) {
							$rootScope.c_admin = false;
							$rootScope.c_user = false;
						}
					},
					templateUrl: 'public/main/views/menu.view.html'
				}).
				when('/usuario',{
					resolve: {
						"check":function($location,sessionService,$rootScope) {
							if(sessionService.get('user') == 'admin')
								$rootScope.c_admin = true;
							if(sessionService.get('user') == 'user')
								$rootScope.c_user = true;
						}
					},
					templateUrl: 'public/main/views/usuario.view.html'
				}).
				when('/user',{
					resolve: {
						"check":function($location,sessionService,$rootScope) {
							if(sessionService.get('user') != 'user')
								$location.path('/usuario');
							$rootScope.c_user = true;
						}
					},
					templateUrl: 'public/main/views/user.view.html'
				}).
				otherwise({
					redirectTo: '/'
				});
		}
	]);

})(window.angular);
