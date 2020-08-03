import 'dart:convert';

import 'package:classy/models/responses/base_response.dart';
import 'package:classy/utils/constant.dart';
import 'package:http/http.dart' as http;


class ProviderClient<T> {

  var client = http.Client();

  Future<BaseResponse> post(T request, String path) async {

    Map<String, String> headers = {"Content-type": "application/json"};

    try {

      http.Response response = await client.post(URL + path, body: jsonEncode(request), headers: headers);

      BaseResponse bResponse = BaseResponse.fromJson(json.decode(response.body));
      bResponse.statusCode = response.statusCode;

      return bResponse;

    } catch (e) {

      print(e);
      return BaseResponse(statusCode: 500);
    }
  }

  Future<BaseResponse> get({String request, String path}) async {

    Map<String, String> headers = {"Content-type": "application/json"};

    if (null != request) {
      request = URL + path + request;
    } else {
      request = URL + path;
    }
    
    try {

      http.Response response = await client.get(request, headers: headers);

      BaseResponse bResponse = BaseResponse.fromJson(json.decode(response.body));
      bResponse.statusCode = response.statusCode;

      return bResponse;

    } catch (e) {

      print(e);
      return BaseResponse(statusCode: 500);
    }
  }

  Future<BaseResponse> delete({String request, String path}) async {

    Map<String, String> headers = {"Content-type": "application/json"};

    if (null != request) {
      request = URL + path + request;
    } else {
      request = URL + path;
    }
    
    try {

      http.Response response = await client.delete(request, headers: headers);

      BaseResponse bResponse = BaseResponse.fromJson(json.decode(response.body));
      bResponse.statusCode = response.statusCode;

      return bResponse;

    } catch (e) {

      print(e);
      return BaseResponse(statusCode: 500);
    }
  }
}