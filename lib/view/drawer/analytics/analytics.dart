
import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/view/cow_detail.dart';
import 'package:flutter_application_breedersweb/view/drawer/analytics/herd.dart';
import 'package:flutter_application_breedersweb/view/widget/request_tile.dart';
import 'package:sizer/sizer.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  bool obsecurePassword = true;
    final List<Map<String, String>> herds = [
    {'name': 'Sunny Ranch', 'location': 'California', 'headScore': '50'},
    {'name': 'Blue Meadows', 'location': 'Texas', 'headScore': '30'},
    {'name': 'Golden Field', 'location': 'Nevada', 'headScore': '40'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  leading: IconButton(onPressed: (){AppCustomNavigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new)),
 ),
      body: Center(
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  Column(
                    children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                  'Analytics',
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
                                                   UserHerd());
                                         
                                        },
                                        trailing: Text(
                                          ' Total Herds: ${herd['headScore']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(fontSize: 2.sp),
                                        ),
                                        title: Text(
                                          "Username: ${herd['name']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontSize: 4.sp),
                                        ),
                                        subtitle: Text(
                                          'email: ${herd['location']}',
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
                     
                    ],
                  )
               
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}