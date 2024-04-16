
import 'Time.dart';
import 'Voucher.dart';
import 'accountLocation.dart';

class accountNormal {
  String phoneNum;
  String id;
  String name;
  int type;
  int status;
  int WorkStatus; // 0 : đang off, 1 : đang onl
  String Area;
  double totalMoney;
  Time createTime;
  String license;
  accountLocation locationHis;
  List<Voucher> voucherList = [];
  String avatarID;

  accountNormal({required this.id, required this.avatarID, required this.createTime, required this.status, required this.name, required this.phoneNum, required this.type, required this.locationHis, required this.voucherList, required this.totalMoney, required this.Area, required this.license, required this.WorkStatus});

  Map<dynamic, dynamic> toJson() => {
    'phoneNum': phoneNum,
    'locationHis': locationHis.toJson(),
    'id' : id,
    'name' : name,
    'status' : status,
    'createTime' : createTime.toJson(),
    'avatarID' : avatarID,
    'type' : type,
    'voucherList' : voucherList.map((Voucher) => Voucher.toJson()).toList(),
    'totalMoney' : totalMoney,
    'Area' : Area,
    'license' : license,
    'WorkStatus' : WorkStatus
  };

  factory accountNormal.fromJson(Map<dynamic, dynamic> json) {
    List<Voucher> voucherList = [];

    if (json["voucherList"] != null) {
      for (final result in json["voucherList"]) {
        voucherList.add(Voucher.fromJson(result));
      }
    }

    return accountNormal(
      id: json['id'].toString(),
      avatarID: json['avatarID'].toString(),
      createTime: Time.fromJson(json['createTime']),
      status: int.parse(json['status'].toString()),
      name: json['name'].toString(),
      phoneNum: json['phoneNum'].toString(),
      type: int.parse(json['type'].toString()),
      locationHis: accountLocation.fromJson(json['locationHis']),
      voucherList: voucherList,
      totalMoney: double.parse(json['totalMoney'].toString()),
      Area: json['Area'].toString(), license: json['license'],
      WorkStatus: int.parse(json['WorkStatus'].toString()),
    );
  }

  void changeData(Map<dynamic, dynamic> json) {
    this.id = json['id'].toString();
    this.avatarID = json['avatarID'].toString();
    this.createTime = Time.fromJson(json['createTime']);
    this.status = int.parse(json['status'].toString());
    this.name = json['name'].toString();
    this.phoneNum = json['phoneNum'].toString();
    this.type = int.parse(json['type'].toString());
    this.locationHis = accountLocation.fromJson(json['locationHis']);
    this.voucherList = [];
    this.totalMoney = double.parse(json['totalMoney'].toString());
    this.Area = json['Area'].toString();
    this.license = json['license'].toString();
    this.WorkStatus = int.parse(json['WorkStatus'].toString());
  }

}