// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/images.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/provider/auth_provider.dart';
import 'package:flutter_application_breedersweb/provider/home_provider.dart';
import 'package:flutter_application_breedersweb/view/auth/login.dart';
import 'package:flutter_application_breedersweb/view/cow_detail.dart';
import 'package:flutter_application_breedersweb/view/drawer/analytics/analytics.dart';
import 'package:flutter_application_breedersweb/view/drawer/new_users.dart';
import 'package:flutter_application_breedersweb/view/drawer/statics.dart';
import 'package:flutter_application_breedersweb/view/widget/request_tile.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart' as pw;
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:excel/excel.dart' hide Border;
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().fetchHerds();
  }

Future<void> generateHerdPdf(Map<String, dynamic> herdData) async {
  final pdf = pw.Document();
  final image = pw.MemoryImage(
    (await rootBundle.load(AppImages.logo)).buffer.asUint8List(), 
  );
  
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
       child:  pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Image(image, width: 100, height: 100),
            pw.Text('Herd Details', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 10),
            pw.Text('Ranch: ${herdData['name']}'),
            pw.Text('Location: ${herdData['location']}'),
            pw.Text('Head Score: ${herdData['headScore']} Head'),
          ],
        ));
      },
    ),
  );
  await Printing.layoutPdf(onLayout: (pw.PdfPageFormat format) async {
    return pdf.save();
  });
}



Future<void> generateHerdExcel(Map<String, dynamic> herdData) async {
  final excel = Excel.createExcel(); 
  final sheetObject = excel['Sheet1']; 

  // Define headers
  List<String> headers = [
    'Ranch',
    'Location',
    'Head Score',
  ];

  // Add headers to the first row
 for (int i = 0; i < headers.length; i++) {
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = TextCellValue(headers[i]);
  }


  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1)).value = TextCellValue(herdData['name']);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 1)).value = TextCellValue(herdData['location']);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 1)).value = TextCellValue(herdData['headScore'].toString());

  // Save Excel file to device
  String formattedDate = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
  String filePath = '/storage/emulated/0/Download/herd_detail_export_$formattedDate.xlsx';

  List<int>? fileBytes = excel.save();
  if (fileBytes != null) {
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
    print('File saved at $filePath');

    // Notify user
   
  }
}


  @override
  Widget build(BuildContext context) {
     final herds = context.watch<HomeProvider>().herds;
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
                  onTap: () async{
                    await Provider.of<AuthProvider>(context, listen: false).signOut(context);
                    AppCustomNavigator.replace(context, const LoginScreen());

                  },
                ),
              ],
            ),
          ),
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
                                                    HerdDetailPage(herd: herd['id']));
                                              },
                                              trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              
                                           IconButton(
  icon: Icon(Icons.print),
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Export Options',
            style: TextStyle(fontSize: 18), 
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              Text(
                'Would you like to download the data as a PDF or Excel file?',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                generateHerdPdf(herd); 
                
              },
              child: Text(
                'PDF',
                style: TextStyle(fontSize: 14), 
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                generateHerdExcel(herd);
               
              },
              child: Text(
                'Excel',
                style: TextStyle(fontSize: 14),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 14), // Adjust button font size
              ),
            ),
          ],
        );
      },
    );
  },
),

                                             Text(
                                           '${herd['headScore']} Head',
                                           style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 2.sp),
                                                ),
                                              ],
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User Requests',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 6.sp),
                              ),
                              StreamBuilder<List<Map<String, dynamic>>>(
                                stream: context
                                    .read<HomeProvider>()
                                    .pendingRequestsStream,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return  Center(
                                        child: Container());
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
