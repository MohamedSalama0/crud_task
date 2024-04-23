import 'package:crud_task/model/branch_model.dart';
import 'package:crud_task/presentation/pages/branch%20details/controller/branch_details_provider.dart';
import 'package:crud_task/presentation/widgets/default_text_field.dart';
import 'package:crud_task/utils/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BranchDetails extends ConsumerStatefulWidget {
  final List<BranchModel> branches;
  final int index;
  final BranchModel branch;

  const BranchDetails({
    super.key,
    required this.branches,
    required this.index,
    required this.branch,
  });

  @override
  ConsumerState<BranchDetails> createState() => _BranchDetailsState();
}

class _BranchDetailsState extends ConsumerState<BranchDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70.w,
        leading: Row(
          children: [
            SizedBox(width: 5.w),
            const Icon(Icons.menu),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                ref.read(branchDetailsProvider).readData();
              },
            ),
          ],
        ),
        title: const Text(
          'Branch / store / cashier',
        ),
        titleTextStyle: const TextStyle(color: kWhite, fontSize: 16),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_rounded),
            onPressed: () {
              Navigator.pop(context);
              ref.read(branchDetailsProvider).addNewBranch(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              ref
                  .read(branchDetailsProvider)
                  .updateData(context, widget.branch.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return Expanded(
                        flex: 5,
                        child: DefaultTextFormFieldWithTitle(
                          fieldTitle: 'Branch',
                          readOnly: true,
                          controller: ref
                              .read(branchDetailsProvider)
                              .branchIdController,
                        ),
                      );
                    },
                  ),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return Expanded(
                        flex: 3,
                        child: DefaultTextFormFieldWithTitle(
                          fieldTitle: 'Custom No.',
                          controller: ref
                              .read(branchDetailsProvider)
                              .customNoController,
                          type: TextInputType.number,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  var prov = ref.read(branchDetailsProvider);
                  return Column(
                    children: [
                      DefaultTextFormFieldWithTitle(
                        fieldTitle: 'Arabic Name',
                        controller: prov.arabicNameController,
                      ),
                      SizedBox(height: 10.h),
                      DefaultTextFormFieldWithTitle(
                        fieldTitle: 'Arabic Description',
                        controller: prov.arabicDescriptionController,
                      ),
                      SizedBox(height: 10.h),
                      DefaultTextFormFieldWithTitle(
                        fieldTitle: 'English Name',
                        controller: prov.englishNameController,
                      ),
                      SizedBox(height: 10.h),
                      DefaultTextFormFieldWithTitle(
                        fieldTitle: 'English Description',
                        controller: prov.englishDescriptionController,
                      ),
                      SizedBox(height: 10.h),
                      DefaultTextFormFieldWithTitle(
                        fieldTitle: 'Note',
                        controller: prov.notesController,
                      ),
                      SizedBox(height: 10.h),
                      DefaultTextFormFieldWithTitle(
                        fieldTitle: 'Address',
                        controller: prov.addressController,
                      ),
                      SizedBox(height: 10.h),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration:
                  BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(
                  Icons.keyboard_double_arrow_left_outlined,
                  color: kWhite,
                ),
                onPressed: () {
                  navigateToPrevious();
                },
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_left_outlined),
                color: kWhite,
                onPressed: () {},
              ),
            ),
            Text(
              '${widget.branch.id}/${widget.branches.length}',
              style: const TextStyle(fontSize: 18),
            ),
            Container(
              decoration:
                  BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_right_outlined),
                color: kWhite,
                onPressed: () {},
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(
                  Icons.keyboard_double_arrow_right_outlined,
                  color: kWhite,
                ),
                onPressed: () {
                  navigateToNext();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToPrevious() {
    if (widget.branch.id != null && widget.index > 0) {
      final previousIndex = widget.index - 1;
      final previousBranch = widget.branches[previousIndex];
      ref.read(branchDetailsProvider).updateControllers(previousBranch);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BranchDetails(
            branch: previousBranch,
            index: previousIndex,
            branches: widget.branches,
          ),
        ),
      );
    }
  }

  void navigateToNext() {
    if (widget.branch.id != null && widget.index < widget.branches.length - 1) {
      final nextIndex = widget.index + 1;
      final nextBranch = widget.branches[nextIndex];
      ref.read(branchDetailsProvider).updateControllers(nextBranch);
      Navigator.pop(context); // Pop current screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BranchDetails(
            branch: nextBranch,
            branches: widget.branches,
            index: nextIndex,
          ),
        ),
      );
    }
  }
}
