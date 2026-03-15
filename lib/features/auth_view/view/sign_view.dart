import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/core/constants/colors.dart';
import 'package:foodapp/features/checkcart_view/widgets/checkbottom.dart';
import 'package:foodapp/shared/customText_field.dart';
import 'package:foodapp/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final TextEditingController email = TextEditingController();
  final TextEditingController username =
      TextEditingController(); // 🟢 أضفنا Username
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          /// 🍔 Logo أحمر
          Positioned(
            top: size.height * 0.21, // 🔻 منخفض شوية
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/Foodgo.svg',
              color: Colors.red,
              width: 180,
            ),
          ),

          /// ⬜ White Glass Card
          Positioned(
            top: size.height * 0.30,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CustomText(
                          text: "Create Your Account",
                          size: 22,
                          color: AppColors.miniblac,
                          weight: FontWeight.bold,
                        ),

                        const Gap(5),

                        CustomText(
                          text: "Sign up to get started",
                          size: 16,
                          color: AppColors.grey,
                          weight: FontWeight.normal,
                        ),
                        const Gap(50),

                        CustomTextfield(
                          hint: "Email Address",
                          controller: email,
                          isPassword: false,
                        ),

                        const Gap(25),

                        CustomTextfield(
                          hint: "Username",
                          controller: username,
                          isPassword: false,
                        ),

                        const Gap(25),

                        CustomTextfield(
                          hint: "Password",
                          isPassword: true,
                          controller: password,
                        ),

                        const Gap(30),

                        Checkbook(
                          onAddToCart: () {},
                          operation: "Create Account",
                        ),

                        const Gap(30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Already have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const CustomText(
                                text: 'Sign In',
                                size: 16,
                                color: Colors.red,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const Gap(40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
