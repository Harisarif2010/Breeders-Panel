
import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/images.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/view/cow_detail.dart';
import 'package:flutter_application_breedersweb/view/drawer/analytics/herd.dart';
import 'package:flutter_application_breedersweb/view/widget/request_tile.dart';
import 'package:sizer/sizer.dart';

class Statics extends StatefulWidget {
  const Statics({Key? key});

  @override
  State<Statics> createState() => _StaticsState();
}

class _StaticsState extends State<Statics> {
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
        
        title: Text(
          'Statics',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 6.sp,
              ),
        ),
      ),
    
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Users: 60',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 4.sp,
                    ),),
                      Text(
                'Total Herds: 60',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 4.sp,
                    ),),
                      Text(
                'Total Cows: 60',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 4.sp,
                    ),),
                     Text(
                'New Permissions: 60',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 4.sp,
                    ),),
                    Divider(
                      color: AppColors.grey,
                      thickness: 2,
                    ),
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
                'New Herds',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 4.sp,
                    ),
              ),
                          Container(
                            height: 90.h,
                            child: ListView.builder(
                              itemCount: herds.length,
                              itemBuilder: (BuildContext context, int index) {
                                final herd = herds[index];
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: AppColors.grey,
                                        ),
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          // Navigate to HerdDetail page
                                          AppCustomNavigator.push(
                                              context, HerdDetailPage(herd: herd));
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                                  'New Cows',
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 4.sp,
                    ),
                                ),
                                   Container(
                       padding: EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                                  child: ExpansionTile(
                                        trailing: Text(
                                          "Ranch: Sunny",
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 4.sp
                              )
                                        ),
                                        title: Text(
                                          "Name: Catalina",
                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: 4.sp
                              )
                                        ),
                                        subtitle: Text(
                                          "Dob: 25/25/2500",
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 4.sp
                              )
                                        ),
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 8.sp),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Sire: Bob",
                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 4.sp
                              )
                                                    ),
                                                    Text(
                                                      "Dam: Australian",
                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 
                               4 .sp
                              )
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Final Score: 50",
                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 4.sp
                              )
                                                    ),
                                                    Text(
                                                      "Time of Calved: 50",
                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 
                                4.sp
                              )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                ),
                         
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
