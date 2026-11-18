import 'package:market_square/services/property_service.dart';
import 'package:market_square/models/building_model.dart';
import 'package:market_square/models/unit_model.dart';
import 'package:market_square/models/fetch_outcome.dart';

class FakePropertyService implements PropertyService {
  @override
  Future<FetchBuildingsResult> getBuildings() async {
    return FetchBuildingsResult(
      outcome: FetchOutcome.success,
      buildings: [
        BuildingModel(
          id: '01',
          name: 'Riverbank Commons',
          address: '560 Market Street, Newark',
        ),
        BuildingModel(
          id: '02',
          name: 'Main St Commons',
          address: '100 Main Street, Newark',
        ),
      ],
    );
  }

  @override
  Future<FetchUnitsResult> getUnits(String buildingId) async {
    await Future.delayed(const Duration(seconds: 1));

    final List<UnitModel> units = [];

    if (buildingId == '01') {
      for (int floor = 1; floor <= 4; floor++) {
        for (int unit = 1; unit <= 14; unit++) {
          final String aptNumber = '$floor${unit.toString().padLeft(2, '0')}';
          units.add(
            UnitModel(
              id: 'unit-$aptNumber',
              buildingId: '01',
              aptNumber: aptNumber,
            ),
          );
        }
      }
    }

    return FetchUnitsResult(outcome: FetchOutcome.success, units: units);
  }
}
