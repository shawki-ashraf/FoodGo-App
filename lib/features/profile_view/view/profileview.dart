import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/core/constants/colors.dart';
import 'package:foodapp/features/auth_view/Login_view/view/login_view.dart';
import 'package:foodapp/features/profile_view/bussines_logic_layer/cubit/profile_cubit.dart';
import 'package:foodapp/features/profile_view/widgets/customtext_profilefiled.dart';
import 'package:foodapp/features/profile_view/widgets/profilebottom.dart';
import 'package:gap/gap.dart';

class Profileview extends StatefulWidget {
  const Profileview({super.key});

  @override
  State<Profileview> createState() => _ProfileviewState();
}

class _ProfileviewState extends State<Profileview> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController visaController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isLogoutLoading = false;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  void fillControllers(profile) {
    nameController.text = profile.username;
    emailController.text = profile.email;
    addressController.text = profile.address;
    visaController.text = profile.visa;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          fillControllers(state.profile);
        }

        if (state is ProfileEditLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      state.msg,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is ProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          isLogoutLoading = false;
        }
        if (state is ProfileLoggedOut) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginView(), // صفحة الـ login
            ),
            (route) => false, // يمسح كل الصفحات السابقة
          );
        }
      },
      builder: (context, state) {
        bool isEditLoading = state is ProfileUpdating;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.primery,
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              children: [
                Gap(30.h),
                Center(
                  child: SvgPicture.asset(
                    'assets/Foodgo.svg',
                    color: Colors.white,
                    height: 80.h,
                  ),
                ),
                Gap(30.h),

                /// White Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.primery,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: state is ProfileLoading
                      ? Column(
                          children: [
                            // Skeleton loader for Name
                            Container(
                              width: double.infinity,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            Gap(15.h),
                            // Skeleton loader for Email
                            Container(
                              width: double.infinity,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            Gap(15.h),
                            // Skeleton loader for Address
                            Container(
                              width: double.infinity,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            Gap(15.h),
                            // Skeleton loader for Visa
                            Container(
                              width: double.infinity,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            Gap(25.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 150.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                Container(
                                  width: 150.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            CustomTextFieldProfile(
                              controller: nameController,
                              label: 'Name',
                              icon: const Icon(CupertinoIcons.profile_circled),
                            ),
                            Gap(15.h),
                            CustomTextFieldProfile(
                              controller: emailController,
                              label: 'Email',
                              icon: const Icon(Icons.email),
                            ),
                            Gap(15.h),
                            CustomTextFieldProfile(
                              controller: addressController,
                              label: 'Address',
                              icon: const Icon(Icons.home),
                            ),
                            Gap(15.h),
                            CustomTextFieldProfile(
                              controller: visaController,
                              label: 'Visa',
                              icon: const Icon(Icons.credit_card),
                            ),
                            Gap(25.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                /// Edit Profile Button
                                InkWell(
                                  onTap: isEditLoading
                                      ? null
                                      : () {
                                          context
                                              .read<ProfileCubit>()
                                              .updateProfile(
                                                name: nameController.text,
                                                phone: "",
                                                email: emailController.text,
                                                address: addressController.text,
                                                visa: visaController.text,
                                              );
                                        },
                                  child: Container(
                                    width: 150.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.miniblac,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    alignment: Alignment.center,
                                    child: isEditLoading
                                        ? const SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const Text(
                                            'Edit Profile',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),

                                /// Log Out Button
                                ProfileButton(
                                  text: "Logout",
                                  color: Colors.red,
                                  borderColor: Colors.red,
                                  isLoading: isloading,
                                  onTap: () async {
                                    setState(() {
                                      isloading = true;
                                    });

                                    await context.read<ProfileCubit>().logout();
                                    setState(() {
                                      isLogoutLoading = false;
                                    });

                                    setState(() {
                                      isloading = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(''),
            centerTitle: true,
          ),
        );
      },
    );
  }
}
