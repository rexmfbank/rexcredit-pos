import 'package:rex_app/src/modules/individual/purchase/model/baseapp_transaction_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDbService {
  static final LocalDbService _instance = LocalDbService._internal();
  LocalDbService._internal();

  Database? _database;

  factory LocalDbService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'transactions.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cardPurchase (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            aid TEXT,
            amount TEXT,
            cashBackAmount TEXT,
            appLabel TEXT,
            authcode TEXT,
            cardExpireDate TEXT,
            cardHolderName TEXT,
            dateAndTime TEXT,
            maskedPan TEXT,
            message TEXT,
            nuban TEXT,
            pinType TEXT,
            rrn TEXT,
            stan TEXT,
            statuscode TEXT,
            terminalId TEXT,
            transactionType TEXT,
            merchantName TEXT,
            merchantId TEXT,
            merchantAddress TEXT,
            merchantCategoryCode TEXT,
            bankName TEXT,
            bankLogo TEXT,
            ptsp TEXT,
            ptspContact TEXT,
            footerMessage TEXT,
            deviceSerialNumber TEXT,
            baseAppVersion TEXT,
            currency TEXT
          )
        ''');
      },
    );
  }

  // Insert transaction
  Future<int> insertTransaction(BaseappTransactionEntity transaction) async {
    final db = await database;
    return await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all transactions
  Future<List<BaseappTransactionEntity>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');

    return List.generate(maps.length, (i) {
      return BaseappTransactionEntity.fromMap(maps[i]);
    });
  }
}
