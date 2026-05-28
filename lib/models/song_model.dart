import 'package:cloud_firestore/cloud_firestore.dart';

class SongModel {
  final String? id;
  final String title;
  final String artist;
  final String key;
  final String lyrics;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SongModel({
    this.id,
    required this.title,
    required this.artist,
    this.key = '',
    required this.lyrics,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'titleLower': title.toLowerCase(),
    'artist': artist,
    'artistLower': artist.toLowerCase(),
    'key': key,
    'lyrics': lyrics,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  };

  Map<String, dynamic> toUpdateMap() => {
    'title': title,
    'titleLower': title.toLowerCase(),
    'artist': artist,
    'artistLower': artist.toLowerCase(),
    'key': key,
    'lyrics': lyrics,
    'updatedAt': FieldValue.serverTimestamp(),
  };

  factory SongModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return SongModel(
      id: doc.id,
      title: data["title"] ?? '',
      artist: data["artist"] ?? '',
      key: data["key"] is String ? data["key"] as String : '',
      lyrics: data["lyrics"] ?? '',
    );
  }
}
