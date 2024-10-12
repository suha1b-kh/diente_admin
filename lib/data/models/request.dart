class RequestModel {
  late Map<String, dynamic>? caseDescription;
  String? id = "";

  RequestModel({this.caseDescription, this.id});

  RequestModel.fromJson(Map<String, dynamic> json) {
    caseDescription = json["description"] as Map<String, dynamic>;
    id = json["patientId"];
  }

  Map<String, dynamic> toJson(RequestModel request) => <String, dynamic>{
        "description": request.caseDescription,
        "patientId": request.id,
      };
}
