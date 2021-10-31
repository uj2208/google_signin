import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelper {
  Future getData() async {
    var url = Uri.parse('https://recengine.intoday.in/recengine/at/getarticles');
    Response response = await get(url);
    if (response.statusCode == 200) {
      String rsp = response.body;
     // print(jsonDecode(rsp).toString());
      return jsonDecode(rsp);
    }
    else {
      print(response.statusCode);
      return "abc";
    }
  }
}