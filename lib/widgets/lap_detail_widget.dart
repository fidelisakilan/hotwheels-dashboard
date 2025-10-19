import 'package:flutter/material.dart';
import 'package:f1_analyzer/model/lap_detail_model.dart';
import 'package:f1_analyzer/utils/f1_fonts.dart';
import 'dart:math' as math;

class LapDetailWidget extends StatefulWidget {
  const LapDetailWidget({super.key, required this.tyre});
  final TyreModel tyre;

  @override
  State<LapDetailWidget> createState() => _LapDetailWidgetState();
}

class _LapDetailWidgetState extends State<LapDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Expanded(child: ComprehensiveTyreWidget(tyre: widget.tyre))],
      ),
    );
  }
}

class ComprehensiveTyreWidget extends StatelessWidget {
  const ComprehensiveTyreWidget({super.key, required this.tyre});
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
        return Stack(
          children: [
            Center(
              child: SizedBox(
                width:
                    cellSize * crossAxisCount + spacing * (crossAxisCount - 1),
                height:
                    cellSize * crossAxisCount + spacing * (crossAxisCount - 1),
                child: GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _ComprehensiveTyreWidget(
                      position: 'Front Left',
                      tyreDetail: tyre.frontLeft,
                    ),
                    _ComprehensiveTyreWidget(
                      position: 'Front Right',
                      tyreDetail: tyre.frontRight,
                    ),
                    _ComprehensiveTyreWidget(
                      position: 'Rear Left',
                      tyreDetail: tyre.rearLeft,
                    ),
                    _ComprehensiveTyreWidget(
                      position: 'Rear Right',
                      tyreDetail: tyre.rearRight,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE10600), Color(0xFFB80500)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Track Temperature
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.thermostat,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'TRACK TEMP',
                          style: F1Fonts.label(color: Colors.white),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${tyre.trackTemperature}°C',
                          style: F1Fonts.data(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Strategy
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.timeline,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'STRATEGY',
                          style: F1Fonts.label(color: Colors.white),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          tyre.strategy.toUpperCase(),
                          style: F1Fonts.data(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Current Track
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'TRACK',
                          style: F1Fonts.label(color: Colors.white),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          tyre.track.toUpperCase(),
                          style: F1Fonts.data(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ComprehensiveTyreWidget extends StatelessWidget {
  const _ComprehensiveTyreWidget({
    required this.position,
    required this.tyreDetail,
  });
  final String position;
  final TyreDetailModel tyreDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(position, style: F1Fonts.positionTitle()),
                const SizedBox(height: 12),
                _buildTyreColorSection(),
                const SizedBox(height: 8),
                _buildWearPatternSection(),
                const SizedBox(height: 8),
                _buildSidewallDeformationSection(),
                const SizedBox(height: 8),
                _buildGrainingSection(),
                const SizedBox(height: 8),
                _buildTemperatureIndicator(),
                const SizedBox(height: 8),
                _buildPressureIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTyreColorSection() {
    Color color;
    switch (tyreDetail.color) {
      case TyreColor.matteBlack:
        color = Colors.black87;
        break;
      case TyreColor.glossyBlack:
        color = Colors.black;
        break;
      case TyreColor.purpleTin:
        color = Colors.purple.shade300;
        break;
      case TyreColor.greyBlack:
        color = Colors.grey.shade700;
        break;
      case TyreColor.paleGrey:
        color = Colors.grey.shade400;
        break;
    }

    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade600, width: 2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TYRE COLOR', style: F1Fonts.label(color: Colors.grey[400])),
              Text(
                tyreDetail.color.displayName.toUpperCase(),
                style: F1Fonts.data(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWearPatternSection() {
    IconData icon;
    Color color;

    switch (tyreDetail.wearPattern) {
      case WearPattern.even:
        icon = Icons.circle;
        color = Colors.green;
        break;
      case WearPattern.inner:
        icon = Icons.arrow_back;
        color = Colors.orange;
        break;
      case WearPattern.outer:
        icon = Icons.arrow_forward;
        color = Colors.orange;
        break;
      case WearPattern.center:
        icon = Icons.remove;
        color = Colors.red;
        break;
      case WearPattern.uneven:
        icon = Icons.warning;
        color = Colors.red;
        break;
    }

    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WEAR PATTERN',
                style: F1Fonts.label(color: Colors.grey[400]),
              ),
              Text(
                tyreDetail.wearPattern.displayName.toUpperCase(),
                style: F1Fonts.data(fontSize: 15, color: color),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSidewallDeformationSection() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: tyreDetail.sidewallDefomation
                ? Colors.red.withOpacity(0.1)
                : Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: tyreDetail.sidewallDefomation ? Colors.red : Colors.green,
              width: 2,
            ),
          ),
          child: Icon(
            tyreDetail.sidewallDefomation ? Icons.warning : Icons.check_circle,
            color: tyreDetail.sidewallDefomation ? Colors.red : Colors.green,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SIDEWALL DEFORMATION',
                style: F1Fonts.label(color: Colors.grey[400]),
              ),
              Text(
                tyreDetail.sidewallDefomation ? 'DEFORMED' : 'NORMAL',
                style: F1Fonts.data(
                  fontSize: 15,
                  color: tyreDetail.sidewallDefomation
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGrainingSection() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: tyreDetail.isGraining
                ? Colors.orange.withOpacity(0.1)
                : Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: tyreDetail.isGraining ? Colors.orange : Colors.green,
              width: 2,
            ),
          ),
          child: Icon(
            tyreDetail.isGraining ? Icons.grain : Icons.check_circle,
            color: tyreDetail.isGraining ? Colors.orange : Colors.green,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('GRAINING', style: F1Fonts.label(color: Colors.grey[400])),
              Text(
                tyreDetail.isGraining ? 'GRAINING' : 'NORMAL',
                style: F1Fonts.data(
                  fontSize: 15,
                  color: tyreDetail.isGraining ? Colors.orange : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTemperatureIndicator() {
    Color color = _getTemperatureColor(tyreDetail.tyreTemperature);

    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(Icons.thermostat, color: color, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TEMPERATURE',
                style: F1Fonts.label(color: Colors.grey[400]),
              ),
              Text(
                '${tyreDetail.tyreTemperature}°C',
                style: F1Fonts.data(fontSize: 15, color: color),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPressureIndicator() {
    Color color = _getPressureColor(tyreDetail.tyrePressure);

    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(Icons.speed, color: color, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PRESSURE', style: F1Fonts.label(color: Colors.grey[400])),
              Text(
                '${tyreDetail.tyrePressure} PSI',
                style: F1Fonts.data(fontSize: 15, color: color),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getTemperatureColor(int temperature) {
    if (temperature < 90) return Colors.blue; // Too cold - reduced grip
    if (temperature < 120) return Colors.green; // Optimal range (90-120°C)
    if (temperature < 130) return Colors.orange; // Getting hot - monitor
    return Colors.red; // Overheated - blistering/graining
  }

  Color _getPressureColor(int pressure) {
    if (pressure < 20) return Colors.red; // Too low - dangerous
    if (pressure < 22) return Colors.orange; // Low - monitor
    if (pressure < 25) return Colors.green; // Optimal range (22-25 PSI)
    if (pressure < 28) return Colors.orange; // High - monitor
    return Colors.red; // Too high - reduced grip
  }
}
