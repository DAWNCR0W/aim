import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/regist_bloc.dart';
import '../../domain/usecases/register_user.dart';
import '../../data/repository/regist_repository_impl.dart';
import '../../../main/presentation/pages/main_page.dart';

class RegistPage extends StatelessWidget {
  const RegistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => RegistBloc(registerUser: RegisterUser(RegistRepositoryImpl())),
      child: Scaffold(
        appBar: AppBar(title: const Text("회원가입")),
        body: const Padding(padding: EdgeInsets.all(16.0), child: RegistForm()),
      ),
    );
  }
}

class RegistForm extends StatelessWidget {
  const RegistForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistBloc, RegistState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainPage()),
          );
        } else if (state.isFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("회원가입 실패")));
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<RegistBloc, RegistState>(
              buildWhen:
                  (previous, current) =>
                      previous.id != current.id ||
                      previous.idError != current.idError,
              builder: (context, state) {
                return TextField(
                  onChanged:
                      (value) => context.read<RegistBloc>().add(
                        RegistIdChanged(value),
                      ),
                  decoration: InputDecoration(
                    labelText: "ID",
                    errorText: state.idError,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<RegistBloc, RegistState>(
              buildWhen:
                  (previous, current) =>
                      previous.password != current.password ||
                      previous.passwordError != current.passwordError,
              builder: (context, state) {
                return TextField(
                  onChanged:
                      (value) => context.read<RegistBloc>().add(
                        RegistPasswordChanged(value),
                      ),
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                    errorText: state.passwordError,
                  ),
                  obscureText: true,
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<RegistBloc, RegistState>(
              buildWhen:
                  (previous, current) =>
                      previous.phone != current.phone ||
                      previous.phoneError != current.phoneError,
              builder: (context, state) {
                return TextField(
                  onChanged:
                      (value) => context.read<RegistBloc>().add(
                        RegistPhoneChanged(value),
                      ),
                  decoration: InputDecoration(
                    labelText: "핸드폰 번호",
                    errorText: state.phoneError,
                  ),
                  keyboardType: TextInputType.phone,
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<RegistBloc, RegistState>(
              buildWhen:
                  (previous, current) =>
                      previous.email != current.email ||
                      previous.emailError != current.emailError,
              builder: (context, state) {
                return TextField(
                  onChanged:
                      (value) => context.read<RegistBloc>().add(
                        RegistEmailChanged(value),
                      ),
                  decoration: InputDecoration(
                    labelText: "이메일",
                    errorText: state.emailError,
                  ),
                  keyboardType: TextInputType.emailAddress,
                );
              },
            ),
            const SizedBox(height: 32),
            BlocBuilder<RegistBloc, RegistState>(
              builder: (context, state) {
                return state.isSubmitting
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: () {
                        context.read<RegistBloc>().add(RegistSubmitted());
                      },
                      child: const Text("회원가입"),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
