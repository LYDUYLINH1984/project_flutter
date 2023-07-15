import 'package:flutter_app_sale_25042023/common/base/base_bloc.dart';
import 'package:flutter_app_sale_25042023/common/base/base_event.dart';
import 'package:flutter_app_sale_25042023/data/repository/authentication_repository.dart';
import 'package:flutter_app_sale_25042023/presentation/page/sign_in/bloc/sign_in_event.dart';

class SignInBloc extends BaseBloc {

  AuthenticationRepository? _repository;

  void setAuthenticationRepository(AuthenticationRepository repository){
    _repository = repository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch(event.runtimeType) {
      case SignInEvent:
        executeSignIn(event as SignInEvent);
        break;
    }
  }

  void executeSignIn(SignInEvent event) {

  }
}