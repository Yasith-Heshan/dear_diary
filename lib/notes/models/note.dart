import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable{
  final String title;
  final String subtitle;
  final String description;

  const Note(
      {required this.title, required this.subtitle, required this.description});

  Note.fromDoc(QueryDocumentSnapshot documentSnapshot):
    title=documentSnapshot.get('title'),
    subtitle=documentSnapshot.get('subtitle'),
    description=documentSnapshot.get('description')
  ;

  Map<String, String> toMap(){
    return {
      'title':title,
      'subtitle':subtitle,
      'description':description
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [title, subtitle, description];
}
