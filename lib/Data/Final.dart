import 'package:masumerchant/Data/accountShop.dart';

import 'Time.dart';

final Time type = Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0);
final accountShop currentAccount = accountShop(openTime: Time.getCurrentTime(), OpenStatus: 1, ListDirectory: [], closeTime: Time.getCurrentTime(), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time.getCurrentTime(), password: '', isTop: 1, Type: 1, Area: '');