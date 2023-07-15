class AppResponse<T> {
  String? result;
  T? data;
  String? message;

  AppResponse.fromJson(Map<String, dynamic> json, Function parseData) {
    result = json["result"];
    data = parseData(json["data"]);
    message = json["message"];
  }
}