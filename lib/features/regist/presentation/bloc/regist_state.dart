part of 'regist_bloc.dart';

class RegistState extends Equatable {
  final String id;
  final String password;
  final String phone;
  final String email;
  final String? idError;
  final String? passwordError;
  final String? phoneError;
  final String? emailError;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const RegistState({
    required this.id,
    required this.password,
    required this.phone,
    required this.email,
    required this.idError,
    required this.passwordError,
    required this.phoneError,
    required this.emailError,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory RegistState.initial() {
    return const RegistState(
      id: "",
      password: "",
      phone: "",
      email: "",
      idError: null,
      passwordError: null,
      phoneError: null,
      emailError: null,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegistState copyWith({
    String? id,
    String? password,
    String? phone,
    String? email,
    String? idError,
    String? passwordError,
    String? phoneError,
    String? emailError,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return RegistState(
      id: id ?? this.id,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      idError: idError,
      passwordError: passwordError,
      phoneError: phoneError,
      emailError: emailError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props => [
    id,
    password,
    phone,
    email,
    idError,
    passwordError,
    phoneError,
    emailError,
    isSubmitting,
    isSuccess,
    isFailure,
  ];
}
