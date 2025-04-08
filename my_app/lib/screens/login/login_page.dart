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

class _LoginPage extends State<LoginPage>  {
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
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                SvgPicture.asset('lib/assets/logo.svg'),
                const Spacer(),
                const Text(
                  "InsureTechGuard?",
                  style: TextStyle(color: Colors.white),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.85,
                      child: TextField(
                        onChanged: (value) {
                          context.read<LoginBloc>().add(EmailChanged(value));
                        },
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.85,
                      child: TextField(
                        onChanged: (value) {
                          context.read<LoginBloc>().add(PasswordChanged(value));
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                  return BlueGradientButton(
                    onPressed: state.isButtonEnabled
                        ? () {
                            context.read<LoginBloc>().add(LoginSubmitted());
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
