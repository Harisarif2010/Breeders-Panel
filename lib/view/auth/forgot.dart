import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/view/auth/login.dart';
import 'package:flutter_application_breedersweb/view/widget/custom_button.dart';
import 'package:flutter_application_breedersweb/view/widget/textfield.dart';
import 'package:sizer/sizer.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  bool obsecurePassword = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(50,),
            ),
             child: IconButton(onPressed: (){AppCustomNavigator.pop(context);}, icon:  Icon(Icons.arrow_back),)
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               
                children: [
               //   SizedBox(height: .h),
                  Text(
                    'Forgot password?',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontSize: 8.sp
                            ),
                  ),
                  Text(
                    'Don’t worry! It happens. Please enter the email associated with your account.',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 2.sp
                            ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Email Address',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 4.sp
                            ),
                  ),
                    SizedBox(height: 1.h),
                  const CustomTextField(      
                    name: 'email',
                    hintText: 'Your email',
                    fillColor: AppColors.white, enableBorder: true,
                  ),
                 
                  SizedBox(height: 3.h),
                
                  Center(
                    child: CustomButton(
                        height: 8.h,
                          width: 10.w,
                          textStyle: TextStyle(fontSize: 3.sp,color: AppColors.white),
                      text: 'Send Code',
                      onTap: () {
                      //  AppCustomNavigator.push(context, OtpScreen());
                      },
                    ),
                  ),
                  
                   SizedBox(height: 42.h),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: GestureDetector(
                        onTap: (){
                           AppCustomNavigator.replace(context,LoginScreen());
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'Remember Password? ',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 2.sp
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Login Now',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold,fontSize: 2.sp),
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
    ));
  }
}