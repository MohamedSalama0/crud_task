import 'package:crud_task/data/source/sql%20db/sql_db.dart';
import 'package:crud_task/model/branch_model.dart';
import 'package:crud_task/presentation/pages/branch%20details/branch_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final branchDetailsProvider =
    ChangeNotifierProvider((ref) => BranchDetailsProvider());

class BranchDetailsProvider extends ChangeNotifier {
  TextEditingController branchIdController = TextEditingController();
  TextEditingController customNoController = TextEditingController();
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController arabicDescriptionController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController englishDescriptionController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<BranchModel> branchesList = [];
  FocusScopeNode customNoFocus = FocusScopeNode();
  FocusScopeNode arabicNameFocus = FocusScopeNode();
  FocusScopeNode arabicDescFocus = FocusScopeNode();
  FocusScopeNode englishNameFocus = FocusScopeNode();
  FocusScopeNode englishDescFocus = FocusScopeNode();
  FocusScopeNode notesFocus = FocusScopeNode();
  FocusScopeNode addressFocus = FocusScopeNode();

// create function to go to the nextfocus node

  void nextFocus(BuildContext context) {
    List<FocusScopeNode> nodes = [
      customNoFocus,
      arabicNameFocus,
      arabicDescFocus,
      englishNameFocus,
      englishDescFocus,
      notesFocus,
      addressFocus
    ];

    int index = nodes.indexWhere((element) => element.hasFocus);
    if (index < nodes.length - 1) {
      isFirstNode = false;
      notifyListeners();
      FocusScope.of(context).requestFocus(nodes[index + 1]);
      if (index == 5) {
        isLastNode = true;
        notifyListeners();
      }
    }
  }


  bool isFirstNode = true;
  bool isLastNode = false;
  void previousFocus(BuildContext context) {
    List<FocusScopeNode> nodes = [
      customNoFocus,
      arabicNameFocus,
      arabicDescFocus,
      englishNameFocus,
      englishDescFocus,
      notesFocus,
      addressFocus
    ];

    int index = nodes.indexWhere((element) => element.hasFocus);
    if (index > 0) {
      isLastNode = false;
      notifyListeners();
      print('index $index');
      FocusScope.of(context).requestFocus(nodes[index - 1]);
      if (index == 1) {
        isFirstNode = true;
        notifyListeners();
      }
    }
  }

  final SqlDb _db = SqlDb();
  addNewBranch(context) async {
    int newBranchId = await _db.insertData('''
    INSERT INTO "branches" (
      custom_no,
      arabic_name,
      arabic_description,
      english_name,
      english_description,
      note,
      address
    )
    VALUES(0,'','','','','','')
    
    ''');
    branchIdController.text = newBranchId.toString();
    await readData();
    _goToBranchDetails(context, newBranchId);
  }

  _goToBranchDetails(context, id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BranchDetails(
                  branch: BranchModel(id: id),
                  branches: branchesList,
                  index: id,
                )));
  }

  updateControllers(BranchModel branch) {
    branchIdController.text = branch.id.toString();
    customNoController.text = branch.customNo.toString();
    arabicNameController.text = branch.arabicName.toString();
    arabicDescriptionController.text = branch.arabicDescription.toString();
    englishNameController.text = branch.englishName.toString();
    englishDescriptionController.text = branch.englishDescription.toString();
    notesController.text = branch.note.toString();
    addressController.text = branch.address.toString();
    // notifyListeners();
  }

  readData() async {
    List<Map> response = await _db.readData('SELECT * FROM "branches" ');
    final List<BranchModel> branches = response.map((map) {
      return BranchModel(
        id: map['id'] as int?,
        customNo: map['custom_no'] as int?,
        arabicName: map['arabic_name'] as String?,
        englishName: map['english_name'] as String?,
        arabicDescription: map['arabic_description'] as String?,
        englishDescription: map['english_description'] as String?,
        note: map['note'] as String?,
        address: map['address'] as String?,
      );
    }).toList();

    branchesList = branches;
    notifyListeners();
  }

  updateData(context, branchId) async {
    final db = await _db.db;
    await db!.update(
      'branches',
      {
        'custom_no': customNoController.text,
        'arabic_name': arabicNameController.text,
        'english_name': englishNameController.text,
        'arabic_description': arabicDescriptionController.text,
        'english_description': englishDescriptionController.text,
        'note': notesController.text,
        'address': addressController.text,
      },
      where: 'id = ?',
      whereArgs: [branchId],
    );
    readData();
    navigateBack(context);
  }

  navigateBack(context) {
    Navigator.pop(context);
    notifyListeners();
  }
}
