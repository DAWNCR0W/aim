import 'package:flutter/material.dart';

import '../../domain/entities/asset.dart';

class AssetTileWidget extends StatelessWidget {
  final AssetEntity asset;

  const AssetTileWidget({Key? key, required this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(asset.securitySymbol),
      title: Text(asset.securityName),
      subtitle: Text(asset.securityDescription ?? ""),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [Text("${asset.ratio}%"), Text("수량: ${asset.quantity}")],
      ),
    );
  }
}
