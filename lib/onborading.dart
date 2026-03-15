import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/features/auth_view/Login_view/view/login_view.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          /// الخلفية
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFF7F7F), Color(0xFFD32F2F)],
              ),
            ),
          ),

          /// اللوجو
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.25),
              child: SvgPicture.asset(
                'assets/Foodgo.svg',
                width: width * 0.45,
                color: Colors.white,
              ),
            ),
          ),

          /// البرجر الكبير
          Positioned(
            bottom: -20, // يخرج قليلاً خارج الشاشة
            left: -5,
            child: Image.asset('assets/burger_.png', height: height * 0.32),
          ),

          /// البرجر الصغير
          Positioned(
            bottom: -10,
            right: 30,
            child: Image.asset(
              'assets/burger_small.png',
              height: height * 0.22,
            ),
          ),
        ],
      ),
    );
  }
}
