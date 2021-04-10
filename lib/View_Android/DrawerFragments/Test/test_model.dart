class AddBlockDataModel {
  String parameter;
  bool isselected;
  int position;

  AddBlockDataModel({this.parameter, this.isselected, this.position});

  AddBlockDataModel.fromJson(Map<String, dynamic> json) {
    parameter = json['parameter'];
    isselected = json['isselected'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parameter'] = this.parameter;
    data['isselected'] = this.isselected;
    data['position'] = this.position;
    return data;
  }
}

