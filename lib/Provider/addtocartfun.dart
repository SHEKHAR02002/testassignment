import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testassignment/Screens/Theme/constant.dart';

class SetData {
  void setaddtocartids({required String id, required WidgetRef ref}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final addtocart = ref.watch(addtocarproductid);
    addtocart.add(id.toString());
    ref.watch(addtocarproductid.notifier).state = [...addtocart];
    pref.setStringList('addtocart', addtocart);
  }
}

bool check({required String id, required List<String> list}) {
  if (list.contains(id)) {
    return true;
  } else {
    return false;
  }
}
