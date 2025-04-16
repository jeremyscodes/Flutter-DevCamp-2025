import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:my_app/Services/login_service.dart';
import 'package:my_app/repository/auth_repository.dart';
import 'package:my_app/screens/login/bloc/login_bloc.dart';
import 'package:my_app/screens/login/bloc/login_state.dart';
import 'package:my_app/widgets/BlueGradientButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(28, 36, 53, 1),
        body: BlocProvider(
          create: (context) =>
              LoginBloc(authRepository: AuthRepository(AuthService())),
          child: BlocListener<LoginBloc, LoginState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == FormzStatus.submissionSuccess) {
                Navigator.pushReplacementNamed(context, '/singleProductPage');
              } else if (state.status == FormzStatus.submissionFailure) {
                SnackBar(content: Text(state.errorMessage ?? 'Login failed'));
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.1),
                        SvgPicture.asset('lib/assets/logo.svg'),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02),
                        const Text(
                          "InsureTechGuard",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.03),
                        Column(
                          children: <Widget>[
                            _StyledTextField(
                              label: "Email",
                              eventBuilder: (value) => EmailChanged(value),
                              autoFocus: true,
                              obscureText: false,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.02),
                            _StyledTextField(
                              label: "Password",
                              eventBuilder: (value) => PasswordChanged(value),
                              autoFocus: false,
                              obscureText: true,
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02),
                        BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                          return BlueGradientButton(
                            text: "Login",
                            onPressed: state.isButtonEnabled
                                ? () {
                                    context
                                        .read<LoginBloc>()
                                        .add(LoginSubmitted());
                                  }
                                : null,
                          );
                        }),
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ));
  }
}

class _StyledTextField extends StatefulWidget {
  final String label;
  final bool autoFocus;
  final bool obscureText;
  final LoginEvent Function(String value) eventBuilder;

  const _StyledTextField({
    super.key,
    this.autoFocus = false,
    this.obscureText = false,
    required this.label,
    required this.eventBuilder,
  });

  @override
  State<_StyledTextField> createState() => _StyledTextFieldState();
}

class _StyledTextFieldState extends State<_StyledTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.85,
      child: TextField(
        autofocus: widget.autoFocus,
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          // `value` is the latest text entered by the user
          context.read<LoginBloc>().add(widget.eventBuilder(value));
        },
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.white),
          suffixIcon: widget.obscureText ?
          GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          ) : null,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
        ),
      ),
    );
  }
}
