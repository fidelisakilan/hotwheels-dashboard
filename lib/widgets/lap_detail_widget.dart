import 'package:flutter/material.dart';
import 'package:f1_analyzer/model/lap_detail_model.dart';
import 'dart:math' as math;

class LapDetailWidget extends StatelessWidget {
  const LapDetailWidget({super.key, required this.tyre});
  final TyreModel tyre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TYRE ANALYSIS', style: Theme.of(context).textTheme.titleLarge),
          Text(
            'Track Temperature: ${tyre.trackTemperature}°C',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
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
                          tyreDetail: tyre.frontLeft,
                        ),
                        _TyreWidget(
                          position: 'Front Right',
                          tyreDetail: tyre.frontRight,
                        ),
                        _TyreWidget(
                          position: 'Rear Left',
                          tyreDetail: tyre.rearLeft,
                        ),
                        _TyreWidget(
                          position: 'Rear Right',
                          tyreDetail: tyre.rearRight,
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
