import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/form.dart';

class CvDatabase {
  static final CvDatabase instance = CvDatabase._init();

  static Database? _database;

  CvDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cv.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableFormFields (
      ${FormFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${FormFields.fullName} TEXT NOT  NULL,
      ${FormFields.slackUserName} TEXT NOT NULL,
      ${FormFields.githubUserName} TEXT NOT NULL,
      ${FormFields.isImportant} BOOLEAN NOT NULL,
      ${FormFields.bio} TEXT NOT NULL,
      ${FormFields.createdAt} TEXT NOT NULL
    )
    ''');
  }

  Future<Form> create(Form form) async {
    final db = await instance.database;

    final id = await db.insert(tableFormFields, form.toJson());
    return form.copy(id: id);
  }

  Future<Form> readForm(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFormFields,
      columns: FormFields.values,
      where: '${FormFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Form.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

    // read multiple cv profile/

  Future<List<Form>> readAllForms() async {
    final db = await instance.database;

    const String orderBy = '${FormFields.createdAt} ASC';
    final result = await db.query(tableFormFields, orderBy: orderBy);

    return result.map((json) => Form.fromJson(json)).toList();
  }

  Future<int> update(Form form) async {
    final db = await instance.database;

    return db.update(
      tableFormFields,
      form.toJson(),
      where: '${FormFields.id} = ?',
      whereArgs: [form.id],
    );
  }
  //delete /
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableFormFields,
      where: '${FormFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  } 
}
