import 'package:drift/drift.dart';
import 'package:polar_data_collector/model.dart';

part 'dao.g.dart';

// the _TodosDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [HR])
class HRDao extends DatabaseAccessor<MyDatabase> with _$HRDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  HRDao(MyDatabase db) : super(db);

  Future<void> insert(HRData data) async {
    await into(hr).insert(data);
  }
}

@DriftAccessor(tables: [PPG])
class PPGDao extends DatabaseAccessor<MyDatabase> with _$PPGDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  PPGDao(MyDatabase db) : super(db);

  Future<void> insert(PPGData data) async {
    await into(ppg).insert(data);
  }

  Future<List<PPGData>> getLast100() {
    return (select(ppg)
          ..orderBy([(u) => OrderingTerm.desc(u.id)])
          ..limit(100))
        .get();
  }
}
@DriftAccessor(tables: [ECG])
class ECGDao extends DatabaseAccessor<MyDatabase> with _$ECGDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ECGDao(MyDatabase db) : super(db);

  Future<void> insert(ECGData data) async {
    await into(ecg).insert(data);
  }

  Future<List<ECGData>> getLast300() {
    return (select(ecg)
          ..orderBy([(u) => OrderingTerm.desc(u.id)])
          ..limit(300))
        .get();
  }
}
