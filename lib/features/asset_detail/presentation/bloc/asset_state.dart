import 'package:equatable/equatable.dart';

import '../../domain/entities/asset.dart';

abstract class AssetState extends Equatable {
  const AssetState();

  @override
  List<Object> get props => [];
}

class AssetInitial extends AssetState {}

class AssetLoading extends AssetState {}

class AssetLoaded extends AssetState {
  final List<AssetEntity> assets;

  const AssetLoaded(this.assets);

  @override
  List<Object> get props => [assets];
}

class AssetError extends AssetState {
  final String error;

  const AssetError(this.error);

  @override
  List<Object> get props => [error];
}
