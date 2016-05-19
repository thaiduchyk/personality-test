(function() {
    'use strict';
    angular.module('app')
        .controller('HomeController', ['$rootScope', '$scope', '$auth', '$http', '$state', 'ngDialog', '$location', '$window',
            function($rootScope, $scope, $auth, $http, $state, ngDialog, $location, $window) {
                // debugger;
                $scope.images = {
                    fb: '/assets/fb.png',
                    in : '/assets/in.png',
                    mail: '/assets/mail.png',
                    fb_hov: '/assets/fb2.png',
                    in_hov: '/assets/in2.png',
                    mail_hov: '/assets/mail2.png',
                };

                $scope.formData = {};
                $scope.formValidation = {};
                $scope.formValidation.valid = false;
                $scope.signInData = {};
                $scope.errorMessage = "";
                $rootScope.userInfo = {};

                $scope.clearErrorMessage = function() {
                    $scope.errorMessage = "";
                };

                // $scope.clickToOpen = function(template) {
                //     ngDialog.open({ template: '/assets/temlates/'+template+'.html', className: 'ngdialog-theme-default', scope: $scope });
                //     $scope.tab=1;
                // };

                $scope.closeModal = function() {
                    $(".modal-backdrop").hide();
                };

                // $scope.clickToOpen = function(route) {
                //     $state.go('start');
                // };

                $scope.login = function() {
                    $auth.submitLogin($scope.loginForm)
                        .then(function(resp) {
                            // handle success response
                            $window.alert('success response');
                            $state.go('start');
                        })
                        .catch(function(resp) {
                            // handle error response

                            $window.alert('error response');
                        });
                }

                $scope.signin = function() {
                    $auth.registrationForm($scope.registrationForm)
                        .then(function(resp) {
                            // handle success response
                            $window.alert('success response');
                            $state.go('start');
                        })
                        .catch(function(resp) {
                            // handle error response

                            $window.alert('error response');
                        });
                }

                $scope.test = function() {
                    $window.alert('greeting');
                }



                // $scope.selectTab = function(setTab) {
                //     $scope.tab = setTab;
                // };
                // $scope.isSelected = function(checkTab) {
                //     return $scope.tab === checkTab;
                // };

                // $rootScope.$on('auth:login-success', function(ev, user) {
                //   console.log(user.name+' '+user.surname);
                //   alert('Welcome ' + user.name);
                // });
                // $scope.authSignin = function() {
                //     $auth.submitLogin($scope.signInData)
                //         .then(function(resp) {
                //             $rootScope.userInfo.name = resp.name;
                //             $rootScope.userInfo.surname = resp.surname;
                //             ngDialog.close();
                //             $state.go('auth.start');
                //         })
                //         .catch(function(resp) {
                //             $scope.errorMessage = "Incorrect login";
                //         });
                // };
                //
                // $scope.comparePasswords = function() {
                //     return $scope.formData.password == $scope.formData.password_confirmation;
                // };
                //
                // $scope.isFormValid = function() {
                //     return ($scope.formValidation.valid && $scope.comparePasswords());
                // };
                //
                // $scope.processForm = function() {
                //     $auth.submitRegistration($scope.formData)
                //         .then(function(resp) {
                //             $rootScope.userInfo.name = resp.name;
                //             $rootScope.userInfo.surname = resp.surname;
                //             console.log("success");
                //             ngDialog.close();
                //             $state.go('auth.start');
                //         })
                //         .catch(function(resp) {
                //             console.log("registration error");
                //         });
                // };
            }
        ]);


}());
