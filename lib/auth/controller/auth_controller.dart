import 'package:flutter/material.dart';
import 'package:foodapp/auth/model/auth_token_model.dart';
import 'package:foodapp/auth/model/user_model.dart';
import 'package:foodapp/utils/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  bool _isLoading = false;

  var isLoggedIn = false.obs;
  bool get isLoading => _isLoading;
 
@override
  void onInit() {
    super.onInit();
    // Restore auth state from storage
    final token = GetStorage().read('token');
    if (token != null) {
      isLoggedIn.value = true;
    }
  }
  void setLoading() {
    _isLoading= !_isLoading;
  }

void loginFunc(String data, BuildContext ctx) async {
    setLoading();

    try {
      Uri url = Uri.parse('http://192.168.0.103:8000/auth/token/login/');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: data,
      );
      if (response.statusCode == 200) {
         
        setLoading();
        String accessToken = authTokenFromJson(response.body).authToken;
        GetStorage().write('accessToken', accessToken);
        isLoggedIn.value = true;

         getUser(accessToken, ctx);
       ctx.go('/');
    
      }
    } catch (e) {
      setLoading();
    }
  }
  void logout(BuildContext context) {
    GetStorage().remove('token');
    isLoggedIn.value = false;
    context.go(loginRoute);
  }
void registerFunc(String data) async {
    setLoading();

    try {
      Uri url = Uri.parse('http://192.168.0.103:8000/auth/users/');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: data,
      );
      if (response.statusCode == 201) {
        String accessToken = authTokenFromJson(response.body).authToken;

        GetStorage().write('accessToken', accessToken);
        
        setLoading();
      } else if (response.statusCode == 400) {
        setLoading();
      }
    } catch (e) {
      setLoading();
      print(e.toString());
    }
  }

  void getUser(String accessToken, BuildContext ctx) async {
    setLoading();

    try {
      Uri url = Uri.parse('http://192.168.0.103:8000/auth/users/me/');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
          setLoading();
        GetStorage().write(accessToken, response.body);

      
    
      } else if (response.statusCode == 400) {
        setLoading();
      }
    } catch (e) {
      setLoading();
    }
  }

  //Tomas
//tomas@gmail.com
//1234abcRw@#qqq

  UserModel? userData() {
    final accessToken = GetStorage().read('accessToken');

    if (accessToken != null) {
      final data = GetStorage().read(accessToken);
      if (data != null) {
        return userModelFromJson(data);
      }
    }
    return null;
  }
}
