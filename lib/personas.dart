
class Personas {
  String? id;
  String? nombres;
  String? descripcion;
  String? foto;

  Personas({this.id, required this.nombres, required this.descripcion, required this.foto});

  Map<String, dynamic> toMap(){
    return {'id': id, 'nombres': nombres, 'descripcion': descripcion, 'foto': foto};
  }
}