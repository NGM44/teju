class HomeScreenDataModel {
  ShopDetail? shopDetail;
  FilterBrand? filterBrand;
  List<Product>? product;

  HomeScreenDataModel({this.shopDetail, this.filterBrand, this.product});

  HomeScreenDataModel.fromJson(Map<String, dynamic> json) {
    shopDetail = json['shopDetail'] != null
        ? ShopDetail.fromJson(json['shopDetail'])
        : null;
    filterBrand = json['filterBrand'] != null
        ? FilterBrand.fromJson(json['filterBrand'])
        : null;
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shopDetail != null) {
      data['shopDetail'] = shopDetail!.toJson();
    }
    if (filterBrand != null) {
      data['filterBrand'] = filterBrand!.toJson();
    }
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopDetail {
  String? shopName;
  String? ownerName;
  int? contactNumber;
  String? shopTiming;
  String? shopCordinates;
  String? address;
  String? shopImageUrl;

  ShopDetail(
      {this.shopName,
      this.ownerName,
      this.contactNumber,
      this.shopTiming,
      this.shopCordinates,
      this.address,
      this.shopImageUrl});

  ShopDetail.fromJson(Map<String, dynamic> json) {
    shopName = json['shopName'];
    ownerName = json['ownerName'];
    contactNumber = json['contactNumber'];
    shopTiming = json['shopTiming'];
    shopCordinates = json['shopCordinates'];
    address = json['address'];
    shopImageUrl = json['shopImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shopName'] = shopName;
    data['ownerName'] = ownerName;
    data['contactNumber'] = contactNumber;
    data['shopTiming'] = shopTiming;
    data['shopCordinates'] = shopCordinates;
    data['address'] = address;
    data['shopImageUrl'] = shopImageUrl;
    return data;
  }
}

class FilterBrand {
  List<String>? brandName;

  FilterBrand({this.brandName});

  FilterBrand.fromJson(Map<String, dynamic> json) {
    brandName = json['brandName'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brandName'] = brandName;
    return data;
  }
}

class Product {
  String? productName;
  double? review;
  double? mrp;
  double? wholesale;
  String? description;
  int? stock;
  int? quantity;
  String? imageUrl;

  Product(
      {this.productName,
      this.review,
      this.mrp,
      this.wholesale,
      this.description,
      this.stock,
      this.quantity,
      this.imageUrl});

  Product.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    review = json['review'];
    mrp = json['mrp'];
    wholesale = json['wholesale'];
    description = json['description'];
    stock = json['stock'];
    quantity = json['quantity'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productName'] = productName;
    data['review'] = review;
    data['mrp'] = mrp;
    data['wholesale'] = wholesale;
    data['description'] = description;
    data['stock'] = stock;
    data['quantity'] = quantity;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
