import 'package:flutter/material.dart';
import 'package:flutter_application_breedersweb/constants/colors.dart';
import 'package:flutter_application_breedersweb/provider/herd_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HerdDetailPage extends StatelessWidget {
  final herd;

  const HerdDetailPage({super.key, required this.herd});

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
          'Herd Details',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 6.sp),
        ),
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
                                    trailing: Text(
                                      "Cow Id: ${entry.cowid}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 4.sp),
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
