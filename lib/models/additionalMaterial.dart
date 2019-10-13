class AdditionalMaterial {
  String name;
  dynamic modNum;
  String file;
  String description;

  AdditionalMaterial({this.name, this.modNum, this.file, this.description});

  factory AdditionalMaterial.fromJson(Map<String, dynamic> json) =>
      AdditionalMaterial(
        name: json["name"] == null ? null : json["name"],
        modNum: json['modNum'] == null ? null : json['modNum'],
        file: json['file'] == null ? null : json['file'],
        description: json['description'] == null ? null : json['description'],
      );

  Map<String, dynamic> toJson() => {
        'name': this.name == null ? null : this.name,
        'modNum': this.modNum == null ? null : this.modNum,
        'file': this.file == null ? null : this.file,
        'description': this.description == null ? null : this.description,
      };
}
