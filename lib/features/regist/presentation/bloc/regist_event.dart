part of 'regist_bloc.dart';

abstract class RegistEvent extends Equatable {
  const RegistEvent();

  @override
  List<Object> get props => [];
}

class RegistIdChanged extends RegistEvent {
  final String id;

  const RegistIdChanged(this.id);

  @override
  List<Object> get props => [id];
}

class RegistPasswordChanged extends RegistEvent {
  final String password;

  const RegistPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class RegistPhoneChanged extends RegistEvent {
  final String phone;

  const RegistPhoneChanged(this.phone);

  @override
  List<Object> get props => [phone];
}

class RegistEmailChanged extends RegistEvent {
  final String email;

  const RegistEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class RegistSubmitted extends RegistEvent {}
