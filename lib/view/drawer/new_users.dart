
import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/images.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/provider/home_provider.dart';
import 'package:flutter_application_breedersweb/view/auth/forgot.dart';
import 'package:flutter_application_breedersweb/view/auth/login.dart';
import 'package:flutter_application_breedersweb/view/home.dart';
import 'package:flutter_application_breedersweb/view/widget/custom_button.dart';
import 'package:flutter_application_breedersweb/view/widget/request_tile.dart';
import 'package:flutter_application_breedersweb/view/widget/textfield.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NewUsers extends StatefulWidget {
  const NewUsers({Key? key});

  @override
  State<NewUsers> createState() => _NewUsersState();
}

class _NewUsersState extends State<NewUsers> {
  bool obsecurePassword = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  leading: IconButton(onPressed: (){AppCustomNavigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new)),
 ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 700),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                 // crossAxisAlignment: CrossAxisAlignment.start,
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
                    StreamBuilder<List<Map<String, dynamic>>>(
                                  stream: context
                                      .read<HomeProvider>()
                                      .pendingRequestsStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return  Center(
                                          child: Text('Error loading requests',style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(fontSize: 4.sp),
                                ));
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return  Center(
                                          child: Text('No pending requests',style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(fontSize: 4.sp),
                                ));
                                    }
          
                                    final requests = snapshot.data!;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: requests.length,
                                      itemBuilder: (context, index) {
                                        final request = requests[index];
                                        return AcceptRejectListTile(
                                          name: request['email'] ?? 'Unknown',
                                          onAccept: () async {
                                            await context
                                                .read<HomeProvider>()
                                                .updateStatus(
                                                    request['id'], 'accepted');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Request Accepted')));
                                          },
                                          onReject: () async {
                                            await context
                                                .read<HomeProvider>()
                                                .updateStatus(
                                                    request['id'], 'rejected');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Request Rejected')));
                                          },
                                        );
                                      },
                                    );
                                  },
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