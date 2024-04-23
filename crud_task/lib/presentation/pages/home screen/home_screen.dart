import 'package:crud_task/model/branch_model.dart';
import 'package:crud_task/presentation/pages/branch%20details/branch_details.dart';
import 'package:crud_task/presentation/pages/branch%20details/controller/branch_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    print('init home');
    ref.read(branchDetailsProvider).readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Branches'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_rounded),
            onPressed: () {
              ref.read(branchDetailsProvider).addNewBranch(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                List<BranchModel> branches =
                    ref.watch(branchDetailsProvider).branchesList;
                if (branches.isEmpty) {
                  return const Center(
                    child: Text('No Data Founded'),
                  );
                }
                return ListView.builder(
                  itemCount: branches.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ref
                            .read(branchDetailsProvider)
                            .updateControllers(branches[index]);
                        print('branch $index');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BranchDetails(
                              branch: branches[index],
                              branches: branches,
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text('branch ${branches[index].id}'),
                        subtitle: Text('brach ${branches[index].englishName}'),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
