import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aim/features/asset_detail/domain/usecases/get_assets.dart';
import 'package:aim/features/asset_detail/data/repository/asset_repository_impl.dart';
import '../bloc/asset_bloc.dart';
import '../bloc/asset_event.dart';
import '../bloc/asset_state.dart';

class AssetDetailPage extends StatelessWidget {
  const AssetDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              AssetBloc(getAssets: GetAssets(AssetRepositoryImpl()))
                ..add(FetchAssets()),
      child: Scaffold(
        backgroundColor: const Color(0xFF5DCCC8),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: const Color(0xFF5DCCC8),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFF5DCCC8),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  minimumSize: const Size(60, 24),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('ETF란?', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
        body: BlocBuilder<AssetBloc, AssetState>(
          builder: (context, state) {
            if (state is AssetLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AssetError) {
              return Center(child: Text("에러: ${state.error}"));
            } else if (state is AssetLoaded) {
              final assets = state.assets;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '선진시장 주식',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '각 ETF 종목별 기본 정보, 보유 수량,\n최근 1일 수익률 정보입니다',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Container(
                        transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                        child: ListView.builder(
                          itemCount: assets.length,
                          itemBuilder: (context, index) {
                            final asset = assets[index];
                            return _buildAssetCard(
                              logo: asset.securitySymbol,
                              title: asset.securityName,
                              description: asset.securityDescription ?? "",
                              returnRate: asset.ratio,
                              rank: "${asset.quantity}주",
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildAssetCard({
    required String logo,
    required String title,
    required String description,
    required double returnRate,
    required String rank,
  }) {
    final isNegative = returnRate < 0;
    final color = isNegative ? Colors.blue : Colors.red;
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: const BorderSide(color: Colors.grey, width: 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  logo,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Text(
                  '전일대비 수익률',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isNegative ? "-" : ""}${returnRate.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 16,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rank,
                      style: TextStyle(
                        fontSize: 24,
                        color: const Color(0xFF5DCCC8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
