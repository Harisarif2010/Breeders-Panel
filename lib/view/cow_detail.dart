// import 'package:flutter/material.dart';
// import 'package:flutter_application_breedersweb/constants/colors.dart';
// import 'package:flutter_application_breedersweb/provider/herd_detail_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// class HerdDetailPage extends StatelessWidget {
//   final herd;

//   const HerdDetailPage({super.key, required this.herd});

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<HerdDetailProvider>().fetchScoringEntries(herd);
//     });

//     return Scaffold(
//       appBar: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColors.grey,
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: const Icon(Icons.arrow_back),
//             ),
//           ),
//         ),
//         centerTitle: true,
//         title: Text(
//           'Herd Details',
//           style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 6.sp),
//         ),
//       ),
//       body: Consumer<HerdDetailProvider>(
//         builder: (context, provider, _) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (provider.scoringEntries.isEmpty) {
//             return const Center(child: Text('No cows found for this herd.'));
//           }

//           return SingleChildScrollView(
//             child: Center(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(maxWidth: 700),
//                 child: Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'All Cows',
//                         style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 6.sp),
//                       ),
//                       SizedBox(height: 2.h),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: provider.scoringEntries.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           final entry = provider.scoringEntries[index];
//                           return Column(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(color: AppColors.grey),
//                                 ),
//                                 child: Theme(
//                                   data: ThemeData().copyWith(dividerColor: Colors.transparent),
//                                   child: ExpansionTile(
//                                     trailing: Text(
//                                       "Cow Id: ${entry.cowid}",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyMedium!
//                                           .copyWith(fontSize: 4.sp),
//                                     ),
//                                     title: Text(
//                                       "Name: ${entry.name}",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyLarge!
//                                           .copyWith(fontSize: 4.sp),
//                                     ),
//                                     subtitle: Text(
//                                       "DOB: ${entry.dob}",
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyMedium!
//                                           .copyWith(fontSize: 4.sp),
//                                     ),
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 8.sp),
//                                         child: Column(
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "Sire: ${entry.sire}",
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyMedium!
//                                                       .copyWith(fontSize: 4.sp),
//                                                 ),
//                                                 Text(
//                                                   "Dam: ${entry.dam}",
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyMedium!
//                                                       .copyWith(fontSize: 4.sp),
//                                                 ),
//                                               ],
//                                             ),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "Final Score: ${entry.finalScore}",
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyMedium!
//                                                       .copyWith(fontSize: 4.sp),
//                                                 ),
//                                                 Text(
//                                                   "Time of Calved: ${entry.timeOfCalved}",
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyMedium!
//                                                       .copyWith(fontSize: 4.sp),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 2.h),
//                             ],
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/images.dart';
import 'package:flutter_application_breedersweb/provider/herd_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class HerdDetailPage extends StatelessWidget {
  final herd;

  const HerdDetailPage({super.key, required this.herd});

  Future<void> _createPDF2(BuildContext context, HerdDetailProvider provider, var entry) async {
    final pdf = pw.Document();

    final image = pw.MemoryImage(
      (await rootBundle.load(AppImages.logo)).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Image(image, width: 100, height: 100),
                pw.Text('Cow Details', style: pw.TextStyle(fontSize: 30)),
                pw.Text('Herd Id: ${herd}', style: pw.TextStyle(fontSize: 16)),
                pw.Text('Name: ${entry.name}', style: pw.TextStyle(fontSize: 20)),
                pw.Text('Cow Id: ${entry.cowid}', style: pw.TextStyle(fontSize: 16)),
                pw.Text('DOB: ${entry.dob}', style: pw.TextStyle(fontSize: 16)),
                pw.Text('Sire: ${entry.sire}', style: pw.TextStyle(fontSize: 16)),
                pw.Text('Dam: ${entry.dam}', style: pw.TextStyle(fontSize: 16)),
                pw.Text('Final Score: ${entry.finalScore}', style: pw.TextStyle(fontSize: 16)),
                pw.Text('Time of Calved: ${entry.timeOfCalved}', style: pw.TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );

    // Print the PDF
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }
   Future<void> _createPDF(BuildContext context, HerdDetailProvider provider) async {
    final pdf = pw.Document();

    final image = pw.MemoryImage(
    (await rootBundle.load(AppImages.logo)).buffer.asUint8List(), 
  );
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Image(image, width: 100, height: 100),
                pw.Text('Cow Details', style: pw.TextStyle(fontSize: 30)),
                pw.Text('Herd Id: ${herd}', style: pw.TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );

    for (var entry in provider.scoringEntries) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Column(
              children: [
                pw.Image(image, width: 100, height: 100),
                pw.Text('Name: ${entry.name}', style: pw.TextStyle(fontSize: 20)),
                pw.Text('Cow Id: ${entry.cowid}', style: pw.TextStyle(fontSize: 16)),
                pw.Text('DOB: ${entry.dob}', style: pw.TextStyle(fontSize: 16)),
                pw.Text('Sire: ${entry.sire}', style: pw.TextStyle(fontSize: 16)),
                pw.Text('Dam: ${entry.dam}', style: pw.TextStyle(fontSize: 16)),
                pw.Text('Final Score: ${entry.finalScore}', style: pw.TextStyle(fontSize: 16)),
                pw.Text('Time of Calved: ${entry.timeOfCalved}', style: pw.TextStyle(fontSize: 16)),
              ],
            ));
          },
        ),
      );
    }

    // Print the PDF
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HerdDetailProvider>().fetchScoringEntries(herd);
    });

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
          'Cow Details',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 6.sp),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              final provider = context.read<HerdDetailProvider>();
              _createPDF(context, provider);
            },
          ),
        ],
      ),
      body: Consumer<HerdDetailProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.scoringEntries.isEmpty) {
            return const Center(child: Text('No cows found for this herd.'));
          }

          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Cows',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 6.sp),
                      ),
                      SizedBox(height: 2.h),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.scoringEntries.length,
                        itemBuilder: (BuildContext context, int index) {
                          final entry = provider.scoringEntries[index];
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppColors.grey),
                                ),
                                child: Theme(
                                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                             IconButton(
                                             icon: Icon(Icons.picture_as_pdf),
                                               onPressed: () {
                                              _createPDF2(context, provider, entry);
                                                 },
                                              ),
                                        Text(
                                          "Registration Id: ${entry.cowid}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(fontSize: 4.sp),
                                        ),
                                      ],
                                    ),
                                    title: Text(
                                      "Name: ${entry.name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 4.sp),
                                    ),
                                    subtitle: Text(
                                      "DOB: ${entry.dob}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 4.sp),
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
                                                  "Sire: ${entry.sire}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Dam: ${entry.dam}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Final Score: ${entry.finalScore}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Time of Calved: ${entry.timeOfCalved}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 2.h),
                                         
                                          ],
                                        ),
                                      ),
                                    ],
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
            ),
          );
        },
      ),
    );
  }
}