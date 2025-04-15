import 'package:flutter/material.dart';
import 'package:my_app/widgets/BlueGradientButton.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 36, 53, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SafeArea(child: SizedBox(height: MediaQuery.sizeOf(context).height * 0.05)),
            SvgPicture.asset('lib/assets/logo.svg'),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            const Text("InsureTechGuard?" , style: TextStyle(color: Colors.white),),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
            BlueGradientButton(
              text: "Login",
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            const Text("Don't have an account?" , style: TextStyle(color: Colors.white),),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.07 ),
            new GestureDetector(
              onTap: () {
                  Navigator.pushNamed(context, "/singleProductPage");
                },
              child: const Text("Continue as guest" , style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      )
    );
  }
}

