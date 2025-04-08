import 'package:aim/core/util/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../asset_detail/domain/usecases/get_assets.dart';
import '../../../asset_detail/data/repository/asset_repository_impl.dart';
import '../../../asset_detail/presentation/bloc/asset_bloc.dart';
import '../../../asset_detail/presentation/bloc/asset_event.dart';
import '../../../asset_detail/presentation/bloc/asset_state.dart';
import '../../../asset_detail/presentation/pages/asset_detail_page.dart';
import '../../../asset_detail/presentation/widgets/asset_summary_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              AssetBloc(getAssets: GetAssets(AssetRepositoryImpl()))
                ..add(FetchAssets()),
      child: BlocBuilder<AssetBloc, AssetState>(
        builder: (context, state) {
          if (state is AssetLoading) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: const Text(
                  "평생안전 은퇴자금",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              backgroundColor: const Color(0xFF212832),
              body: const Center(child: CircularProgressIndicator()),
            );
          } else if (state is AssetError) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: const Text(
                  "평생안전 은퇴자금",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              backgroundColor: const Color(0xFF212832),
              body: Center(child: Text("에러: ${state.error}")),
            );
          } else if (state is AssetLoaded) {
            final assets = state.assets;
            final stockRatio = assets
                .where((a) => a.type == 'stock')
                .fold(0.0, (sum, a) => sum + a.ratio);
            final bondRatio = assets
                .where((a) => a.type == 'bond')
                .fold(0.0, (sum, a) => sum + a.ratio);
            final etcRatio = assets
                .where((a) => a.type == 'etc')
                .fold(0.0, (sum, a) => sum + a.ratio);

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: const Text(
                  "평생안전 은퇴자금",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              backgroundColor: const Color(0xFF212832),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const AssetDetailPage(),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: 160,
                              height: 160,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 20,
                                  sections: [
                                    PieChartSectionData(
                                      value: stockRatio,
                                      color: Colors.cyanAccent,
                                      radius: 40,
                                      title: '',
                                    ),
                                    PieChartSectionData(
                                      value: bondRatio,
                                      color: Colors.cyan,
                                      radius: 40,
                                      title: '',
                                    ),
                                    PieChartSectionData(
                                      value: etcRatio,
                                      color: Colors.amberAccent,
                                      radius: 40,
                                      title: '',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '장기투자에 적합한 적극적인 자산배분'.insertZwj(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                ),
                                const SizedBox(height: 10),
                                RichText(
                                  softWrap: true,
                                  text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "'평생안정 은퇴자금'",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: "에\n최적화된 자산배분입니다"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      AssetSummaryWidget(
                        stockRatio: stockRatio,
                        bondRatio: bondRatio,
                        etcRatio: etcRatio,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
