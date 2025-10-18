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
  var currentTab = DetailTabs.temp;

  void changeTab(DetailTabs tab) {
    print(tab);
    setState(() {
      currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SegmentedButtonWidget(currentTab: currentTab, changeTab: changeTab),
          Text('TYRE ANALYSIS', style: Theme.of(context).textTheme.titleLarge),
          Text(
            'Track Temperature: ${widget.tyre.trackTemperature}°C',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Expanded(
            child: LayoutBuilder(
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
                    width:
                        cellSize * crossAxisCount +
                        spacing * (crossAxisCount - 1),
                    height:
                        cellSize * crossAxisCount +
                        spacing * (crossAxisCount - 1),
                    child: GridView.count(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _TyreWidget(
                          position: 'Front Left',
                          tyreDetail: widget.tyre.frontLeft,
                        ),
                        _TyreWidget(
                          position: 'Front Right',
                          tyreDetail: widget.tyre.frontRight,
                        ),
                        _TyreWidget(
                          position: 'Rear Left',
                          tyreDetail: widget.tyre.rearLeft,
                        ),
                        _TyreWidget(
                          position: 'Rear Right',
                          tyreDetail: widget.tyre.rearRight,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
            value: DetailTabs.temp,
            label: Text('Tyre Temperature'),
          ),
          ButtonSegment<DetailTabs>(
            value: DetailTabs.pressure,
            label: Text('Tyre Pressure'),
          ),
          ButtonSegment<DetailTabs>(
            value: DetailTabs.visual,
            label: Text('Tyre Visuals'),
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
