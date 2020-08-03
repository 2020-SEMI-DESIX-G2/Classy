
class BaseResponse {

  Map<String, dynamic> payload;
  int statusCode;

  BaseResponse({this.statusCode});

  @override
  BaseResponse.fromJson(Map<String, dynamic> json) {

    this.payload = json['payload'];
  }
}