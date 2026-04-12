import 'models/basic_info.dart';
import 'models/property_info.dart';
import 'models/solar_proposal.dart';
import 'models/uploaded_document.dart';
import 'models/agreement.dart';
import 'models/property_photo.dart';
import 'models/inspection_schedule.dart';
import 'models/solar_onboarding_state.dart';

abstract class SolarRepository {
  Future<SolarProposal> generateProposal({
    required BasicInfo basicInfo,
    required PropertyInfo propertyInfo,
    required SystemType systemType,
  });

  Future<CreditStatus> checkCredit({required String userId});

  Future<List<Agreement>> getAgreements();

  Future<void> submitDocuments({
    required String userId,
    required List<UploadedDocument> documents,
  });

  Future<void> submitPropertyPhotos({
    required String userId,
    required List<PropertyPhoto> photos,
  });

  Future<bool> reviewPropertyPhotos({
    required String userId,
    required List<PropertyPhoto> photos,
  });

  Future<List<DateTime>> getAvailableInspectionDates();

  Future<InspectionSchedule> scheduleInspection({
    required String userId,
    required DateTime date,
    required String timeSlot,
  });

  Future<void> completeOnboarding({required String userId});
}
