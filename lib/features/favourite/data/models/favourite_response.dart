class CompanyResponse {
  final bool? success;
  final String? message;
  final CompanyData? data;

  CompanyResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CompanyResponse.fromJson(Map<String, dynamic> json) {
    return CompanyResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? CompanyData.fromJson(json['data'] as List<dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class CompanyData {
  final List<FavoriteModel>? favorites;

  CompanyData({this.favorites});

  factory CompanyData.fromJson(List<dynamic> json) {
    return CompanyData(
      favorites: json
          .map((favoriteJson) =>
              FavoriteModel.fromJson(favoriteJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': favorites?.map((e) => e.toJson()).toList(),
    };
  }
}

class FavoriteModel {
  final int? id;
  final int? userId;
  final int? shipmentCompanyId;
  final String? createdAt;
  final String? updatedAt;
  final CompanyModel? company;

  FavoriteModel({
    this.id,
    this.userId,
    this.shipmentCompanyId,
    this.createdAt,
    this.updatedAt,
    this.company,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      shipmentCompanyId: json['shipment_company_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      company: json['company'] != null
          ? CompanyModel.fromJson(json['company'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'shipment_company_id': shipmentCompanyId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'company': company?.toJson(),
    };
  }
}

class CompanyModel {
  final int? id;
  final String? name;
  final String? address;
  final String? phone;
  final String? email;
  final String? description;
  final String? logo;
  final String? facebookUrl;
  final String? whatsappUrl;
  final bool? isActive;
  final double? averageRating;
  final int? countReviews;
  final List<dynamic>? reviews;
  final String? createdAt;
  final String? updatedAt;

  CompanyModel({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.description,
    this.logo,
    this.facebookUrl,
    this.whatsappUrl,
    this.isActive,
    this.averageRating,
    this.countReviews,
    this.reviews,
    this.createdAt,
    this.updatedAt,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      description: json['description'] as String?,
      logo: json['logo'] as String?,
      facebookUrl: json['facebook_url'] as String?,
      whatsappUrl: json['whatsapp_url'] as String?,
      isActive: json['is_active'] as bool?,
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      countReviews: json['count_reviews'] as int?,
      reviews: json['reviews'] as List<dynamic>?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'description': description,
      'logo': logo,
      'facebook_url': facebookUrl,
      'whatsapp_url': whatsappUrl,
      'is_active': isActive,
      'average_rating': averageRating,
      'count_reviews': countReviews,
      'reviews': reviews,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
