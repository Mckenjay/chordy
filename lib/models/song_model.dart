import 'package:cloud_firestore/cloud_firestore.dart';

class SongModel {
  final String? id;
  final String title;
  final String artist;
  final String lyrics;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SongModel({
    this.id,
    required this.title,
    required this.artist,
    required this.lyrics,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'titleLower': title.toLowerCase(),
    'artist': artist,
    'artistLower': artist.toLowerCase(),
    'lyrics': lyrics,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  };

  Map<String, dynamic> toUpdateMap() => {
    'title': title,
    'titleLower': title.toLowerCase(),
    'artist': artist,
    'artistLower': artist.toLowerCase(),
    'lyrics': lyrics,
    'updatedAt': FieldValue.serverTimestamp(),
  };

  factory SongModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return SongModel(
      id: doc.id,
      title: doc.data()!["title"] ?? '',
      artist: doc.data()!["artist"] ?? '',
      lyrics: doc.data()!["lyrics"] ?? '',
    );
  }
}