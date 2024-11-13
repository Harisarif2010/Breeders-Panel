import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/images.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/provider/splash_provider.dart';
import 'package:flutter_application_breedersweb/view/auth/login.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// ignore_for_file: library_private_types_in_public_api

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
    Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
   AppCustomNavigator.replace(context , LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              AppImages.logo, 
              width: 25.w,
              height: 25.h,
            ),
            Consumer<LoadingProvider>(
              builder: (context, loader, _) {
                return loader.isLoading
                    ?  SpinKitCircle(
                size: 20.sp,
                color: AppColors.primary,
              )
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}