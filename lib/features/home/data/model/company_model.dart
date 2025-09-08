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
          ? CompanyData.fromJson(json['data'] as Map<String, dynamic>)
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
  final List<CompanyModel>? companies;
  final PaginationLinks? links;
  final PaginationMeta? meta;

  CompanyData({
    this.companies,
    this.links,
    this.meta,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) {
    return CompanyData(
      companies: (json['data'] as List<dynamic>?)
          ?.map((companyJson) =>
              CompanyModel.fromJson(companyJson as Map<String, dynamic>))
          .toList(),
      links: json['links'] != null
          ? PaginationLinks.fromJson(json['links'] as Map<String, dynamic>)
          : null,
      meta: json['meta'] != null
          ? PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': companies?.map((e) => e.toJson()).toList(),
      'links': links?.toJson(),
      'meta': meta?.toJson(),
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
  final bool? isFavourite;
  final double? averageRating;
  final int? countReviews;
  final List<dynamic>? reviews;
  final String? createdAt;
  final String? updatedAt;

  final Map<String, Coverage>? coverage;

  CompanyModel({
    this.id,
    this.name,
    this.address,
    this.isFavourite,
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
    this.coverage,
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
      isFavourite: json['is_favourite'] as bool?,
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      countReviews: json['count_reviews'] as int?,
      reviews: json['reviews'] as List<dynamic>?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      coverage: json['coverage'] != null
          ? (json['coverage'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, Coverage.fromJson(value)),
            )
          : null,
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
      'coverage': coverage?.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class Coverage {
  final int? stateId;
  final String? stateName;
  final List<CoverageArea>? areas;

  Coverage({
    this.stateId,
    this.stateName,
    this.areas,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) {
    return Coverage(
      stateId: json['state_id'] as int?,
      stateName: json['state_name'] as String?,
      areas: (json['areas'] as List<dynamic>?)
          ?.map((e) => CoverageArea.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state_id': stateId,
      'state_name': stateName,
      'areas': areas?.map((e) => e.toJson()).toList(),
    };
  }
}

class CoverageArea {
  final int? id;
  final String? name;
  final String? type;
  final bool? pickupAvailable;
  final bool? deliveryAvailable;
  final Eta? eta;
  final Pricing? pricing;
  final String? notes;

  CoverageArea({
    this.id,
    this.name,
    this.type,
    this.pickupAvailable,
    this.deliveryAvailable,
    this.eta,
    this.pricing,
    this.notes,
  });

  factory CoverageArea.fromJson(Map<String, dynamic> json) {
    return CoverageArea(
      id: json['id'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      pickupAvailable: json['pickup_available'] as bool?,
      deliveryAvailable: json['delivery_available'] as bool?,
      eta: json['eta'] != null ? Eta.fromJson(json['eta']) : null,
      pricing:
          json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'pickup_available': pickupAvailable,
      'delivery_available': deliveryAvailable,
      'eta': eta?.toJson(),
      'pricing': pricing?.toJson(),
      'notes': notes,
    };
  }
}

class Eta {
  final int? minDays;
  final int? maxDays;

  Eta({this.minDays, this.maxDays});

  factory Eta.fromJson(Map<String, dynamic> json) {
    return Eta(
      minDays: json['min_days'] as int?,
      maxDays: json['max_days'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min_days': minDays,
      'max_days': maxDays,
    };
  }
}

class Pricing {
  final String? etaPrice;

  Pricing({this.etaPrice});

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      etaPrice: json['eta_price'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eta_price': etaPrice,
    };
  }
}

class PaginationLinks {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  PaginationLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory PaginationLinks.fromJson(Map<String, dynamic> json) {
    return PaginationLinks(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }
}

class PaginationMeta {
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final List<PaginationLink>? links;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  PaginationMeta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'] as int?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      links: (json['links'] as List<dynamic>?)
          ?.map((linkJson) =>
              PaginationLink.fromJson(linkJson as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'links': links?.map((e) => e.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}

class PaginationLink {
  final String? url;
  final String? label;
  final bool? active;

  PaginationLink({
    this.url,
    this.label,
    this.active,
  });

  factory PaginationLink.fromJson(Map<String, dynamic> json) {
    return PaginationLink(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}
