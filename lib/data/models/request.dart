class RequestModel {
  late bool? isAccepted;
  late Map<String, dynamic>? caseDescription;
  String? id = "";

  RequestModel({this.isAccepted, this.caseDescription, this.id});

  RequestModel.fromJson(Map<String, dynamic> json) {
    isAccepted = json["isAccepted"];
    caseDescription = json["description"] as Map<String, dynamic>;
    id = json["id"];
  }

  Map<String, dynamic> toJson(RequestModel request) => <String, dynamic>{
        "isAccepted": request.isAccepted,
        "description": request.caseDescription,
        "id": request.id,
      };
}
