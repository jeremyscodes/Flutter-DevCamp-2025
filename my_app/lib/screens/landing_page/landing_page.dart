import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_app/repository/auth_repository.dart';
import 'package:my_app/screens/landing_page/bloc/landing_bloc.dart';
import 'package:my_app/widgets/BlueGradientButton.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPage extends StatefulWidget {
  final AuthRepository authRepository;

  const LandingPage({super.key, required this.authRepository});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    super.initState();
    context.read<LandingBloc>().add(GetAndValidateToken());
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() {
            _supportState = isSupported;
          }),
        );
  }

  Future<void> _handleLoginFlow(BuildContext context, bool validToken) async {
    if (!validToken) {
      Navigator.pushNamed(context, '/login');
      return;
    }
    await _getAvailableBiometrics();
    final didAuthenticate = await _authenticate();
    if (didAuthenticate) {
      Navigator.pushReplacementNamed(context, '/singleProductPage');
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Biometric authentication failed')),
      );
    }
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(28, 36, 53, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_supportState)
                const Text('This device is supported')
              else
                const Text('This device is NOT supported'),
              SafeArea(
                  child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05)),
              SvgPicture.asset('lib/assets/logo.svg'),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              const Text(
                "InsureTechGuard?",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
              BlocBuilder<LandingBloc, LandingState>(
                builder: (context, state) {
                  return BlueGradientButton(
                    text: "Login",
                    onPressed: () =>
                        _handleLoginFlow(context, state.validToken),
                    // _authenticate
                  );
                },
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              const Text(
                "Don't have an account?",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.07),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/singleProductPage");
                },
                child: const Text(
                  "Continue as guest",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    print("List of available biometrics: $availableBiometrics");

    if (!mounted) {
      return;
    }
  }

  Future<bool> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Confirm fingerprint to continue',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      print("Authenticated : $authenticated");
      if (authenticated == true) {
        return true;
      }
      return false;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
