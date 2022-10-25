class AddressModel {
  String? shopName;
  String? completeAddress;
  String? nearbyLandMark;
  String? phoneNumber;

  AddressModel(
      {this.shopName,
      this.completeAddress,
      this.nearbyLandMark,
      this.phoneNumber});

  AddressModel.fromJson(Map<String, dynamic> json) {
    shopName = json['shopName'];
    completeAddress = json['completeAddress'];
    nearbyLandMark = json['nearbyLandMark'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shopName'] = shopName;
    data['completeAddress'] = completeAddress;
    data['nearbyLandMark'] = nearbyLandMark;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
