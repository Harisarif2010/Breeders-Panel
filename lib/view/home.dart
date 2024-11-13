// import 'package:flutter/material.dart';
// import 'package:flutter_application_breedersweb/constants/colors.dart';
// import 'package:flutter_application_breedersweb/constants/images.dart';
// import 'package:sizer/sizer.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(builder: (context, orientation, deviceType) {
//       return Scaffold(
//         appBar: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GestureDetector(
//             onTap: () async {
            
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColors.grey,
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: Image.asset(AppImages.power, color: AppColors.black),
//             ),
//           ),
//         ),
//         centerTitle: true,
//         title: Text(
//           'Home',
//           style: Theme.of(context).textTheme.bodyMedium,
//         ),
       
//       ),
//       body: Column(
//         children: [
//       Row(
//         children: [
//           Container(
//             height: 70.h,
//             width: 50.w,
//             color: AppColors.black,
//           ),
//            Container(
//         height: 70.h,
//         width: 50.w,
//         color: AppColors.blue,
//       )
//         ],
//       )
      
//         ],
//       ),
//       );
//   });
//   }
// }
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/images.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/view/auth/login.dart';
import 'package:flutter_application_breedersweb/view/cow_detail.dart';
import 'package:flutter_application_breedersweb/view/widget/request_tile.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Sample data to replace Firebase data
  final List<Map<String, String>> herds = [
    {'name': 'Sunny Ranch', 'location': 'California', 'headScore': '50'},
    {'name': 'Blue Meadows', 'location': 'Texas', 'headScore': '30'},
    {'name': 'Golden Field', 'location': 'Nevada', 'headScore': '40'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              // Navigate to login screen
              AppCustomNavigator.replace(context, const LoginScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.asset(AppImages.power, color: AppColors.black),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Home',
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
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 6.sp,
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
                      child: Container(
   

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                'New Users Request',
                   style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 6.sp,
                    ),
              ),
              Container(
                   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
    );
  }
}
