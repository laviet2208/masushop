import 'package:masumerchant/MasuMerchant/Data/accountData/shipperAccount.dart';
import 'package:masumerchant/MasuMerchant/Data/otherData/Time.dart';

class timeKeeping {
  shipperAccount owner;
  String reason;
  int reasonType;
  int shift;
  Time dayOff;

  timeKeeping({required this.reasonType, required this.shift, required this.reason, required this.dayOff, required this.owner});

  Map<dynamic, dynamic> toJson() => {
    'reason': reason,
    'reasonType': reasonType,
    'shift': shift,
    'dayOff': dayOff.toJson(),
    'owner': owner.toJson(),
  };

  factory timeKeeping.fromJson(Map<dynamic, dynamic> json) {
    return timeKeeping(
      reason: json['reason'].toString(),
      reasonType: int.parse(json['reasonType'].toString()),
      shift: int.parse(json['shift'].toString()),
      dayOff: Time.fromJson(json['dayOff']),
      owner: shipperAccount.fromJson(json['owner']),
    );
  }
}