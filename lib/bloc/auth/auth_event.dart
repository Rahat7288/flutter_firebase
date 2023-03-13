// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  // object can be null
  List<Object?> get props => [];
}

class AuthStateChangedEvent extends AuthEvent {
  final fbAuth.User? user;
  AuthStateChangedEvent({
    this.user,
  });
  @override
  //  object can be null
  List<Object?> get props => [user];
}

class SignOutRequestEvent extends AuthEvent {}
