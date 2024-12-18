// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/provider/user_herd_provider.dart';
import 'package:flutter_application_breedersweb/view/cow_detail.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserHerd extends StatefulWidget {
  final String uid; // Accept user ID as a parameter

  const UserHerd({Key? key, required this.uid}) : super(key: key);

  @override
  State<UserHerd> createState() => _UserHerdState();
}

class _UserHerdState extends State<UserHerd> {
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<UserHerdProvider>(context, listen: false).setUid(widget.uid);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Herd Details',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 6.sp),
        ),
      ),
      body: Row(
         mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Text(
                      'User Herd Details',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontSize: 6.sp,
                          ),
                    ),
                  ),
                  Consumer<UserHerdProvider>(
                    builder: (context, herdProvider, _) {
                     
          
                      if (herdProvider.herds.isEmpty) {
                        return Center(
                          child: Text(
                            'No herd data found for this user.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 4.sp),
                          ),
                        );
                      }
          
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: herdProvider.herds.length,
                        itemBuilder: (BuildContext context, int index) {
                          final herd = herdProvider.herds[index];
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
                                    AppCustomNavigator.push(
                                      context,
                                      HerdDetailPage(herd: herd["id"]),
                                    );
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
