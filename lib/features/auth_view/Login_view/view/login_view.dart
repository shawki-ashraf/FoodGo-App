import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodapp/core/constants/colors.dart';
import 'package:foodapp/features/auth_view/Login_view/bussines_logic_layer/cubit/login_cubit.dart';
import 'package:foodapp/features/auth_view/view/sign_view.dart';
import 'package:foodapp/features/checkcart_view/widgets/checkbottom.dart';
import 'package:foodapp/features/home_view/bussines_logic_layer/home_cubit.dart';
import 'package:foodapp/root.dart';
import 'package:foodapp/shared/customText_field.dart';
import 'package:foodapp/shared/custom_text.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    email.text = "shawki@gmail.com";
    password.text = "shawki12345678";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 150.h, // بدل 200
              left: 20.w,
              right: 20.w,
            ),
            child: Column(
              children: <Widget>[
                Center(
                  child: SvgPicture.asset(
                    'assets/Foodgo.svg',
                    color: Colors.red,
                    height: 80.h,
                  ),
                ),
                Gap(20.h),
                CustomText(
                  text: "Order Your Favorite Food easily",
                  size: 16.sp,
                  color: AppColors.grey,
                  weight: FontWeight.normal,
                ),
                Gap(40.h),
                CustomTextfield(
                  hint: "Email Address",
                  controller: email,
                  isPassword: false,
                ),
                Gap(25.h),
                CustomTextfield(
                  hint: "Password",
                  isPassword: true,
                  controller: password,
                ),
                Gap(10.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: AppColors.primery,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                Gap(25.h),

                /// 🔥 BlocConsumer محدود على الزر فقط
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (BuildContext context, LoginState state) {
                    if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (state is LoginSuccess) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => HomeCubit(),
                            child: const Root(),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (BuildContext context, LoginState state) {
                    if (state is LoginLoading) {
                      return Center(
                        child: SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: const CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    } else if (state is Loaded) {
                      return Checkbook(
                        operation: "Sign in",
                        onAddToCart: state is LoginLoading
                            ? null
                            : () {
                                final String emailText = email.text.trim();
                                final String passwordText = password.text
                                    .trim();

                                if (emailText.isEmpty || passwordText.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Please enter email and password",
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                context.read<LoginCubit>().login(
                                  emailText,
                                  passwordText,
                                );
                              },
                      );
                    }

                    return Checkbook(
                      operation: "Sign in",
                      onAddToCart: () {
                        final String emailText = email.text.trim();
                        final String passwordText = password.text.trim();

                        if (emailText.isEmpty || passwordText.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter email and password"),
                            ),
                          );
                          return;
                        }

                        context.read<LoginCubit>().login(
                          emailText,
                          passwordText,
                        );
                      },
                    );
                  },
                ),
                Gap(30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don’t have an account? ",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateAccountView(),
                          ),
                        );
                      },
                      child: CustomText(
                        text: 'Sign Up',
                        size: 16.sp,
                        color: AppColors.primery,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Gap(40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
