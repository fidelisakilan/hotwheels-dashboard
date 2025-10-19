import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f1_analyzer/model/dummary_lap_details.dart';
import 'package:f1_analyzer/model/lap_detail_model.dart';
import 'package:rxdart/rxdart.dart';

class LapDetailBloc {
  final List<TyreModel> lapDetails = [];
  final BehaviorSubject<List<TyreModel>> lapDetailsSubject =
      BehaviorSubject<List<TyreModel>>();
  Stream<List<TyreModel>> get lapDetailsStream => lapDetailsSubject.stream;

  void storeDummyLapDetails() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore.collection('laps').get();
      final batch = firestore.batch();
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }
      for (var lapDetail in dummyLapDetails) {
        final docRef = firestore.collection('laps').doc();
        batch.set(docRef, {
          'compound': lapDetail.compound.toString().split('.').last,
          'lapNumber': lapDetail.lapNumber,
          'strategy': lapDetail.strategy,
          'track': lapDetail.track,
          'trackKnowledge': lapDetail.trackKnowledge,
          'trackTemperature': lapDetail.trackTemperature,
          'frontLeft': {
            'color': lapDetail.frontLeft.color.toString().split('.').last,
            'wearPattern': lapDetail.frontLeft.wearPattern
                .toString()
                .split('.')
                .last,
            'sidewallDeformation': lapDetail.frontLeft.sidewallDefomation,
            'isGraining': lapDetail.frontLeft.isGraining,
            'tyrePressure': lapDetail.frontLeft.tyrePressure,
            'tyreTemperature': lapDetail.frontLeft.tyreTemperature,
          },
          'frontRight': {
            'color': lapDetail.frontRight.color.toString().split('.').last,
            'wearPattern': lapDetail.frontRight.wearPattern
                .toString()
                .split('.')
                .last,
            'sidewallDeformation': lapDetail.frontRight.sidewallDefomation,
            'isGraining': lapDetail.frontRight.isGraining,
            'tyrePressure': lapDetail.frontRight.tyrePressure,
            'tyreTemperature': lapDetail.frontRight.tyreTemperature,
          },
          'rearLeft': {
            'color': lapDetail.rearLeft.color.toString().split('.').last,
            'wearPattern': lapDetail.rearLeft.wearPattern
                .toString()
                .split('.')
                .last,
            'sidewallDeformation': lapDetail.rearLeft.sidewallDefomation,
            'isGraining': lapDetail.rearLeft.isGraining,
            'tyrePressure': lapDetail.rearLeft.tyrePressure,
            'tyreTemperature': lapDetail.rearLeft.tyreTemperature,
          },
          'rearRight': {
            'color': lapDetail.rearRight.color.toString().split('.').last,
            'wearPattern': lapDetail.rearRight.wearPattern
                .toString()
                .split('.')
                .last,
            'sidewallDeformation': lapDetail.rearRight.sidewallDefomation,
            'isGraining': lapDetail.rearRight.isGraining,
            'tyrePressure': lapDetail.rearRight.tyrePressure,
            'tyreTemperature': lapDetail.rearRight.tyreTemperature,
          },
        });
      }

      await batch.commit();
    } catch (e) {
      print('Error storing lap details: $e');
    }
  }

  void fetchLapDetails() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore.collection('laps').get();

      final List<TyreModel> lapDetails = [];

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final tyreModel = _convertFirestoreToTyreModel(data);
        if (tyreModel != null) {
          lapDetails.add(tyreModel);
        }
      }

      // Sort by lap number
      lapDetails.sort((a, b) => b.lapNumber.compareTo(a.lapNumber));

      lapDetailsSubject.add(lapDetails);
    } catch (e) {
      print('Error fetching lap details from Firestore: $e');
      // lapDetailsSubject.add(List<TyreModel>.from(dummyLapDetails));
    }
  }

  TyreModel? _convertFirestoreToTyreModel(Map<String, dynamic> data) {
    try {
      // Convert compound string to enum
      final compoundString = data['compound'] as String?;
      TyreCompound compound;
      switch (compoundString) {
        case 'soft':
          compound = TyreCompound.soft;
          break;
        case 'medium':
          compound = TyreCompound.medium;
          break;
        case 'hard':
          compound = TyreCompound.hard;
          break;
        case 'intermediate':
          compound = TyreCompound.intermediate;
          break;
        case 'wet':
          compound = TyreCompound.wet;
          break;
        default:
          throw Exception('Invalid compound: $compoundString');
      }

      // Convert tyre detail data
      TyreDetailModel convertTyreDetail(Map<String, dynamic>? tyreData) {
        if (tyreData == null) {
          throw Exception('Tyre data is null');
        }

        // Convert color string to enum
        final colorString = tyreData['color'] as String?;
        TyreColor color;
        switch (colorString) {
          case 'matteBlack':
            color = TyreColor.matteBlack;
            break;
          case 'glossyBlack':
            color = TyreColor.glossyBlack;
            break;
          case 'purpleTin':
            color = TyreColor.purpleTin;
            break;
          case 'greyBlack':
            color = TyreColor.greyBlack;
            break;
          case 'paleGrey':
            color = TyreColor.paleGrey;
            break;
          default:
            throw Exception('Invalid tyre color: $colorString');
        }

        // Convert wear pattern string to enum
        final wearPatternString = tyreData['wearPattern'] as String?;
        WearPattern wearPattern;
        switch (wearPatternString) {
          case 'uneven':
            wearPattern = WearPattern.uneven;
            break;
          case 'inner':
            wearPattern = WearPattern.inner;
            break;
          case 'outer':
            wearPattern = WearPattern.outer;
            break;
          case 'center':
            wearPattern = WearPattern.center;
            break;
          case 'even':
            wearPattern = WearPattern.even;
            break;
          default:
            throw Exception('Invalid wear pattern: $wearPatternString');
        }

        return TyreDetailModel(
          color: color,
          wearPattern: wearPattern,
          sidewallDefomation: tyreData['sidewallDeformation'] as bool? ?? false,
          isGraining: tyreData['isGraining'] as bool? ?? false,
          tyrePressure: tyreData['tyrePressure'] as int? ?? 0,
          tyreTemperature: tyreData['tyreTemperature'] as int? ?? 0,
        );
      }

      return TyreModel(
        strategy: data['strategy'] as String? ?? '',
        track: data['track'] as String? ?? '',
        trackKnowledge: data['trackKnowledge'] as String? ?? '',
        lapNumber: data['lapNumber'] as int? ?? 0,
        compound: compound,
        trackTemperature: data['trackTemperature'] as int? ?? 0,
        frontLeft: convertTyreDetail(
          data['frontLeft'] as Map<String, dynamic>?,
        ),
        frontRight: convertTyreDetail(
          data['frontRight'] as Map<String, dynamic>?,
        ),
        rearLeft: convertTyreDetail(data['rearLeft'] as Map<String, dynamic>?),
        rearRight: convertTyreDetail(
          data['rearRight'] as Map<String, dynamic>?,
        ),
      );
    } catch (e) {
      print('Error converting Firestore data to TyreModel: $e');
      return null;
    }
  }

  void dispose() {
    lapDetailsSubject.close();
  }
}
