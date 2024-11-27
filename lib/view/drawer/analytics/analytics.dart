import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/view/drawer/analytics/herd.dart';
import 'package:sizer/sizer.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
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
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
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
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                    return const Center(
                                      child: Text('No data available'),
                                    );
                                  }

                                  final users = snapshot.data!.docs;

                                  return ListView.builder(
                                    itemCount: users.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final user = users[index];
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
                                                //AppCustomNavigator.push(context, UserHerd());
                                                 AppCustomNavigator.push(context,UserHerd(uid: user['uid']),);
                                              },
                                              trailing: Text(
                                                'Joined: ${user['timestamp'] != null ? (user['timestamp'] as Timestamp).toDate().toString().split(' ')[0] : 'N/A'}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(fontSize: 2.sp),
                                              ),
                                              title: Text(
                                                'Email: ${user['email']}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(fontSize: 4.sp),
                                              ),
                                              subtitle: Text(
                                               "UserID: ${user['uid']}",
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
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
