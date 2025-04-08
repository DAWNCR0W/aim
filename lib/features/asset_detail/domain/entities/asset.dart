class AssetEntity {
  final String securitySymbol;
  final String type;
  final String? securityDescription;
  final int quantity;
  final double ratio;
  final String securityName;

  AssetEntity({
    required this.securitySymbol,
    required this.type,
    this.securityDescription,
    required this.quantity,
    required this.ratio,
    required this.securityName,
  });
}
