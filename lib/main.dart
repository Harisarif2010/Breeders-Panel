import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/provider/auth_provider.dart';
import 'package:flutter_application_breedersweb/provider/herd_detail_provider.dart';
import 'package:flutter_application_breedersweb/provider/home_provider.dart';
import 'package:flutter_application_breedersweb/provider/splash_provider.dart';
import 'package:flutter_application_breedersweb/provider/user_herd_provider.dart';
import 'package:flutter_application_breedersweb/splash.dart';
import 'package:flutter_application_breedersweb/view/auth/login.dart';
import 'package:flutter_application_breedersweb/view/home.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDkmMy5jXAxWyLiQlnZ997GW2wRnSxAagM",
      appId: "1:904534866902:web:16b783650ffd185205c277",
      messagingSenderId: "904534866902",
      projectId: "breedex-8ce46",
      )

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => LoadingProvider()),
            ChangeNotifierProvider(create: (context) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => HomeProvider()),
            ChangeNotifierProvider(create: (_) => HerdDetailProvider()),
            ChangeNotifierProvider(create: (_) => UserHerdProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Breedex',
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.white,
              textTheme: TextTheme(
                displaySmall: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
                headlineLarge: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                headlineMedium: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                headlineSmall: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                bodyLarge: GoogleFonts.montserrat(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                bodyMedium: GoogleFonts.montserrat(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                bodySmall: GoogleFonts.montserrat(
                  fontSize: 6.sp,
                  fontWeight: FontWeight.w300,
                  color: AppColors.black,
                ),
                
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
              useMaterial3: true,
            ),
           // home:SplashScreen(),
          home: Home(),
          ));
    });
  }
}