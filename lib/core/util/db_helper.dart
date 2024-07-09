import 'dart:developer';
import 'dart:io';

import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:path/path.dart' show dirname, join;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper();
  late final Database database;
  // final int dbVersion = 1;
  Future<void> init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, AppConstants.locationDb);
    var exists = await databaseExists(path);
    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
        log(_.toString());
      }
    }
    database = await openDatabase(path, readOnly: false, onOpen: (db) {
      createTable();
    });
  }
  // final int id;
  //   final String latitude;
  //   final String longitude;
  //   final String address;
  //   final int connectorsCount;
  //   final List<String> connectorsStatus;
  //   final String vendorName;
  //   final String locationName;
  //   final double distance;
  //   final bool isFavorite;
  //   final List<num> maxElectricPowers;
  //   final String logo;
  //   final int chargersCount;

  void createTable() {
    database.execute('''CREATE TABLE IF NOT EXISTS ${AppConstants.locationDb}(
            location_id INTEGER PRIMARY KEY, 
            latitude TEXT NOT NULL, 
            longitude TEXT NOT NULL, 
            address TEXT NOT NULL, 
            connectors_count INTEGER NOT NULL,
            vendor_name TEXT NOT NULL,
            location_name TEXT NOT NULL,
            vendor_name TEXT NOT NULL,
            connectors_status TEXT NOT NULL
        )''');
  }
  //
  // Future<void> saveLocationsList(List<ChargeLocationEntity> locations) async {
  //   try {
  //     if (database.isOpen) {
  //       for (var element in qoriEntityList) {
  //         var values = {
  //           'qoriId': element.id,
  //           'name': element.fullName,
  //           'imageUrl': element.image,
  //           'isFavorite': isFavorite ?? 0,
  //           'isLastViewed': isLastViewed ?? 0
  //         };
  //         await database.insert(tbQori, values, conflictAlgorithm: ConflictAlgorithm.replace);
  //       }
  //     }
  //   } catch (e) {
  //     log("saveQoriList", error: e.toString());
  //   }
  // }

  // Future<void> insert(String table, Map<String, dynamic> row) async {
  //   try {
  //     await database.insert(table, row, conflictAlgorithm: ConflictAlgorithm.replace);
  //   } catch (e) {
  //     await init();
  //     await database.insert(table, row, conflictAlgorithm: ConflictAlgorithm.replace);
  //   }
  // }
  //
  // Future<List<Map<String, dynamic>>> getLastAudioSource(String table, int id) async {
  //   try {
  //     return await database.rawQuery("SELECT * FROM $table where id = $id");
  //   } catch (e) {
  //     await init();
  //     return await database.rawQuery("SELECT * FROM $table where id = $id");
  //   }
  // }
  //
  // Future<List<ReciterEntity>> getQariList({bool isFavorite = false, bool isLastViewed = false}) async {
  //   try {
  //     var filterFavorite = isFavorite ? " WHERE isFavorite='1'" : '';
  //     var filterLastViewed = isFavorite ? " WHERE isLastViewed='1'" : '';
  //     var response = await database.rawQuery("SELECT * FROM $tbQori $filterFavorite $filterLastViewed");
  //     var wordBankList = List<ReciterEntity>.from(
  //       response.map(
  //         (e) => ReciterEntity(
  //           id: e['qoriId'] as int,
  //           fullName: e['name'] as String,
  //           image: e['imageUrl'] as String,
  //         ),
  //       ),
  //     );
  //     return wordBankList;
  //   } catch (e) {
  //     log("saveToWordBank", error: e.toString());
  //   }
  //   return [];
  // }
  //
  // Future<void> updateQariDetail({required int qoriId, required Map<String, dynamic> values}) async {
  //   try {
  //     if (database.isOpen) {
  //       await database.update(tbQori, values, where: 'qoriId = ?', whereArgs: [qoriId], conflictAlgorithm: ConflictAlgorithm.replace);
  //     }
  //   } catch (e) {
  //     log("updateQariDetail", error: e.toString());
  //   }
  // }
  //
  // Future<void> saveSurahList(List<RecitationEntity> recitationList, {required int qoriId}) async {
  //   try {
  //     if (database.isOpen) {
  //       for (var element in recitationList) {
  //         var values = {
  //           'recitationId': element.id,
  //           'qoriId': qoriId,
  //           'surahId': element.surah.id,
  //           'surahNumber': element.surah.number,
  //           'surahName': element.surah.name,
  //           'ayatCount': element.surah.ayahCount,
  //           'recitationPlace': element.surah.revelationPlace,
  //           'audioUrl': element.audio,
  //           'inPlaylist': element.inPlaylist ? 1 : 0
  //         };
  //         await database.insert(tbSurah, values, conflictAlgorithm: ConflictAlgorithm.replace);
  //       }
  //     }
  //   } catch (e) {
  //     log("saveSurahList", error: e.toString());
  //   }
  // }
  //
  // Future<void> updateSurahDetail({required int recitationId, required Map<String, dynamic> values}) async {
  //   try {
  //     if (database.isOpen) {
  //       await database.update(tbSurah, values, where: 'recitationId = ?', whereArgs: [recitationId], conflictAlgorithm: ConflictAlgorithm.replace);
  //     }
  //   } catch (e) {
  //     log("updateSurahDetail", error: e.toString());
  //   }
  // }
  //
  // Future<void> saveAyatList(RecitationSingleEntity surahEntity) async {
  //   try {
  //     if (database.isOpen) {
  //       for (var i = 0; i < surahEntity.ayatArabic.length; i++) {
  //         var values = {
  //           'recitationId': surahEntity.id,
  //           'ayatId': surahEntity.ayatArabic[i].id,
  //           'surahNumber': surahEntity.surahNumber,
  //           'ayatNumber': surahEntity.ayatArabic[i].number,
  //           'arabic': surahEntity.ayatArabic[i].arabicText,
  //           'translation': surahEntity.ayatTranslation[i].text,
  //           'duration': surahEntity.ayatRecitation[i].duration,
  //         };
  //         await database.insert(tbAyat, values, conflictAlgorithm: ConflictAlgorithm.replace);
  //       }
  //     }
  //   } catch (e) {
  //     log("saveAyatList", error: e.toString());
  //   }
  // }
}
