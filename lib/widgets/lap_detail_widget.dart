import 'package:flutter/material.dart';
import 'package:f1_analyzer/model/lap_detail_model.dart';
import 'dart:math' as math;

enum DetailTabs { visual, temp, pressure }

class LapDetailWidget extends StatefulWidget {
  const LapDetailWidget({super.key, required this.tyre});
  final TyreModel tyre;

  @override
  State<LapDetailWidget> createState() => _LapDetailWidgetState();
}

class _LapDetailWidgetState extends State<LapDetailWidget> {
  var currentTab = DetailTabs.visual;

  void changeTab(DetailTabs tab) {
    setState(() {
      currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          color: const Color(0xFFE10600),
          padding: const EdgeInsets.all(16),
          child: Text(
            'HotWheels',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SegmentedButtonWidget(
                  currentTab: currentTab,
                  changeTab: changeTab,
                ),
                Expanded(
                  child: currentTab == DetailTabs.visual
                      ? TyreVisualWidget(tyre: widget.tyre)
                      : currentTab == DetailTabs.temp
                      ? TyreTempWidget(tyre: widget.tyre)
                      : TyrePressureWidget(tyre: widget.tyre),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SegmentedButtonWidget extends StatelessWidget {
  const SegmentedButtonWidget({
    super.key,
    required this.changeTab,
    required this.currentTab,
  });
  final Function(DetailTabs) changeTab;
  final DetailTabs currentTab;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedButton<DetailTabs>(
        segments: const <ButtonSegment<DetailTabs>>[
          ButtonSegment<DetailTabs>(
            value: DetailTabs.visual,
            label: Text('Tyre Visuals'),
          ),
          ButtonSegment<DetailTabs>(
            value: DetailTabs.temp,
            label: Text('Tyre Temperature'),
          ),
          ButtonSegment<DetailTabs>(
            value: DetailTabs.pressure,
            label: Text('Tyre Pressure'),
          ),
        ],
        showSelectedIcon: false,
        selected: <DetailTabs>{currentTab},
        onSelectionChanged: (Set<DetailTabs> newSelection) =>
            changeTab(newSelection.first),
      ),
    );
  }
}

class TyreTempWidget extends StatelessWidget {
  const TyreTempWidget({super.key, required this.tyre});
  final TyreModel tyre;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('Track Temperature: ${tyre.trackTemperature}°C')],
    );
  }
}

class TyrePressureWidget extends StatelessWidget {
  const TyrePressureWidget({super.key, required this.tyre});
  final TyreModel tyre;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TyreVisualWidget extends StatelessWidget {
  const TyreVisualWidget({super.key, required this.tyre});
  final TyreModel tyre;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const crossAxisCount = 2;
        const spacing = 16.0;

        final availableWidth =
            (constraints.maxWidth - spacing * (crossAxisCount - 1));
        final availableHeight =
            (constraints.maxHeight - spacing * (crossAxisCount - 1));
        final cellSize = math.min(
          availableWidth / crossAxisCount,
          availableHeight / crossAxisCount,
        );
        return Center(
          child: SizedBox(
            width: cellSize * crossAxisCount + spacing * (crossAxisCount - 1),
            height: cellSize * crossAxisCount + spacing * (crossAxisCount - 1),
            child: GridView.count(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _TyreWidget(position: 'Front Left', tyreDetail: tyre.frontLeft),
                _TyreWidget(
                  position: 'Front Right',
                  tyreDetail: tyre.frontRight,
                ),
                _TyreWidget(position: 'Rear Left', tyreDetail: tyre.rearLeft),
                _TyreWidget(position: 'Rear Right', tyreDetail: tyre.rearRight),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TyreWidget extends StatelessWidget {
  const _TyreWidget({required this.position, required this.tyreDetail});
  final String position;
  final TyreDetailModel tyreDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(child: Text('Tyre')),
    );
  }
}
