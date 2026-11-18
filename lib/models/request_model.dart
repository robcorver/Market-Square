enum RequestStatus { pending, approved, rejected, resolved }

enum RequestType { registration, support, feature }

class NewTenantRequestModel {
  NewTenantRequestModel({
    required this.lastName,
    required this.emailAddress,
    required this.buildingId,
    required this.unitId,
    this.firstName,
  });

  final String lastName;
  final String emailAddress;
  final String buildingId;
  final String unitId;
  final String? firstName;
}

class RequestModel {
  RequestModel({
    required this.id,
    required this.requestStatus,
    required this.requestType,
    required this.lastName,
    required this.emailAddress,
    this.buildingId,
    this.unitId,
    this.firstName,
  });

  final String id;
  final RequestStatus requestStatus;
  final RequestType requestType;
  final String lastName;
  final String emailAddress;
  final String? buildingId;
  final String? unitId;
  final String? firstName;
}
