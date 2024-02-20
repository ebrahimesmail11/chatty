abstract class AuthState{}
class LogInInitialState extends AuthState{}
class LogInLoadingState extends AuthState{}
class LogInSuccessState extends AuthState{}
class LogInFailureState extends AuthState{
  final String errorMessage;
  LogInFailureState(this.errorMessage);
}
class SignUpInitialState extends AuthState{}
class SignUpLoadingState extends AuthState{}
class SignUpSuccessState extends AuthState{}
class SignUpFailureState extends AuthState{
  final String errorMessage;
  SignUpFailureState(this.errorMessage);
}


