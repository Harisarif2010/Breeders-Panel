
import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/constants/images.dart';

import 'package:sizer/sizer.dart';

class HerdDetailPage extends StatefulWidget {
  final herd;

  const HerdDetailPage({super.key, required this.herd});

  @override
  State<HerdDetailPage> createState() => _HerdDetailPageState();
}

class _HerdDetailPageState extends State<HerdDetailPage> {
  List<ScoringEntry> scoringEntries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    mockFetchScoringEntries();
  }

  // Mock function to simulate data loading
  void mockFetchScoringEntries() async {
    // Mock data
    scoringEntries = [
      ScoringEntry(
        scoringEntry: 'Score 1',
        name: 'Cow A',
        dob: '2021-05-10',
        sire: 'Sire A',
        dam: 'Dam A',
        finalScore: 85,
        timeOfCalved: '2022-04-15',
      ),
      ScoringEntry(
        scoringEntry: 'Score 2',
        name: 'Cow B',
        dob: '2020-03-22',
        sire: 'Sire B',
        dam: 'Dam B',
        finalScore: 78,
        timeOfCalved: '2021-02-18',
      ),
    ];

    // Simulate a delay
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
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
          'Detail',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 6.sp
          )
        ),
       
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontSize: 6.sp
                            )
                        ),
                        SizedBox(height: 2.h),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: scoringEntries.length,
                          itemBuilder: (BuildContext context, int index) {
                            final entry = scoringEntries[index];
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
                                      trailing: Text(
                                        "${entry.scoringEntry}",
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 4.sp
                            )
                                      ),
                                      title: Text(
                                        "Name: ${entry.name}",
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 4.sp
                            )
                                      ),
                                      subtitle: Text(
                                        "Dob: ${entry.dob}",
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 4.sp
                            )
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
                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 4.sp
                            )
                                                  ),
                                                  Text(
                                                    "Dam: ${entry.dam}",
                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 
                             4 .sp
                            )
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Final Score: ${entry.finalScore}",
                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 4.sp
                            )
                                                  ),
                                                  Text(
                                                    "Time of Calved: ${entry.timeOfCalved}",
                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 
                              4.sp
                            )
                                                  ),
                                                ],
                                              ),
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
            ),
    );
  }
}

// Mock ScoringEntry model class
class ScoringEntry {
  final String scoringEntry;
  final String name;
  final String dob;
  final String sire;
  final String dam;
  final int finalScore;
  final String timeOfCalved;

  ScoringEntry({
    required this.scoringEntry,
    required this.name,
    required this.dob,
    required this.sire,
    required this.dam,
    required this.finalScore,
    required this.timeOfCalved,
  });
}
