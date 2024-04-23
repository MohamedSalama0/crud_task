import 'dart:convert';

class BranchModel {
  int? id;
  int? customNo;
  String? arabicName;
  String? englishName;
  String? arabicDescription;
  String? englishDescription;
  String? note;
  String? address;
  BranchModel({
    this.id,
    this.customNo,
    this.arabicName,
    this.englishName,
    this.arabicDescription,
    this.englishDescription,
    this.note,
    this.address,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'branchId': id});
    }
    if(customNo != null){
      result.addAll({'customNo': customNo});
    }
    if(arabicName != null){
      result.addAll({'arabicName': arabicName});
    }
    if(englishName != null){
      result.addAll({'englishName': englishName});
    }
    if(arabicDescription != null){
      result.addAll({'arabicDescription': arabicDescription});
    }
    if(englishDescription != null){
      result.addAll({'englishDescription': englishDescription});
    }
    if(note != null){
      result.addAll({'note': note});
    }
    if(address != null){
      result.addAll({'address': address});
    }
  
    return result;
  }

  factory BranchModel.fromMap(Map<String, dynamic> map) {
    return BranchModel(
      id: map['branchId']?.toInt(),
      customNo: map['customNo']?.toInt(),
      arabicName: map['arabicName'],
      englishName: map['englishName'],
      arabicDescription: map['arabicDescription'],
      englishDescription: map['englishDescription'],
      note: map['note'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchModel.fromJson(String source) => BranchModel.fromMap(json.decode(source));
}
