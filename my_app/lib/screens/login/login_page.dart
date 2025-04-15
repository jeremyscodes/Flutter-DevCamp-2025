import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          create: (context) => LoginBloc(),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(32.0),
                child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02),
                      SvgPicture.asset('lib/assets/logo.svg'),
                      const Spacer(),
                      const Text(
                        "InsureTechGuard?",
                        style: TextStyle(color: Colors.white),
                      ),
                      Column(
                        children: <Widget>[
                          _StyledTextField(
                            label: "Email",
                            eventBuilder: (value) => EmailChanged(value),
                            obscureText: false,
                          ),
                          _StyledTextField(
                            label: "Password",
                            eventBuilder: (value) => PasswordChanged(value),
                            obscureText: true,
                          ),
                        ],
                      ),
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
        ));
  }
}

class _StyledTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final LoginEvent Function(String value) eventBuilder;

  const _StyledTextField({
    super.key,
    this.obscureText = false,
    required this.label,
    required this.eventBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.85,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          // `value` is the latest text entered by the user
          context.read<LoginBloc>().add(eventBuilder(value));
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
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
