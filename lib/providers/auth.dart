import 'package:flutter/material.dart';

class AuthNotifier with ChangeNotifier {
  // Future<void> registerUser(data) async {
  //   try {
  //     String url = kBaseUrl + "api/v1/customers/register/";
  //     var res = await http.post(Uri.parse(url), headers: {
  //       'Accept': 'application/json',
  //       "Content-Type": "application/x-www-form-urlencoded",
  //     }, body: {
  //       "phone": data.phoneNumber,
  //     });
  //     if (res.body.isNotEmpty && res.statusCode == 200) {
  //       var respBody = json.decode(res.body);
  //       print(respBody);
  //     } else {
  //       print("Empty body or status failed");
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }

  // Customer? _customer;

  // Customer? get customer {
  //   return _customer;
  // }

  // Future<void> signup(
  //   String? phone,
  // ) async {
  //   // print("======>>>>> signing up user");
  //   // final url = kBaseURL + 'api/v1/users/register-customer/';
  //   try {
  //     final prefs = await SharedPreferences.getInstance();

  //     // if (prefs.containsKey('phone')) {
  //     //   if (prefs.getString('phone') == phone) {
  //     //     print("User already exists");
  //     //   } else {
  //     //     _signIn(phone!, prefs);
  //     //   }
  //     // } else {
  //     //   _signIn(phone!, prefs);
  //     // }
  //     _signIn(phone!, prefs);

  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // void _signIn(String phone, prefs) async {
  //   final url = kBaseUrl + 'api/v1/customers/check-and-login/';
  //   // print("======>>>>> signing in user");
  //   final response = await http.post(
  //     Uri.parse(url),
  //     body: {
  //       'phone': phone,
  //     },
  //   );
  //   final responseData = json.decode(response.body);
  //   // print("======>>$responseData");
  //   if (responseData['error'] != null) {
  //     throw HttpException(responseData['error']['message']);
  //   }

  //   prefs.setString('phone', phone);
  //   prefs.setString('token', responseData['token']['access']);
  //   // prefs.setString('password', responseData['password']);
  //   print(responseData);
  // }

  // void updateUser(String? username, String? email) async {
  //   print("updating user");
  //   try {
  //     String url = kBaseUrl + "api/v1/customers/update-profile/";
  //     final prefs = await SharedPreferences.getInstance();
  //     String token = prefs.getString('token').toString();
  //     var res = await http.post(Uri.parse(url), headers: {
  //       'Accept': 'application/json',
  //       "Content-Type": "application/x-www-form-urlencoded",
  //       'Authorization': 'Bearer $token',
  //     }, body: {
  //       'name': username,
  //       'email': email,
  //     });
  //     if (res.body.isNotEmpty && res.statusCode == 200) {
  //       var respBody = json.decode(res.body);
  //       await getUserData();
  //       print(respBody);
  //     } else {
  //       print("Empty body or status failed");
  //     }
  //   } catch (e) {
  //     throw (e);
  //   }
  // }

  // Future<Customer> getUserData() async {
  //   print("get user data fn");
  //   String url = kBaseUrl + "api/v1/customers/get-profile";
  //   final prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token').toString();
  //   try {
  //     final response = await http.get(Uri.parse(url), headers: {
  //       'Accept': 'application/json',
  //       "Content-Type": "application/x-www-form-urlencoded",
  //       'Authorization': 'Bearer $token',
  //     });
  //     // print("response is $response");
  //     final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
  //     print("extractedData is ${extractedData['data']}");
  //     Customer customer = new Customer(
  //       id: extractedData['data']['id'].toString(),
  //       name: extractedData['data']['name'],
  //       phone: prefs.getString('userPhone').toString(),
  //       email: extractedData['data']['email'],
  //     );
  //     _customer = customer;
  //     print("customer is $customer");
  //     notifyListeners();
  //     return customer;
  //     // print(_categories);
  //   } catch (error) {
  //     print("error is $error");
  //     throw (error);
  //   }
  // }

  // valueUpdate() {
  //   notifyListeners();
  // }
}
