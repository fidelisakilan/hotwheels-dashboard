import 'package:flutter/material.dart';
import 'package:f1_analyzer/model/lap_detail_model.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE10600), Color(0xFFB80500)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.thermostat, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'TRACK TEMP',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${tyre.trackTemperature}°C',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
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
                Text(
                  position,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: const Color(0xFFE10600),
                    letterSpacing: -0.2,
                  ),
                ),
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
              Text(
                'TYRE COLOR',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[400],
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                tyreDetail.color.displayName.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
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
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[400],
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                tyreDetail.wearPattern.displayName.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: color,
                  letterSpacing: 0.5,
                ),
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
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[400],
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                tyreDetail.sidewallDefomation ? 'DEFORMED' : 'NORMAL',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: tyreDetail.sidewallDefomation
                      ? Colors.red
                      : Colors.green,
                  letterSpacing: 0.5,
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
              Text(
                'GRAINING',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[400],
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                tyreDetail.isGraining ? 'GRAINING' : 'NORMAL',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: tyreDetail.isGraining ? Colors.orange : Colors.green,
                  letterSpacing: 0.5,
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
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[400],
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '${tyreDetail.tyreTemperature}°C',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: color,
                  letterSpacing: 0.5,
                ),
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
              Text(
                'PRESSURE',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[400],
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '${tyreDetail.tyrePressure} PSI',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: color,
                  letterSpacing: 0.5,
                ),
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
