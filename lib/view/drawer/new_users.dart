
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/images.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/view/auth/forgot.dart';
import 'package:flutter_application_breedersweb/view/auth/login.dart';
import 'package:flutter_application_breedersweb/view/home.dart';
import 'package:flutter_application_breedersweb/view/widget/custom_button.dart';
import 'package:flutter_application_breedersweb/view/widget/request_tile.dart';
import 'package:flutter_application_breedersweb/view/widget/textfield.dart';
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
      body: Center(
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
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
                        horizontal: 4.0, vertical: 4.0),
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
      ),
    );
  }
}