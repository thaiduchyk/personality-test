(function() {
    'use strict';
    angular.module('app')
        .controller('TestController', [
            '$scope', '$rootScope', '$auth', '$state', '$timeout', '$uibModal',
            function($scope, $rootScope, $auth, $state, $timeout, $uibModal){

                $rootScope.resultsArray = [];
                $scope.name = $rootScope.userInfo.name;
                // $scope.surname = $rootScope.userInfo.surname;
                $scope.count = 1;
                $scope.buttonText = "Next";
                $scope.array = ["You believe most people have a short attention span",
                    "You are interested in people histories",
                    "You always root for the underdog",
                    "You like to figure out the best way to get things done",
                    "You like to talk about things everyone can agree on",
                    "No one can tell you what to think, you decide",
                    "You rack up points for your daily score",
                    "You find a wide variety of things very interesting",
                    "Your faith sustains you",
                    "You intuitively see the perspectives of others",
                    "You feel being a focused expert is better than a broad generalist"];
                $scope.question = $scope.array[0];
                $scope.testInProgress = true;

                $scope.nextQuestion = function(){
                    var item = {
                        question: $scope.question,
                        value: $scope.minSlider.value
                    };
                    $rootScope.resultsArray.push(item);
                    if ($scope.testInProgress) {
                        $scope.minSlider.value = 0;
                        $scope.question = $scope.array[$scope.count];
                        $scope.count += 1;
                        if ($scope.count == $scope.array.length) {
                            $scope.buttonText = "Finish";
                            $scope.testInProgress = false;
                        };
                    } else {
                        $state.go('auth.results');
                    };

                };
                $scope.authSignOut = function() {
                    $auth.signOut()
                        .then(function(resp) {
                            console.log("Signed out succesfully");
                            $state.go('home');
                        })
                        .catch(function(resp) {
                            console.log("Sign out error");
                        });
                };
                // Minimal slider config
                $scope.minSlider = {
                    value: 0,
                    options: {
                        floor: -50,
                        ceil: 50
                    }
                };
            }]);
}());