import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/images.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/view/auth/login.dart';
import 'package:flutter_application_breedersweb/view/cow_detail.dart';
import 'package:flutter_application_breedersweb/view/drawer/analytics/analytics.dart';
import 'package:flutter_application_breedersweb/view/drawer/new_users.dart';
import 'package:flutter_application_breedersweb/view/drawer/statics.dart';
import 'package:flutter_application_breedersweb/view/widget/request_tile.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, String>> herds = [
    {'name': 'Sunny Ranch', 'location': 'California', 'headScore': '50'},
    {'name': 'Blue Meadows', 'location': 'Texas', 'headScore': '30'},
    {'name': 'Golden Field', 'location': 'Nevada', 'headScore': '40'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: Row(
        children: [
          // Permanent Drawer
          Container(
            width: 15.w,
            color: AppColors.grey.withOpacity(0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: DrawerHeader(
                    child:Image.asset(AppImages.logo)
                  ),
                ),
                ListTile(
                  title: Text('Dashboard',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 4.sp,
              ),),
                  onTap: () {
                  AppCustomNavigator.replace(context, Home());
                  },
                ),
                ListTile(
                  title: Text('Permissions',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 4.sp,
              ),),
                  onTap: () {
                   AppCustomNavigator.push(context, NewUsers());
                  },
                ),
                ListTile(
                  title: Text('Analytics',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 4.sp,
              ),),
                  onTap: () {
                  AppCustomNavigator.push(context, Analytics());
                  },
                ),
              //   ListTile(
              //     title: Text('History',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              //   fontSize: 4.sp,
              // ),),
              //     onTap: () {
              //       // Navigate to History
              //     },
              //   ),
                ListTile(
                  title: Text('Statics and History',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 4.sp,
              ),),
                  onTap: () {
                    AppCustomNavigator.push(context, Statics());
                  },
                ),
                 ListTile(
                  title: Text('Logout',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 4.sp,
              ),),
                  onTap: () {
                    AppCustomNavigator.replace(context, const LoginScreen());
                  },
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.all(10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 700),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'All Herds',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontSize: 6.sp,
                                      ),
                                ),
                                Container(
                                  height: 90.h,
                                  child: ListView.builder(
                                    itemCount: herds.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final herd = herds[index];
                                      return Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: AppColors.grey,
                                              ),
                                            ),
                                            child: ListTile(
                                              onTap: () {
                                                AppCustomNavigator.push(context,
                                                    HerdDetailPage(herd: herd));
                                              },
                                              trailing: Text(
                                                '${herd['headScore']} Head',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(fontSize: 2.sp),
                                              ),
                                              title: Text(
                                                "Ranch: ${herd['name']}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(fontSize: 4.sp),
                                              ),
                                              subtitle: Text(
                                                'Location: ${herd['location']}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(fontSize: 4.sp),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                         
                          ),
                        ),
                       
                        SizedBox(width: 2.w),
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 700),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'New Users Request',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontSize: 6.sp,
                                        ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      children: [
                                        for (int i = 0; i <= 6; i++)
                                          AcceptRejectListTile(
                                            name: 'umer@gmail.com',
                                            onAccept: () {
                                              print('Accepted John Doe');
                                            },
                                            onReject: () {
                                              print('Rejected John Doe');
                                            },
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
