import '../entities/asset.dart';

abstract class AssetRepository {
  Future<List<AssetEntity>> getAssets();
}
