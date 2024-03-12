import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:testban/utils/constants.dart';

class AuthService {
  SharedPreferences prefs;
  String token;

  AuthService() {
    // SharedPreferences.getInstance().then((res) {
    //   token = res.getString("token");
    // });
  }

  Future<bool> login(String phone, String password) async {
    prefs = await SharedPreferences.getInstance();
    Map data = {
      'phone': phone,
      'password': password
    };
    //print(data);
print(jsonEncode(data));
/*var source=jsonEncode(data);
print (jsonDecode(source));*/
    print(API_BASE_URL);

    try {
      final response = await http.post('$API_BASE_URL/login.php',
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          //body: json.encode({"mobile_wallet": phone, "password": password})
          body: jsonEncode(data),
          //body: data,
          encoding: Encoding.getByName("utf-8")
      );
      print("status code"+ response.statusCode.toString());

      if (response.statusCode == 200) {
        print("your response  ${response.body}");
         print("${response.body}");
        Map resData = json.decode(response.body);
        print("your response  $resData");
        print("your response  ${resData['message']}");
        if (resData['message'] != 'success') {
          return Future.value(false);
        } else {
          String token = resData['token'];
          String message = resData['message'];
           print("your message: $message");
           print("Set Token: $token");
          prefs.setString("token", token);
          return Future.value(true);
        }
      } else {

        print('Failed to login on last else');
        return Future.value(false);
      }
    } catch (e) {
      print('error occured');
      print(e.toString());
      return Future.error(
          'error occurred make sure you have internet connection');
    }
  }

  Future<bool> checkLoginStatus() async {
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    // final tokenDecode = json.decode(token);
    print(token);
    if (token != "" && token != null) {
      // json.decode(token);
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> resetPasscode(String phone) async {
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    final response =
        await http.post('$API_BASE_URL/api/v1/auth/agents/forgotpassword',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode({"mobile_wallet": phone}));
     print(' my response ${phone}');
     print(' my response ${response.body}');
    // print(' my response ${response.statusCode}');
    if (response.statusCode == 200) {
      Map resData = json.decode(response.body);
      // print(resData);
      if (resData['status'] == 'SUCCESSFUL') {
        print(resData);
        return Future.value(true);
      } else {
        print(resData);
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  Future<bool> finalresetPasscode(String agentID) async {
    final response =
        await http.post('$API_BASE_URL/api/v1/auth/agents/resetpassword',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode({"agentId": agentID}));
    print(' my final response $agentID');
    print(' my final response ${response.body}');
    print(' my final response ${response.statusCode}');
    // if (response.statusCode == 200) {
    //   Map resData = json.decode(response.body);
    //   // print(resData);
    //   if (resData['status'] == 'SUCCESSFUL') {
    //     print(resData);
    //     return Future.value(true);
    //   } else {
    //     print(resData);
    //     return Future.value(false);
    //   }
    // } else {
    //   return Future.value(false);
    // }
  }

  Future<bool> authTxn(String password) async {
    Map data = {
      'password': password
    };    prefs = await SharedPreferences.getInstance();



    return true;
  }
  /*Future<bool> authTxn(String password) async {
    Map data = {
      'password': password
    };    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    var authResp = await rootBundle.loadString('assets/json/authorise.json');
      Map resData = json.decode(authResp);
      print(resData);
        print(resData);
        if (resData['isAuthorized']) {
          print(resData);
          return Future.value(true);
        } else if (resData['is_error']) {
          print(resData);
          return Future.error(resData['message']);
        } else {
          return Future.error(resData['message']);
        }



    return true;


    // try {
    //   final response =
    // await http.post('$API_BASE_URL/api/v1/auth/agents/forgetpassword',
    //           await http.post('$API_BASE_URL/api/v1/auth/agents/resetpassword...agentId',

    //           headers: {
    //             'Content-Type': 'application/json',
    //             'Accept': 'application/json',
    //             'Authorization': 'Bearer $token'
    //           },
    // body: json.encode({
    //   "mobile_wallet": wallet,
    //   "password": password}));

    //   if (response.statusCode == 200) {
    //     Map res_data = json.decode(response.body);
    //     print(res_data);
    //     if (res_data['is_error']) {
    //       return Future.error(res_data['msg']);
    //     } else {
    //       if (res_data['isAuthorized']) {
    //         return Future.value(true);
    //       }
    //       // return Future.error(res_data['msg']);
    //     }
    //   } else {
    //     print(response.body);

    //     return Future.error('Error contacting server');
    //   }
    // } c
  }*/

  Future<bool> changePassword(
      String curPassword, String newPassword, String newPassword2) async {
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    try {
      final response = await http.post('$API_BASE_URL/api/v1/user/set-password',
          headers: {'Content-Type': 'application/json', 'token': token},
          body: json.encode({
            "current_password": curPassword,
            "new_password": newPassword,
            "new_password_confirm": newPassword2
          }));

      if (response.statusCode == 200) {
        Map res_data = json.decode(response.body);
        print(res_data);
        if (res_data['is_error']) {
          return Future.error(res_data['msg']);
        } else {
          return Future.value(true);
        }
      } else {
        return Future.error('Error contacting server');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
