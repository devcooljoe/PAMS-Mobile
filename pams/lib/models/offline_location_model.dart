class AddOfflineLocation {
  final int? id;
  final String? name;
  final String? description;
  final String? clientId;
 

  AddOfflineLocation(
      {this.id, this.name, this.description, this.clientId,});
  factory AddOfflineLocation.fromMap(Map<String, dynamic> json) => AddOfflineLocation(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      clientId: json['clientId'],
    );

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'description':description,
      'clientId':clientId,
    
    };
  }
}
