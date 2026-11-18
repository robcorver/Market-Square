import 'package:market_square/models/building_model.dart';
import 'package:market_square/models/unit_model.dart';
import 'package:market_square/models/fetch_outcome.dart';

class FetchUnitsResult {
  FetchUnitsResult({required this.outcome, this.units = const []});

  final FetchOutcome outcome;
  final List<UnitModel> units;
}

class FetchBuildingsResult {
  FetchBuildingsResult({required this.outcome, this.buildings = const []});

  final FetchOutcome outcome;
  final List<BuildingModel> buildings;
}

abstract class PropertyService {
  // Get all buildings
  Future<FetchBuildingsResult> getBuildings();

  // Get sorted units for a given building
  Future<FetchUnitsResult> getUnits(String buildingId);
}
