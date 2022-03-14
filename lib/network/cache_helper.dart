import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  })  {
    return sharedPreferences!.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  })async{
    if(value is String ) return await sharedPreferences!.setString(key, value);
    if(value is int) return await sharedPreferences!.setInt(key, value);
    if(value is bool) return await sharedPreferences!.setBool(key, value);

    return await sharedPreferences!.setDouble(key, value);
  }


  static Future<bool> removeData({
    required String key
  })async {
    return await sharedPreferences!.remove(key);
    //////in signout button
    ////CacheHelper.removeData(key: 'token').then((value){
    //// if(value){navigateandFinish(context,loginScreen()))}}\


    //////////*********mohmaaaaaaa********//////////
    /////navigateAndFinish(context,widget)=>
    //////Navigator.pushAndRemoveUtil(context,
    ////////MaterialPageRoute( builder :(context) => widget),
    ////////(Route<dynamic> route )=>false,);
  }
/////in main
//////Widget widget;
/////String token = CacheHelper.getData(key: 'token');
////if(token != null) widget= HomeScreen;
/////else widget= Login;
///////////++ runApp(MyApp(startWidget: widget));

/////////////msh mohma////++ home: Key? HomeScreen : LoginScreen,
///// gwa l onpressed(){ CacheHelper.saveData('Key',true/Aw state.model.data.token).
// then((value){ navigateTo()});}
}
