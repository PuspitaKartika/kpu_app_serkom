import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  final String? id;
  final String alamat;
  final String jk;
  final String name;
  final String gamber;
  final num nik;
  final String no;
  final String tanggal;

  UsersModel({
    this.id,
    required this.alamat,
    required this.jk,
    required this.name,
    required this.gamber,
    required this.nik,
    required this.no,
    required this.tanggal
  });

  factory UsersModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UsersModel(
      id: doc.id,
      alamat: data['alamat'] ?? '',
      jk: data['jk']??"",
      name: data['name'] ?? '',
      gamber: data['gambar']??"",
      nik: data['nik'] ?? '',
      no: data['no']??'',
      tanggal: data['tanggal']??"",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alamat': alamat,
      'jk': jk,
      'name': name,
      'gambar': gamber,
      'nik': nik,
      'no': no,
      'tanggal': tanggal
    };
  }
}