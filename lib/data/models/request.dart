class RequestModel {
  late bool? isAccepted;
  late Map<String, dynamic>? caseDescription;
  String? id = "";

  RequestModel({this.isAccepted, this.caseDescription});

  RequestModel.fromJson(Map<String, dynamic> json) {
    isAccepted = json["isAccepted"] as bool;
    caseDescription = json["description"] as Map<String, dynamic>;
  }

  Map<String, dynamic> toJson(RequestModel request) => <String, dynamic>{
        "isAccepted": request.isAccepted,
        "description": request.caseDescription,
      };
}
