abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final dynamic response;

  SignInSuccess({required this.response});
}

class SignInFailure extends SignInState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}