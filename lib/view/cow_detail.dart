
// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/images.dart';
import 'package:flutter_application_breedersweb/provider/herd_detail_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:excel/excel.dart' hide Border;



class HerdDetailPage extends StatelessWidget {
  final herd;

  const HerdDetailPage({super.key, required this.herd});


  Future<void> exportToExcel(BuildContext context, HerdDetailProvider provider, var entry) async {
  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];

  // Define headers
  List<String> headers = [
    'Herd Id', 'Cow Id', 'Name', 'DOB', 'Sire', 'Dam', 'Time of Calved', 'Final Score',
    'Strength & Substance Score', 'Breed Characteristics Score', 'Rump Score', 'Mobility Score', 'Mammary System Score'
  ];

  // Write headers to the first row
  for (int i = 0; i < headers.length; i++) {
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = TextCellValue(headers[i]);
  }

  // Add data for each herd entry
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1)).value = TextCellValue(entry.herdId);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 1)).value = TextCellValue(entry.cowid);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 1)).value = TextCellValue(entry.name);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 1)).value = TextCellValue(entry.dob);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 1)).value = TextCellValue(entry.sire);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 1)).value = TextCellValue(entry.dam);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 1)).value = TextCellValue(entry.timeOfCalved);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 1)).value = TextCellValue(entry.finalScore.toString());

  // Add scores for the different sections
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 1)).value = TextCellValue(entry.quiz1Score.toString());
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 1)).value = TextCellValue(entry.quiz2Score.toString());
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 1)).value = TextCellValue(entry.quiz3Score.toString());
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 1)).value = TextCellValue(entry.quiz4Score.toString());
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 1)).value = TextCellValue(entry.quiz5Score.toString());

  // Loop through and add details for each section (example: Strength & Substance)
  List<String> strengthDescriptions = [
    'Chest: Adequate width and spacing between front legs',
    'Heart Girth: Deep and well-sprung fore ribs blending into shoulders',
    'Bone Mass: Strong without coarseness',
    'Muzzle: Broad with large open nostrils and a strong jaw',
    'Shoulder Blades and Elbows: Firmly set against the chest wall',
    'Crops: Full',
    "Size: Volumetric measurement of the cow's capacity",
  ];
  List<String> strengthDescriptions2 = [
            'Ribs: Well sprung - not slab sided',
            'Disposition: Calm, easy demeanor',
            'Body Condition: Appropriate for the stage of lactation/environment',
            'Breed Characteristics: Overall style, strength, and balance. Head should be feminine',
            'Poll: Flat and no upward V-shape',
            'Brisket: Clean & free of excess fleshiness',
            'Horns: Adequate length. Horn base tied in smoothly. No bulbous base or ballooned.',
            'Tail: Long and slender',
            'Underline: Trim-free of extra skin',
            'Ears: Rounded held up tight to horn',
  ];
  List<String> strengthDescriptions3 = [
            'Rump: Tail head is set slightly above and neatly between pin bones',
            'Rump: Pins should be adequately spaced and slightly lower than hip bones',
            'Vulva: Is nearly vertical and the anus should not be recessed',
            'Back: Straight and strong; loin broad, strong, and nearly level',
            
         
  ];
  List<String> strengthDescriptions4 = [
            'Movement: Free and comfortable; able to rise and lie down easy',
            'Feet: Steep angle and deep heel with short, well rounded, closed toes',
            'Legs: Front and Rear: Tracking straight, wide apart with feet squarely placed',
            'Rear legs - Side View: A moderate set (angle) to the hock',
       
  ];
  List<String> strengthDescriptions5 = [
            'Udder Depth: Moderate depth relative to hock with adequate capacity and clearance. Consideration is given to lactation number and age',
            'Fore Udder: Firmly attached with moderate length and ample capacity',
            'Rear Udder: Wide and high, firmly attached with a unifrom width top to bottom and fullness at base of the rear udder where it turns to become the udder floor',
            'Teat Placement: squarely placed under each quarter, plumb and properly spaced from side and rear views',
            'Teats: Cyclindrical shape and uniform size with medium length and diameter',
            'Udder Cleft: Evidence of strong median suspensory liagment indicated by adequately definined halving',
            'Udder Balance and Texture: Should exhibit an udder floor that is level as viewed from side. Quarters should be evenly balanced, soft pliable and well collapsed after milking',
        
  ];

  // Add Strength & Substance descriptions to Excel
  int minLength = [

  strengthDescriptions3.length,
  strengthDescriptions4.length,
].reduce((a, b) => a < b ? a : b);

  for (int i = 0; i < strengthDescriptions.length; i++) {
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i + 2)).value = TextCellValue(strengthDescriptions[i]);
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: i + 2)).value = TextCellValue(entry.quiz1Details['detail${i + 1}'] ?? '');
     sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 15, rowIndex: i + 2)).value = TextCellValue(strengthDescriptions2[i]);
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 16, rowIndex: i + 2)).value = TextCellValue(entry.quiz2Details['detail${i + 1}'] ?? '');
    
    }
for (int i = 0; i < minLength; i++) {
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 17, rowIndex: i + 2)).value = TextCellValue(strengthDescriptions3[i]);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 18, rowIndex: i + 2)).value = TextCellValue(entry.quiz3Details['detail${i + 1}'] ?? '');
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 19, rowIndex: i + 2)).value = TextCellValue(strengthDescriptions4[i]);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 20, rowIndex: i + 2)).value = TextCellValue(entry.quiz4Details['detail${i + 1}'] ?? '');

}
 for (int i = 0; i < strengthDescriptions.length; i++) {
   
     sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 21, rowIndex: i + 2)).value = TextCellValue(strengthDescriptions5[i]);
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 22, rowIndex: i + 2)).value = TextCellValue(entry.quiz5Details['detail${i + 1}'] ?? '');
  }


  // Repeat similar logic for other sections (Breed Characteristics, Rump, Mobility, Mammary System)

  String formattedDate = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
  String filePath = '/storage/emulated/0/Download/herd_data_export_$formattedDate.xlsx';

  List<int>? fileBytes = excel.save();
  if (fileBytes != null) {
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
    print('File saved at $filePath');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Excel file saved to: $filePath')),
    );
  }
}

  Future<void> exportToExcelFromPDF(BuildContext context, HerdDetailProvider provider) async {
  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];

  // Define headers
  List<String> headers = [
    'Herd Id', 'Cow Id', 'Name', 'DOB', 'Sire', 'Dam', 'Time of Calved',
    'Final Score', 'Strength & Substance', 'Breed Characteristics', 
    'Rump', 'Mobility', 'Mammary System', 'Details'
  ];

  // Write headers to the first row
  for (int i = 0; i < headers.length; i++) {
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = TextCellValue(headers[i]);;
  }

  // Add entries for each cow in the herd
  int currentRow = 1; // Start from the second row
for (var entry in provider.scoringEntries) {
  // Write data for the current cow entry
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: currentRow)).value = TextCellValue(entry.herdId);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: currentRow)).value = TextCellValue(entry.cowid);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: currentRow)).value = TextCellValue(entry.name);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: currentRow)).value = TextCellValue(entry.dob);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: currentRow)).value = TextCellValue(entry.sire);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: currentRow)).value = TextCellValue(entry.dam);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: currentRow)).value = TextCellValue(entry.timeOfCalved);
  sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: currentRow)).value = TextCellValue(entry.finalScore.toString());

sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: currentRow)).value = TextCellValue(entry.quiz1Score.toString());
sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: currentRow)).value = TextCellValue(entry.quiz2Score.toString());
sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: currentRow)).value = TextCellValue(entry.quiz3Score.toString());
sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: currentRow)).value = TextCellValue(entry.quiz4Score.toString());
sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: currentRow)).value = TextCellValue(entry.quiz5Score.toString());




List<String> strengthDescriptions = [
    'Chest: Adequate width and spacing between front legs',
    'Heart Girth: Deep and well-sprung fore ribs blending into shoulders',
    'Bone Mass: Strong without coarseness',
    'Muzzle: Broad with large open nostrils and a strong jaw',
    'Shoulder Blades and Elbows: Firmly set against the chest wall',
    'Crops: Full',
    "Size: Volumetric measurement of the cow's capacity",
  ];
  List<String> strengthDescriptions2 = [
            'Ribs: Well sprung - not slab sided',
            'Disposition: Calm, easy demeanor',
            'Body Condition: Appropriate for the stage of lactation/environment',
            'Breed Characteristics: Overall style, strength, and balance. Head should be feminine',
            'Poll: Flat and no upward V-shape',
            'Brisket: Clean & free of excess fleshiness',
            'Horns: Adequate length. Horn base tied in smoothly. No bulbous base or ballooned.',
            'Tail: Long and slender',
            'Underline: Trim-free of extra skin',
            'Ears: Rounded held up tight to horn',
  ];
  List<String> strengthDescriptions3 = [
            'Rump: Tail head is set slightly above and neatly between pin bones',
            'Rump: Pins should be adequately spaced and slightly lower than hip bones',
            'Vulva: Is nearly vertical and the anus should not be recessed',
            'Back: Straight and strong; loin broad, strong, and nearly level',
            
         
  ];
  List<String> strengthDescriptions4 = [
            'Movement: Free and comfortable; able to rise and lie down easy',
            'Feet: Steep angle and deep heel with short, well rounded, closed toes',
            'Legs: Front and Rear: Tracking straight, wide apart with feet squarely placed',
            'Rear legs - Side View: A moderate set (angle) to the hock',
       
  ];
  List<String> strengthDescriptions5 = [
            'Udder Depth: Moderate depth relative to hock with adequate capacity and clearance. Consideration is given to lactation number and age',
            'Fore Udder: Firmly attached with moderate length and ample capacity',
            'Rear Udder: Wide and high, firmly attached with a unifrom width top to bottom and fullness at base of the rear udder where it turns to become the udder floor',
            'Teat Placement: squarely placed under each quarter, plumb and properly spaced from side and rear views',
            'Teats: Cyclindrical shape and uniform size with medium length and diameter',
            'Udder Cleft: Evidence of strong median suspensory liagment indicated by adequately definined halving',
            'Udder Balance and Texture: Should exhibit an udder floor that is level as viewed from side. Quarters should be evenly balanced, soft pliable and well collapsed after milking',
        
  ];

  // Add Strength & Substance Descriptions
  int descriptionRowStart = currentRow + 1;
  for (int i = 0; i < strengthDescriptions.length; i++) {
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: descriptionRowStart + i)).value = TextCellValue(strengthDescriptions[i]);
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: descriptionRowStart + i)).value = TextCellValue(entry.quiz1Details['detail${i + 1}'] ?? '');
  }

  // Add descriptions from strengthDescriptions2 to strengthDescriptions5
  for (int i = 0; i < strengthDescriptions2.length; i++) {
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 15, rowIndex: descriptionRowStart + i)).value = TextCellValue(strengthDescriptions2[i]);
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 16, rowIndex: descriptionRowStart + i)).value = TextCellValue(entry.quiz2Details['detail${i + 1}'] ?? '');
  }

  int minLength = [strengthDescriptions3.length, strengthDescriptions4.length].reduce((a, b) => a < b ? a : b);
  for (int i = 0; i < minLength; i++) {
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 17, rowIndex: descriptionRowStart + i)).value = TextCellValue(strengthDescriptions3[i]);
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 18, rowIndex: descriptionRowStart + i)).value = TextCellValue(entry.quiz3Details['detail${i + 1}'] ?? '');
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 19, rowIndex: descriptionRowStart + i)).value = TextCellValue(strengthDescriptions4[i]);
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 20, rowIndex: descriptionRowStart + i)).value = TextCellValue(entry.quiz4Details['detail${i + 1}'] ?? '');
  }

  for (int i = 0; i < strengthDescriptions5.length; i++) {
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 21, rowIndex: descriptionRowStart + i)).value = TextCellValue(strengthDescriptions5[i]);
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 22, rowIndex: descriptionRowStart + i)).value = TextCellValue(entry.quiz5Details['detail${i + 1}'] ?? '');
  }

  // Increment currentRow for the next entry
  currentRow = descriptionRowStart + strengthDescriptions.length;
}

  // Save Excel file
  String formattedDate = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
  String filePath = '/storage/emulated/0/Download/herd_details_$formattedDate.xlsx';

  List<int>? fileBytes = excel.save();
  if (fileBytes != null) {
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
    print('File saved at $filePath');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Excel file saved to: $filePath')),
    );
  }
}

  Future<void> _createPDF2(BuildContext context, HerdDetailProvider provider, var entry) async {
  final pdf = pw.Document();

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
                pw.Text('Cow Details', style: pw.TextStyle(fontSize: 22)),
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
            '5- Poll: Flat and no upward V-shape',
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

  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}

  pw.Widget _buildSectionHeader(String title, dynamic score) {
  return pw.Padding(
    padding: pw.EdgeInsets.only(bottom: 5),
    child: pw.Text(
      "$title: $score",
      style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
    ),
  );
}

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
                pw.Text('Cow Details', style: pw.TextStyle(fontSize: 22)),
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
            '5- Poll: Flat and no upward V-shape',
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
          // IconButton(
          //   icon: Icon(Icons.print),
          //   onPressed: () {
          //     final provider = context.read<HerdDetailProvider>();
          //    _createPDF(context, provider);
          //    exportToExcelFromPDF(context, provider);
          //   },
          // ),
          IconButton(
  icon: Icon(Icons.print),
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Export Options",
            style: TextStyle(fontSize: 18), 
          ),
          content: SizedBox(
            width: 300, 
            child: Text(
              "Choose the format to export the data:",
              style: TextStyle(fontSize: 14),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final provider = context.read<HerdDetailProvider>();
                Navigator.pop(context); 
                _createPDF(context, provider);
              },
              child: Text(
                "Export as PDF",
                style: TextStyle(fontSize: 14),
              ),
            ),
            TextButton(
              onPressed: () {
                final provider = context.read<HerdDetailProvider>();
                Navigator.pop(context);
                exportToExcelFromPDF(context, provider);
              },
              child: Text(
                "Export as Excel",
                style: TextStyle(fontSize: 14), 
              ),
            ),
          ],
        );
      },
    );
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
  icon: Icon(Icons.print),
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Export Options",
            style: TextStyle(fontSize: 18), 
          ),
          content: SizedBox(
            width: 300, 
            child: Text(
              "Choose the format to export the data:",
              style: TextStyle(fontSize: 14),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final provider = context.read<HerdDetailProvider>();
                Navigator.pop(context); 
                 _createPDF2(context, provider, entry);
              },
              child: Text(
                "Export as PDF",
                style: TextStyle(fontSize: 14),
              ),
            ),
            TextButton(
              onPressed: () {
                final provider = context.read<HerdDetailProvider>();
                Navigator.pop(context);
                 exportToExcel(context, provider, entry);
              },
              child: Text(
                "Export as Excel",
                style: TextStyle(fontSize: 14), 
              ),
            ),
          ],
        );
      },
    );
  },
),

                                          //    IconButton(
                                          //    icon: Icon(Icons.picture_as_pdf),
                                          //      onPressed: () {
                                          //  //   _createPDF2(context, provider, entry);
                                          //  exportToExcel(context, provider, entry);
                                          //        },
                                          //     ),
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
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Strength & Substance: ${entry.quiz1Score}",
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
                                               
                                              ],
                                            ),
                                            
                                             Divider(
                                              thickness: 2,
                                              color: AppColors.grey,
                                            ),
                                             Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                            
                                            
                                             Divider(
                                              thickness: 2,
                                              color: AppColors.grey,
                                            ),
                                             Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                  Text(
                                                  "Mobility: ${entry.quiz4Score}",
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
                                                
                                               
                                              ],
                                            ),
                                          
                                            Divider(
                                              thickness: 2,
                                              color: AppColors.grey,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                  Text(
                                                  "Mammary System: ${entry.quiz5Score}",
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