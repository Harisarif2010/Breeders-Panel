
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/images.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/view/auth/forgot.dart';
import 'package:flutter_application_breedersweb/view/auth/login.dart';
import 'package:flutter_application_breedersweb/view/home.dart';
import 'package:flutter_application_breedersweb/view/widget/custom_button.dart';
import 'package:flutter_application_breedersweb/view/widget/textfield.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obsecurePassword = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'Register to get started',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 8.sp,
                      )
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Username',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 4.sp,
                      )
                    ),
                    const CustomTextField(
                      name: 'username',
                      hintText: '@username',
                      fillColor: AppColors.white, enableBorder: true,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'Email Address',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 4.sp,
                      )
                    ),
                    const CustomTextField(
                      name: 'email',
                      hintText: 'Your email',
                      fillColor: AppColors.white, enableBorder: true,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 4.sp,
                      )
                    ),
                    CustomTextField(
                      name: 'password',
                      hintText: '*******',
                      obscureText: obsecurePassword,
                      fillColor: AppColors.white,
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
                      ), enableBorder: true,
                    ),
                     SizedBox(height: 3.h),
                    Text(
                      'Confirm Password',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 4.sp,
                      )
                    ),
                    CustomTextField(
                      enableBorder: true,
                      name: 'Confirm Password',
                      hintText: '******',
                      obscureText: obsecurePassword,
                      fillColor: AppColors.white,
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
                      child: TextButton(
                        child: Text(
                        'Forget Password?',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 2.sp,
                      )
                        ),
                        onPressed: (){
                         AppCustomNavigator.push(context, ForgotScreen());
                        }
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Center(
                      child: CustomButton(
                        height: 8.h,
                        width: 10.w,
                        text: 'Register',textStyle: TextStyle(fontSize: 3.sp,color: AppColors.white),
                        onTap: () {
                         AppCustomNavigator.replace(context, Home());
                        },
                      ),
                    ),
                    SizedBox(height: 3.h),
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
                          child: Text(
                            'Or Login with',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 2.sp,
                      )
                          ),
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
                        Container(
                          width: 7.w,
                          child: Image.asset(AppImages.facebook),
                        ),
                        Container(
                          width: 7.w,
                          child: Image.asset(AppImages.google),
                        ),
                        Container(
                          width: 7.w,
                          child: Image.asset(AppImages.apple),
                        ),
                      ],
                    ),
                      SizedBox(height: 2.h),
                     Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: GestureDetector(
                          onTap: (){
                             AppCustomNavigator.push(context,LoginScreen());
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Do have an account? ',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 2.sp
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: 'Login Now',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 2.sp),
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
      ),
    );
  }
}