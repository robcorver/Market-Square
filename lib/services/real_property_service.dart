import 'package:flutter/material.dart';
import 'package:market_square/services/property_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:market_square/models/building_model.dart';
import 'package:market_square/models/unit_model.dart';
import 'package:market_square/models/fetch_outcome.dart';

class RealPropertyService implements PropertyService {
  final client = Supabase.instance.client;

  @override
  Future<FetchBuildingsResult> getBuildings() async {
    try {
      final rows = await client.from('buildings').select();

      List<BuildingModel> allBuildings = rows
          .map(
            (row) => BuildingModel(
              id: row['id'] as String,
              name: row['name'] as String,
              address: row['address'] as String,
            ),
          )
          .toList();

      return FetchBuildingsResult(
        outcome: FetchOutcome.success,
        buildings: allBuildings,
      );
    } catch (e) {
      debugPrint('$e');
      return FetchBuildingsResult(outcome: FetchOutcome.error);
    }
  }

  @override
  Future<FetchUnitsResult> getUnits(String buildingId) async {
    try {
      final rows = await client
          .from('units')
          .select()
          .eq('building_id', buildingId)
          .order('apartment_number', ascending: true);

      final List<UnitModel> allUnits = rows
          .map(
            (row) => UnitModel(
              id: row['id'] as String,
              buildingId: row['building_id'] as String,
              aptNumber: row['apartment_number'] as String,
            ),
          )
          .toList();

      return FetchUnitsResult(outcome: FetchOutcome.success, units: allUnits);
    } catch (e) {
      debugPrint('$e');
      return FetchUnitsResult(outcome: FetchOutcome.error);
    }
  }
}
