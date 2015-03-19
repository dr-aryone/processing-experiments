// simple app to cause paths to load various processing sketches
var app = angular.module('sketches', ['ngRoute']);

app
  .config(['$routeProvider', function($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'partials/rootPartial.html'
      })
      .when('/chaos-gallery', {
        templateUrl: 'partials/galleryPartial.html',
        controller: 'galleryController'
      })
      .when('/sketch/:sketch', {
        templateUrl: 'partials/sketchPartial.html',
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
    var canvas = document.getElementById('sketch-canvas');
    pdeService.getPdeList(function(sketches){
      $scope.sketch = $.grep(sketches, function(s){ return s.routeParam == $routeParams.sketch; })[0];
      console.log('loading', $scope.sketch.name)

      pdeService.getPde($scope.sketch.routeParam, function(data) {
        var compiledSketch = Processing.compile(data);
        console.log(canvas);
        new Processing(canvas, compiledSketch);
        document.getElementById('canvas-container').style.width = canvas.width+"px";
      }, function(){
        console.error($routeParams.sketch + ' not found!');
      });
    });
  }])
  .controller('navbarController', ['$scope', 'pdeService', function($scope, pdeService) {
    $scope.sketches = [];
    pdeService.getPdeList(function(data){
      $scope.sketches = data;
    }); 
  }])
  .controller('galleryController', ['$scope', function($scope) {
    $scope.imgs = [
      'tri',
      'pent',
      'hex',
      'hept',
      'oct',
      'non',
      'dec'
    ];
  }])
;


function canvasToImg(id) {
  console.log('saving img');
  var canvas = document.getElementById(id);
  var img    = canvas.toDataURL("image/png");
  var win    = window.open(img);
}
