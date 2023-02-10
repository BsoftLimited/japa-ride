import 'dart:io';

import 'package:japa/utils/util.dart';
import 'package:http/http.dart' as http;
import "dart:convert" show json;

class Service {
    String host;
    List<Map<String, dynamic>> params = [];
    bool busy = false;
    Function(bool succeed, String data, String request) listener;

    Service({required this.host, required this.listener});

    void start({Map<String, dynamic> params = const {}}) {
      if (busy) {
        this.params.add(params);
      } else {
        busy = true;
        __request(params: params);
      }
    }

    void __request({required Map<String, dynamic> params}) async {
        bool succeed = false;
        try{
            final jsonString = json.encode(params);
            final uri = Uri.parse(Util.HomeUri + host);
            final headers = { HttpHeaders.contentTypeHeader: "application/json;charset=UTF-8", HttpHeaders.acceptHeader: "application/json"};

            Future<http.Response> init = http.post(uri, body: jsonString, headers: headers);
            String result = await init.then<String>((value) {
                succeed = value.statusCode == 200 || value.statusCode == 201;
                return __processData(value);
            }).onError<String>((error, stackTrace) => __processError(error, stackTrace));

            listener(succeed, result, jsonString);
        }catch(ex){
            listener(false, ex.toString(), params.toString());
        }

        if (this.params.isNotEmpty) {
            var param = this.params.first;
            if (this.params.remove(0)) {
                __request(params: param);
            }
        } else {
            busy = false;
        }
    }

    Future<String> __processData(http.Response response) async {
        return response.body;
    }

    Future<String> __processError(String error, StackTrace stackTrace) async {
        return stackTrace.toString();
    }
}
