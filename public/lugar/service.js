(function(angular) {

	'use strict';
	angular.module('lugarModule').factory('lugarService',
		function($resource) {
			return $resource('rest/v1/lugar/:id', {
					id: '@id'
				}, {
					update: {
						method: 'PUT'
					}
				});
		});


})(window.angular);
