import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/regist_user.dart';
import '../../domain/usecases/register_user.dart';

part 'regist_event.dart';

part 'regist_state.dart';

class RegistBloc extends Bloc<RegistEvent, RegistState> {
  final RegisterUser registerUser;

  RegistBloc({required this.registerUser}) : super(RegistState.initial()) {
    on<RegistIdChanged>((event, emit) {
      final error = _validateId(event.id);
      emit(state.copyWith(id: event.id, idError: error));
    });
    on<RegistPasswordChanged>((event, emit) {
      final error = _validatePassword(event.password);
      emit(state.copyWith(password: event.password, passwordError: error));
    });
    on<RegistPhoneChanged>((event, emit) {
      final error = _validatePhone(event.phone);
      emit(state.copyWith(phone: event.phone, phoneError: error));
    });
    on<RegistEmailChanged>((event, emit) {
      final error = _validateEmail(event.email);
      emit(state.copyWith(email: event.email, emailError: error));
    });
    on<RegistSubmitted>((event, emit) async {
      final idError = _validateId(state.id);
      final passwordError = _validatePassword(state.password);
      final phoneError = _validatePhone(state.phone);
      final emailError = _validateEmail(state.email);
      if (idError != null ||
          passwordError != null ||
          phoneError != null ||
          emailError != null) {
        emit(
          state.copyWith(
            idError: idError,
            passwordError: passwordError,
            phoneError: phoneError,
            emailError: emailError,
          ),
        );
      } else {
        emit(state.copyWith(isSubmitting: true));
        try {
          await registerUser(
            RegistUser(
              id: state.id,
              password: state.password,
              phone: state.phone,
              email: state.email,
            ),
          );
          emit(state.copyWith(isSubmitting: false, isSuccess: true));
        } catch (_) {
          emit(state.copyWith(isSubmitting: false, isFailure: true));
        }
      }
    });
  }

  String? _validateId(String id) {
    if (id.length < 7) return "ID는 영문 7자 이상이어야 합니다.";
    if (!RegExp(r'^[A-Za-z]+$').hasMatch(id)) return "ID는 영문으로만 구성되어야 합니다.";
    return null;
  }

  String? _validatePassword(String password) {
    if (password.length < 10) return "비밀번호는 10자 이상이어야 합니다.";
    if (!RegExp(r'[A-Z]').hasMatch(password)) return "비밀번호는 대문자를 포함해야 합니다.";
    if (!RegExp(r'[a-z]').hasMatch(password)) return "비밀번호는 소문자를 포함해야 합니다.";
    if (!RegExp(r'[0-9]').hasMatch(password)) return "비밀번호는 숫자를 포함해야 합니다.";
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password))
      return "비밀번호는 특수문자를 포함해야 합니다.";
    return null;
  }

  String? _validatePhone(String phone) {
    if (!RegExp(r'^(010|011|016|017|018|019)-?\d{3,4}-?\d{4}$').hasMatch(phone))
      return "핸드폰 번호 형식이 올바르지 않습니다.";
    return null;
  }

  String? _validateEmail(String email) {
    if (!RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w]{2,4}$').hasMatch(email))
      return "이메일 형식이 올바르지 않습니다.";
    return null;
  }
}
