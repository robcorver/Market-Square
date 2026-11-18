import 'package:market_square/models/request_model.dart';
import 'package:market_square/models/fetch_outcome.dart';

enum SubmissionOutcome { accepted, invalid, error }

class FetchResult {
  FetchResult({required this.outcome, this.requests = const []});

  final FetchOutcome outcome;
  final List<RequestModel> requests;
}

abstract class RequestService {
  // Submit new tenant request
  Future<SubmissionOutcome> submitRegistration(NewTenantRequestModel request);

  // Retrieve requests
  Future<FetchResult> getRequests({RequestStatus? status, RequestType? type});

  // Update request
  Future<SubmissionOutcome> updateRequest(RequestModel updatedRequest);

  // Approve or Reject request
  Future<SubmissionOutcome> approveRejectRequest(
    String requestId,
    RequestStatus status,
  );
}
