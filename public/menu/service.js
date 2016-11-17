(function(angular) {

	'use strict';
	angular.module('menuModule').factory('menuService',
		function($resource) {
			return $resource('rest/v1/menu/:id', {
					id: '@id'
				}, {
					update: {
						method: 'PUT'
					}
				});
		});


})(window.angular);
