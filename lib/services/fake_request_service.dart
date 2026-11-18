import 'package:market_square/services/request_service.dart';
import 'package:market_square/models/request_model.dart';
import 'package:market_square/models/fetch_outcome.dart';

class FakeRequestService implements RequestService {
  @override
  Future<SubmissionOutcome> submitRegistration(
    NewTenantRequestModel request,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    if (request.emailAddress == 'error@email.com') {
      return SubmissionOutcome.error;
    } else if (request.emailAddress == 'invalid@email.com') {
      return SubmissionOutcome.invalid;
    } else {
      return SubmissionOutcome.accepted;
    }
  }

  @override
  Future<FetchResult> getRequests({
    RequestStatus? status,
    RequestType? type,
  }) async {
    return FetchResult(outcome: FetchOutcome.success);
  }

  @override
  Future<SubmissionOutcome> updateRequest(RequestModel updatedRequest) async {
    return SubmissionOutcome.accepted;
  }

  @override
  Future<SubmissionOutcome> approveRejectRequest(
    String requestId,
    RequestStatus status,
  ) async {
    return SubmissionOutcome.accepted;
  }
}
