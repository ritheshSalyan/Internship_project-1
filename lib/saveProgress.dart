import 'package:shared_preferences/shared_preferences.dart';

class SaveProgress{
  static preferences(String modNum, String index) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("${modNum}", modNum);
    sharedPreferences.setString("${index}", index);
    print(sharedPreferences.getString("$modNum"));
    
    
  }
}