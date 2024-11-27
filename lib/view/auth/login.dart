// import 'package:flutter/material.dart';
// import 'package:flutter_application_breedersweb/constants/colors.dart';
// import 'package:flutter_application_breedersweb/constants/images.dart';
// import 'package:flutter_application_breedersweb/navigator.dart';
// import 'package:flutter_application_breedersweb/provider/auth_provider.dart';
// import 'package:flutter_application_breedersweb/provider/splash_provider.dart';
// import 'package:flutter_application_breedersweb/view/auth/forgot.dart';
// import 'package:flutter_application_breedersweb/view/auth/register.dart';
// import 'package:flutter_application_breedersweb/view/home.dart';
// import 'package:flutter_application_breedersweb/view/widget/custom_button.dart';
// import 'package:flutter_application_breedersweb/view/widget/textfield.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool obsecurePassword = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(maxWidth: 500), // Limit the width for web view
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 10.h),
//                   Text(
//                     'Login',
//                     style: Theme.of(context).textTheme.displaySmall!.copyWith(
//                       fontSize: 8.sp, // Increase font size for web
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     'Email Address',
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       fontSize: 4.sp,
//                     ),
//                   ),
//                   const CustomTextField(
//                     name: 'email',
//                     hintText: 'Your email',
//                     fillColor: AppColors.white,
//                     enableBorder: true,
//                   ),
//                   SizedBox(height: 3.h),
//                   Text(
//                     'Password',
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       fontSize: 4.sp,
//                     ),
//                   ),
//                   CustomTextField(
//                     name: 'password',
//                     hintText: 'Password',
//                     obscureText: obsecurePassword,
//                     fillColor: AppColors.white,
//                     enableBorder: true,
//                     suffixIcon: InkWell(
//                       onTap: () {
//                         setState(() {
//                           obsecurePassword = !obsecurePassword;
//                         });
//                       },
//                       child: Icon(
//                         obsecurePassword
//                             ? Icons.visibility_off_rounded
//                             : Icons.visibility_rounded,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 1.h),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: GestureDetector(
//                       onTap: () {
//                         AppCustomNavigator.push(context, ForgotScreen());
//                       },
//                       child: Text(
//                         'Forget Password?',
//                         style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                          fontSize: 2.sp,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: CustomButton(
//                       height: 8.h,
//                       width: 10.w,
//                       textStyle: TextStyle(fontSize: 3.sp,color: AppColors.white),
//                       text: 'Log in',
//                       textPadding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10),
//                       onTap: () {
//                      AppCustomNavigator.replace(context, Home());
//                       },
//                     ),
//                   ),
//                    SizedBox(height: 4.h),
//                 Row(
//                   children: [
//                     const Expanded(
//                       child: Divider(
//                         color: AppColors.grey,
//                         thickness: 1,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 4.sp),
//                       child: Text(
//                         'Or Login with',
//                         style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                            fontSize: 2.sp
//                         )
//                       ),
//                     ),
//                     const Expanded(
//                       child: Divider(
//                         color: AppColors.grey,
//                         thickness: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 2.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
                //  SizedBox(
                //       width: 7.w,
                //       child: GestureDetector(
                //         onTap: () async {
                //           final authProvider = Provider.of<AuthProvider>(context, listen: false);
                //           final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
                //           loadingProvider.setLoading(true);
                //           try {
                //             await authProvider.signInWithGoogle(context);
                //             if (authProvider.user != null) {
                //               AppCustomNavigator.replace(context, const Home());
                //             }
                //           } finally {
                //             loadingProvider.setLoading(false);
                //           }
                //         },
                //         child: Image.asset(AppImages.google),
                //       ),
                //     ),
//                     // Container(
//                     //   width: 7.w,
//                     //   child: Image.asset(AppImages.google),
//                     // ),
                   
//                   ],
//                 ),
//                  SizedBox(height: 2.h),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 2.h),
//                     child: GestureDetector(
//                       onTap: (){
//                         AppCustomNavigator.push(context,RegisterScreen());
//                       },
//                       child: Text.rich(
//                         TextSpan(
//                           text: 'Don’t have an account? ',
//                           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 2.sp
//                           ),
//                           children: <InlineSpan>[
//                             TextSpan(
//                               text: 'Register Now',
//                               style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 2.sp),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
             
//               ],
//             ),
//           ),
//         ),
//       ),
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/images.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/provider/splash_provider.dart';
import 'package:flutter_application_breedersweb/view/auth/forgot.dart';
import 'package:flutter_application_breedersweb/view/auth/register.dart';
import 'package:flutter_application_breedersweb/view/home.dart';
import 'package:flutter_application_breedersweb/view/widget/custom_button.dart';
import 'package:flutter_application_breedersweb/view/widget/textfield.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_breedersweb/provider/auth_provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obsecurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500), // Limit the width for web view
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 8.sp, // Increase font size for web
                        ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Email Address',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 4.sp,
                        ),
                  ),
                  CustomTextField(
                    controller: _emailController,
                    name: 'email',
                    hintText: 'Your email',
                    fillColor: AppColors.white,
                    enableBorder: true,
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 4.sp,
                        ),
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    name: 'password',
                    hintText: 'Password',
                    obscureText: obsecurePassword,
                    fillColor: AppColors.white,
                    enableBorder: true,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          obsecurePassword = !obsecurePassword;
                        });
                      },
                      child: Icon(
                        obsecurePassword
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        AppCustomNavigator.push(context, ForgotScreen());
                      },
                      child: Text(
                        'Forget Password?',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 2.sp,
                            ),
                      ),
                    ),
                  ),
                  Center(
                    child:    Consumer<LoadingProvider>(
                  builder: (context, loadingProvider, child) {
                    return Column(
                      children: [
                        CustomButton(
                             height: 8.h,
                      width: 10.w,
                      textStyle:
                          TextStyle(fontSize: 3.sp, color: AppColors.white),
                      text: 'Log in',
                      textPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10),
                          onTap: () async {
                            final authProvider = Provider.of<AuthProvider>(context, listen: false);
                            final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
                            loadingProvider.setLoading(true);
                            try {
                              await authProvider.loginWithEmailAndPassword(
                                context, 
                                _emailController.text,
                                _passwordController.text,
                              );

                              if (authProvider.user != null) {
                                AppCustomNavigator.replace(context, const Home());
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login failed: $e')),
                              );
                            } finally {
                              loadingProvider.setLoading(false);
                            }
                          },
                        ),
                        SizedBox(height: 1.h,),
                        if (loadingProvider.isLoading)
                          const CircularProgressIndicator(),
                      ],
                    );
                  },
                ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: AppColors.grey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.sp),
                        child: Text('Or Login with',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 2.sp,
                                    )),
                      ),
                      const Expanded(
                        child: Divider(
                          color: AppColors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                                      SizedBox(
                      width: 7.w,
                      child: GestureDetector(
                        onTap: () async {
                          final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
                          loadingProvider.setLoading(true);
                          try {
                            await authProvider.signInWithGoogle(context);
                            if (authProvider.user != null) {
                              AppCustomNavigator.replace(context, const Home());
                            }
                          } finally {
                            loadingProvider.setLoading(false);
                          }
                        },
                        child: Image.asset(AppImages.google),
                      ),
                    ),
                    ],
                  ),
                
                  SizedBox(height: 2.h),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: GestureDetector(
                        onTap: () {
                          AppCustomNavigator.push(context, RegisterScreen());
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'Don’t have an account? ',
                            style:
                                Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 2.sp,
                                    ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Register Now',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 2.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
