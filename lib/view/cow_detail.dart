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

  // Load the logo image
  final image = pw.MemoryImage(
    (await rootBundle.load(AppImages.logo)).buffer.asUint8List(),
  );

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return [
          // Logo and Title Section
          pw.Center(
            child: pw.Column(
              children: [
                pw.Image(image, width: 100, height: 100),
                pw.SizedBox(height: 10),
                pw.Text('Cow Details', style: pw.TextStyle(fontSize: 30)),
              ],
            ),
          ),
          pw.SizedBox(height: 20),

          // Basic Information Section
          pw.Text('Herd Id: ${herd}', style: pw.TextStyle(fontSize: 16)),
          pw.SizedBox(height: 5),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Name: ${entry.name}', style: pw.TextStyle(fontSize: 16)),
              pw.Text('Cow Id: ${entry.cowid}', style: pw.TextStyle(fontSize: 16)),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('DOB: ${entry.dob}', style: pw.TextStyle(fontSize: 16)),
              pw.Text('Sire: ${entry.sire}', style: pw.TextStyle(fontSize: 16)),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Dam: ${entry.dam}', style: pw.TextStyle(fontSize: 16)),
              pw.Text('Time of Calved: ${entry.timeOfCalved}', style: pw.TextStyle(fontSize: 16)),
            ],
          ),
          pw.Text('Final Score: ${entry.finalScore}', style: pw.TextStyle(fontSize: 16)),

          pw.Divider(thickness: 2),

          // Strength & Substance Section
          _buildSectionHeader('Strength & Substance', entry.quiz1Score),
          _buildDetailSection(entry.quiz1Details, [
            '1- Chest: Adequate width and spacing between front legs',
            '2- Heart Girth: Deep and well-sprung fore ribs blending into shoulders',
            '3- Bone Mass: Strong without coarseness',
            '4- Muzzle: Broad with large open nostrils and a strong jaw',
            '5- Shoulder Blades and Elbows: Firmly set against the chest wall',
            '6- Crops: Full',
            "7- Size: Volumetric measurement of the cow's capacity",
          ]),

          pw.Divider(thickness: 2),

          // Breed Characteristics Section
          _buildSectionHeader('Breed Characteristics', entry.quiz2Score),
          _buildDetailSection(entry.quiz2Details, [
            '1- Ribs: Well sprung - not slab sided',
            '2- Disposition: Calm, easy demeanor',
            '3- Body Condition: Appropriate for the stage of lactation/environment',
            '4- Breed Characteristics: Overall style, strength, and balance. Head should be feminine',
            '5- Poll: Flat and upward no V-shape',
            '6- Brisket: Clean & free of excess fleshiness',
            '7- Horns: Adequate length. Horn base tied in smoothly. No bulbous base or ballooned.',
            '8- Tail: Long and slender',
            '9- Underline: Trim-free of extra skin',
            '10- Ears: Rounded held up tight to horn',
          ]),

          pw.Divider(thickness: 2),

          // Rump Section
          _buildSectionHeader('Rump', entry.quiz3Score),
          _buildDetailSection(entry.quiz3Details, [
            '1- Rump: Tail head is set slightly above and neatly between pin bones',
            '2- Rump: Pins should be adequately spaced and slightly lower than hip bones',
            '3- Vulva: Is nearly vertical and the anus should not be recessed',
            '4- Back: Straight and strong; loin broad, strong, and nearly level',
          ]),

          pw.Divider(thickness: 2),

          // Mobility Section
          _buildSectionHeader('Mobility', entry.quiz4Score),
          _buildDetailSection(entry.quiz4Details, [
            '1- Movement: Free and comfortable; able to rise and lie down easy',
            '2- Feet: Steep angle and deep heel with short, well rounded, closed toes',
            '3- Legs: Front and Rear: Tracking straight, wide apart with feet squarely placed',
            '4- Rear legs - Side View: A moderate set (angle) to the hock',
          ]),

           pw.Divider(thickness: 2),

          // Mobility Section
          _buildSectionHeader('Mammary System', entry.quiz5Score),
          _buildDetailSection(entry.quiz5Details, [
            '1- Udder Depth: Moderate depth relative to hock with adequate capacity and clearance. Consideration is given to lactation number and age',
            '2- Fore Udder: Firmly attached with moderate length and ample capacity',
            '3- Rear Udder: Wide and high, firmly attached with a unifrom width top to bottom and fullness at base of the rear udder where it turns to become the udder floor',
            '4- Teat Placement: squarely placed under each quarter, plumb and properly spaced from side and rear views',
            '5- Teats: Cyclindrical shape and uniform size with medium length and diameter',
            '6- Udder Cleft: Evidence of strong median suspensory liagment indicated by adequately definined halving',
            '7- Udder Balance and Texture: Should exhibit an udder floor that is level as viewed from side. Quarters should be evenly balanced, soft pliable and well collapsed after milking',
          ]),

          pw.SizedBox(height: 20),
        //  pw.Center(child: pw.Text("End of Report", style: pw.TextStyle(fontSize: 16))),
        ];
      },
    ),
  );

  // Print or Share the PDF
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}

// Helper to Build Section Header
pw.Widget _buildSectionHeader(String title, dynamic score) {
  return pw.Padding(
    padding: pw.EdgeInsets.only(bottom: 5),
    child: pw.Text(
      "$title: $score",
      style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
    ),
  );
}

// Helper to Build Detail Section
pw.Widget _buildDetailSection(Map<String, dynamic> details, List<String> descriptions) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      for (int i = 0; i < descriptions.length; i++)
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 2),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text(descriptions[i], style: pw.TextStyle(fontSize: 14)),
              ),
              pw.Text('${details['detail${i + 1}'] ?? ''}', style: pw.TextStyle(fontSize: 14)),
            ],
          ),
        ),
    ],
  );
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
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return [
          // Logo and Title Section
          pw.Center(
            child: pw.Column(
              children: [
                pw.Image(image, width: 100, height: 100),
                pw.SizedBox(height: 10),
                pw.Text('Cow Details', style: pw.TextStyle(fontSize: 30)),
              ],
            ),
          ),
          pw.SizedBox(height: 20),

          // Basic Information Section
          pw.Text('Herd Id: ${herd}', style: pw.TextStyle(fontSize: 16)),
          pw.SizedBox(height: 5),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Name: ${entry.name}', style: pw.TextStyle(fontSize: 16)),
              pw.Text('Cow Id: ${entry.cowid}', style: pw.TextStyle(fontSize: 16)),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('DOB: ${entry.dob}', style: pw.TextStyle(fontSize: 16)),
              pw.Text('Sire: ${entry.sire}', style: pw.TextStyle(fontSize: 16)),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Dam: ${entry.dam}', style: pw.TextStyle(fontSize: 16)),
              pw.Text('Time of Calved: ${entry.timeOfCalved}', style: pw.TextStyle(fontSize: 16)),
            ],
          ),
          pw.Text('Final Score: ${entry.finalScore}', style: pw.TextStyle(fontSize: 16)),

          pw.Divider(thickness: 2),

          // Strength & Substance Section
          _buildSectionHeader('Strength & Substance', entry.quiz1Score),
          _buildDetailSection(entry.quiz1Details, [
            '1- Chest: Adequate width and spacing between front legs',
            '2- Heart Girth: Deep and well-sprung fore ribs blending into shoulders',
            '3- Bone Mass: Strong without coarseness',
            '4- Muzzle: Broad with large open nostrils and a strong jaw',
            '5- Shoulder Blades and Elbows: Firmly set against the chest wall',
            '6- Crops: Full',
            "7- Size: Volumetric measurement of the cow's capacity",
          ]),

          pw.Divider(thickness: 2),

          // Breed Characteristics Section
          _buildSectionHeader('Breed Characteristics', entry.quiz2Score),
          _buildDetailSection(entry.quiz2Details, [
            '1- Ribs: Well sprung - not slab sided',
            '2- Disposition: Calm, easy demeanor',
            '3- Body Condition: Appropriate for the stage of lactation/environment',
            '4- Breed Characteristics: Overall style, strength, and balance. Head should be feminine',
            '5- Poll: Flat and upward no V-shape',
            '6- Brisket: Clean & free of excess fleshiness',
            '7- Horns: Adequate length. Horn base tied in smoothly. No bulbous base or ballooned.',
            '8- Tail: Long and slender',
            '9- Underline: Trim-free of extra skin',
            '10- Ears: Rounded held up tight to horn',
          ]),

          pw.Divider(thickness: 2),

          // Rump Section
          _buildSectionHeader('Rump', entry.quiz3Score),
          _buildDetailSection(entry.quiz3Details, [
            '1- Rump: Tail head is set slightly above and neatly between pin bones',
            '2- Rump: Pins should be adequately spaced and slightly lower than hip bones',
            '3- Vulva: Is nearly vertical and the anus should not be recessed',
            '4- Back: Straight and strong; loin broad, strong, and nearly level',
          ]),

          pw.Divider(thickness: 2),

          // Mobility Section
          _buildSectionHeader('Mobility', entry.quiz4Score),
          _buildDetailSection(entry.quiz4Details, [
            '1- Movement: Free and comfortable; able to rise and lie down easy',
            '2- Feet: Steep angle and deep heel with short, well rounded, closed toes',
            '3- Legs: Front and Rear: Tracking straight, wide apart with feet squarely placed',
            '4- Rear legs - Side View: A moderate set (angle) to the hock',
          ]),

           pw.Divider(thickness: 2),

          // Mobility Section
          _buildSectionHeader('Mammary System', entry.quiz5Score),
          _buildDetailSection(entry.quiz5Details, [
            '1- Udder Depth: Moderate depth relative to hock with adequate capacity and clearance. Consideration is given to lactation number and age',
            '2- Fore Udder: Firmly attached with moderate length and ample capacity',
            '3- Rear Udder: Wide and high, firmly attached with a unifrom width top to bottom and fullness at base of the rear udder where it turns to become the udder floor',
            '4- Teat Placement: squarely placed under each quarter, plumb and properly spaced from side and rear views',
            '5- Teats: Cyclindrical shape and uniform size with medium length and diameter',
            '6- Udder Cleft: Evidence of strong median suspensory liagment indicated by adequately definined halving',
            '7- Udder Balance and Texture: Should exhibit an udder floor that is level as viewed from side. Quarters should be evenly balanced, soft pliable and well collapsed after milking',
          ]),

          pw.SizedBox(height: 20),
        //  pw.Center(child: pw.Text("End of Report", style: pw.TextStyle(fontSize: 16))),
        ];
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
                                            Divider(
                                              thickness: 2,
                                              color: AppColors.grey,
                                            ),
                                             Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Chest: ${entry.quiz1Details['detail1']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Heart Girth: ${entry.quiz1Details['detail2']}",
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
                                                  "Bone Mass: ${entry.quiz1Details['detail3']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Muzzle: ${entry.quiz1Details['detail4']}",
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
                                                  "Shoulder Blades and Elbows: ${entry.quiz1Details['detail5']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Crops: ${entry.quiz1Details['detail6']}",
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
                                                  "Size: ${entry.quiz1Details['detail7']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Strength & Substance: ${entry.quiz1Score}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                              ],
                                            ),
                                            
                                             Divider(
                                              thickness: 2,
                                              color: AppColors.grey,
                                            ),
                                              Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Ribs: ${entry.quiz2Details['detail1']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Disposition: ${entry.quiz2Details['detail2']}",
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
                                                  "Body Condition: ${entry.quiz2Details['detail3']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Breed Characteristics: ${entry.quiz2Details['detail4']}",
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
                                                  "Poll: ${entry.quiz2Details['detail5']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Brisket: ${entry.quiz2Details['detail6']}",
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
                                                  "Horns: ${entry.quiz2Details['detail7']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Tail: ${entry.quiz2Details['detail8']}",
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
                                                  "Underline: ${entry.quiz2Details['detail9']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Ears: ${entry.quiz2Details['detail10']}",
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
                                                  "Breed Characteristics: ${entry.quiz2Score}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                               
                                              ],
                                            ),
                                            
                                             Divider(
                                              thickness: 2,
                                              color: AppColors.grey,
                                            ),
                                             Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Rump Tail: ${entry.quiz3Details['detail1']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Rump Pins: ${entry.quiz3Details['detail2']}",
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
                                                  "Vulva: ${entry.quiz3Details['detail3']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Back: ${entry.quiz3Details['detail4']}",
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
                                                  "Rump: ${entry.quiz3Score}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                               
                                              ],
                                            ),
                                          
                                            Divider(
                                              thickness: 2,
                                              color: AppColors.grey,
                                            ),
                                             Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Movement: ${entry.quiz4Details['detail1']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Feet: ${entry.quiz4Details['detail2']}",
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
                                                  "Legs: Front and Rear: ${entry.quiz4Details['detail3']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Rear legs - Side View: ${entry.quiz4Details['detail4']}",
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
                                                  "Thurl Position: ${entry.quiz4Details['detail5']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                 Text(
                                                  "Mobility: ${entry.quiz4Score}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                               
                                              ],
                                            ),
                                          
                                            Divider(
                                              thickness: 2,
                                              color: AppColors.grey,
                                            ),
                                              Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Udder Depth: ${entry.quiz5Details['detail1']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Fore Udder: ${entry.quiz5Details['detail2']}",
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
                                                  "Rear Udder: ${entry.quiz5Details['detail3']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Teat Placement: ${entry.quiz5Details['detail4']}",
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
                                                  "Teats: ${entry.quiz5Details['detail5']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Udder Cleft: ${entry.quiz5Details['detail6']}",
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
                                                  "Udder Balance and Texture: ${entry.quiz5Details['detail7']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 4.sp),
                                                ),
                                                Text(
                                                  "Mammary System: ${entry.quiz5Score}",
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