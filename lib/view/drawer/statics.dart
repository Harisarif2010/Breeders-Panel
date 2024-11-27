
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<List<Map<String, dynamic>>> fetchHerds() async {
    final querySnapshot = await _firestore
        .collection('herds')
        .orderBy('timestamp', descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }


  Future<List<Map<String, dynamic>>> fetchCows() async {
    final querySnapshot = await _firestore
        .collection('Cow Scoring')
        .orderBy('timestamp', descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }


  Future<int> fetchTotalAcceptedUsers() async {
    final querySnapshot = await _firestore
        .collection('new_requests')
        .where('status', isEqualTo: 'accepted')
        .get();
    return querySnapshot.docs.length;
  }


  Future<int> fetchNewPermissions() async {
    final querySnapshot = await _firestore
        .collection('new_requests')
        .where('status', isEqualTo: 'pending')
        .get();
    return querySnapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            AppCustomNavigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'Statics',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 6.sp,
              ),
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([
          fetchHerds(),
          fetchCows(),
          fetchTotalAcceptedUsers(),
          fetchNewPermissions()
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final herds = snapshot.data![0] as List<Map<String, dynamic>>;
          final cows = snapshot.data![1] as List<Map<String, dynamic>>;
          final totalUsers = snapshot.data![2] as int;
          final newPermissions = snapshot.data![3] as int;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Users: $totalUsers',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 4.sp,
                        ),
                  ),
                  Text(
                    'Total Herds: ${herds.length}',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 4.sp,
                        ),
                  ),
                  Text(
                    'Total Cows: ${cows.length}',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 4.sp,
                        ),
                  ),
                  Text(
                    'New Permissions: $newPermissions',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 4.sp,
                        ),
                  ),
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
                             ListView.builder(
                      itemCount: herds.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final herd = herds[index];
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.grey),
                              ),
                              child: ListTile(
                                onTap: (){
                                   AppCustomNavigator.push(context,
                                                    HerdDetailPage(herd: herd['id']));
                                },
                                title: Text(
                                  "Ranch: ${herd['name']}",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 4.sp),
                                ),
                                subtitle: Text(
                                  "Location: ${herd['location']}",
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 4.sp),
                                ),
                                trailing: Text(
                                  "${herd['headScore']} Head",
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 2.sp),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.h),
                          ],
                        );
                      },
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
                                       child: ListView.builder(
                                                             itemCount: cows.length,
                                                             shrinkWrap: true,
                                                             physics: const NeverScrollableScrollPhysics(),
                                                             itemBuilder: (context, index) {
                                                               final cow = cows[index];
                                                               return ExpansionTile(
                                                                 title: Text(
                                                                   "Name: ${cow['name']}",
                                                                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 4.sp),
                                                                 ),
                                                                 subtitle: Text(
                                                                   "DOB: ${cow['dob']}",
                                                                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 4.sp),
                                                                 ),
                                                                 trailing: Text(
                                                                   "Registration Id: ${cow['cowid']}",
                                                                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 4.sp),
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
                                          "Sire: ${cow['sire']}",
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 4.sp),
                                        ),
                                        Text(
                                          "Dam: ${cow['dam']}",
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 4.sp),
                                        ),
                                                                           ],
                                                                         ),
                                                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Final Score: ${cow['finalScore']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Time of Calved: ${cow['timeOfCalved']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                              ],
                                            ),
                                                                       ],
                                                                     ),
                                                                   ),
                                                                 ],
                                                               );
                                                                },
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
              );}
      ),
    );
  }
}
