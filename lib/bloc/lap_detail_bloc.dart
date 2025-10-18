import 'package:f1_analyzer/widgets/dummary_lap_details.dart';
import 'package:f1_analyzer/model/lap_detail_model.dart';
import 'package:rxdart/rxdart.dart';

class LapDetailBloc {
  final List<TyreModel> lapDetails = [];
  final BehaviorSubject<List<TyreModel>> lapDetailsSubject =
      BehaviorSubject<List<TyreModel>>();
  Stream<List<TyreModel>> get lapDetailsStream => lapDetailsSubject.stream;

  void fetchLapDetails() async {
    lapDetailsSubject.add(List<TyreModel>.from(dummyLapDetails));
  }

  void dispose() {
    lapDetailsSubject.close();
  }
}
