// simple app to cause paths to load various processing sketches
var app = angular.module('sketches', ['ngRoute']);

app
  .config(['$routeProvider', function($routeProvider) {
    $routeProvider
      .when('/', {
        template: '<div class="center-block" style="width:500px;text-align:center;margin-top:5em;"><h2>Select a sketch from the dropdown at the top right</h2></div>'
      })
      .when('/sketch/:sketch', {
        template: '<div class="center-block" id="canvas-container"><canvas id="sketch-canvas"></canvas></div>',
        //template: '<canvas ng-data-processing-sources="{{getPde()}}"></canvas>',
        controller: 'sketchController'
      })
      .otherwise({
        redirectTo: '/'
      });
  }])
  .factory('pdeService', ['$http', function($http){
    return {
      getPdeList: function(successFn, errorFn) {
        $http.get('pde/pdeList.json').success(successFn).error(errorFn);
      },
      getPde: function(sketch, successFn, errorFn) {
        $http.get('pde/'+sketch+'.pde').success(successFn).error(errorFn);
      }
    };
  }])
  .controller('sketchController', ['$scope', '$routeParams', '$http', 'pdeService', function($scope, $routeParams, $http, pdeService) {
    pdeService.getPde($routeParams.sketch, function(data) {
      var compiledSketch = Processing.compile(data),
          canvas = document.getElementById('sketch-canvas');
      new Processing(canvas, compiledSketch);
      document.getElementById('canvas-container').style.width=canvas.width+"px";
    }, function(){
      console.error($routeParams.sketch + ' not found!');
    });

  }])
  .controller('navbarController', ['$scope', 'pdeService', function($scope, pdeService) {
    $scope.sketches = [];
    pdeService.getPdeList(function(data){
      console.log(data);
      $scope.sketches = data; // may have to JSON decode it first
    }); 
  }])
;
