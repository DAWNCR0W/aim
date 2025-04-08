import '../entities/asset.dart';
import '../repository/asset_repository.dart';

class GetAssets {
  final AssetRepository repository;

  GetAssets(this.repository);

  Future<List<AssetEntity>> call() async {
    return await repository.getAssets();
  }
}
