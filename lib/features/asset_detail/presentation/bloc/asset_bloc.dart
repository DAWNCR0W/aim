import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_assets.dart';
import 'asset_event.dart';
import 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final GetAssets getAssets;

  AssetBloc({required this.getAssets}) : super(AssetInitial()) {
    on<FetchAssets>((event, emit) async {
      emit(AssetLoading());
      try {
        final assets = await getAssets();
        emit(AssetLoaded(assets));
      } catch (e) {
        emit(AssetError(e.toString()));
      }
    });
  }
}
