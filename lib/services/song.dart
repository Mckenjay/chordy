import 'package:chordy/models/song_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SongService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<SongModel>> getSongsStream() {
    return _db
      .collection('Songs')
      .snapshots()
      .map((snapshot) => snapshot.docs
            .map((doc) => SongModel.fromDocumentSnapshot(doc))
            .toList());
  }

  Future<List<SongModel>> getSongs() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection('Songs').get();
    return snapshot.docs
      .map((doc) => SongModel.fromDocumentSnapshot(doc))
      .toList();
  }

  Future<void> addSong(SongModel songData) async {
    await _db.collection('Songs').add(songData.toMap());
  }

  Future<void> updateSong(SongModel songData) async {
    await _db.collection('Songs').doc(songData.id).update(songData.toUpdateMap());
  }

  Future<void> deleteSong(String songID) async {
    await _db.collection('Songs').doc(songID).delete();
  }

  Future<List<SongModel>> searchSong(String title) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
      .collection('Songs')
      .where('titleLower', isGreaterThanOrEqualTo: title.toLowerCase())
      .where('titleLower', isLessThan: '${title.toLowerCase()}z')
      .get();

    return snapshot.docs
      .map((doc) => SongModel.fromDocumentSnapshot(doc))
      .toList();
  }

  Future<List<SongModel>> searchArtist(String artist) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
      .collection('Songs')
      .where('artistLower', isGreaterThanOrEqualTo: artist.toLowerCase())
      .where('artistLower', isLessThan: '${artist.toLowerCase()}z')
      .get();

    return snapshot.docs
      .map((doc) => SongModel.fromDocumentSnapshot(doc))
      .toList();
  }
}