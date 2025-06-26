import 'package:rex_app/src/modules/revamp/purchase/model/baseapp_transaction_entity.dart';
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
    String path = join(await getDatabasesPath(), 'pos_transact.db');

    return await openDatabase(
      path,
      version: 2,
      onUpgrade: (db, oldV, newV) async {
        if (oldV < 2) {
          await db.execute('''
            CREATE TABLE cardPurchaseFails (
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
              currency TEXT,
              failReason TEXT
            )
          ''');
        }
      },
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

        await db.execute('''
          CREATE TABLE cardPurchaseFails (
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

  Future<int> insertSuccessTransaction(
    BaseappTransactionEntity transaction,
  ) async {
    final db = await database;
    return await db.insert(
      'cardPurchase',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertFailedTransaction(
    BaseappTransactionEntity tx,
  ) async {
    final db = await database;
    return db.insert(
      'cardPurchaseFails',
      tx.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<BaseappTransactionEntity>> getSuccessTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cardPurchase');

    return List.generate(maps.length, (i) {
      return BaseappTransactionEntity.fromMap(maps[i]);
    });
  }

  Future<List<BaseappTransactionEntity>> getFailedTransactions() async {
    final db = await database;
    final maps = await db.query('cardPurchaseFails');
    return maps.map(BaseappTransactionEntity.fromMap).toList();
  }
}
