import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:polar_data_collector/dao.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'model.g.dart';

// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Todo".
class HR extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  DateTimeColumn get time => dateTime()();
  IntColumn get value => integer()();
}

class ECG extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get time => integer()();
  IntColumn get value => integer()();
}

// This will make drift generate a class called "Category" to represent a row in
// this table. By default, "Categorie" would have been used because it only
//strips away the trailing "s" in the table name.
class PPG extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get time => integer()();
  IntColumn get first => integer()();
  IntColumn get second => integer()();
  IntColumn get third => integer()();
  IntColumn get ambient => integer()();
}

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [HR, PPG, ECG], daos: [HRDao, PPGDao, ECGDao])
class MyDatabase extends _$MyDatabase {
  MyDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
