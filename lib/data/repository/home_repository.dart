import 'package:dealz/data/models/address_model.dart';
import 'package:dealz/data/models/attributes_models.dart';
import 'package:dealz/data/models/category_model.dart';
import 'package:dealz/data/models/city_model.dart';
import 'package:dealz/data/models/color_model.dart';
import 'package:dealz/data/models/comment_model.dart';
import 'package:dealz/data/models/commercial_ad_model.dart';
import 'package:dealz/data/models/commercial_store_model.dart';
import 'package:dealz/data/models/create_commercial_ads_model.dart';
import 'package:dealz/data/models/create_ordinary_ads_model.dart';
import 'package:dealz/data/models/create_store_model.dart';
import 'package:dealz/data/models/create_trend_ads_model.dart';
import 'package:dealz/data/models/deals_section_model.dart';
import 'package:dealz/data/models/feature_model.dart';
import 'package:dealz/data/models/filter_and_sort_model.dart';
import 'package:dealz/data/models/home_model.dart';
import 'package:dealz/data/models/message_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/data/models/my_store_model.dart';
import 'package:dealz/data/models/packages_model.dart';
import 'package:dealz/data/models/page_model.dart';
import 'package:dealz/data/models/pagination_model.dart';
import 'package:dealz/data/models/pair.dart';
import 'package:dealz/data/models/product_size_model.dart';
import 'package:dealz/data/models/size_model.dart';
import 'package:dealz/data/models/slider_model.dart';
import 'package:dealz/data/models/state_model.dart';
import 'package:dealz/data/models/store_details_model.dart';
import 'package:dealz/data/models/store_product_model.dart';
import 'package:dealz/data/models/trend_ads_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/data/models/wishlist_model.dart';
import 'package:dealz/data/network_common.dart';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

class HomeRepository {
  const HomeRepository();

  Future<HomeModel> getHomeData(String homeType) {
    return new NetworkCommon().dio.get("home", queryParameters: {
      "type": homeType,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return HomeModel.fromJson(results);
      },
    );
  }

  Future<StoreDetailsModel> getStoreDetails(int id) {
    return new NetworkCommon().dio.get("store/$id").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return StoreDetailsModel.fromJson(results);
      },
    );
  }

  Future<List<HomeProduct>> getStoreProductList(int id) {
    return new NetworkCommon().dio.get("store/products/$id").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results as List).map((e) => HomeProduct.fromJson(e)).toList();
      },
    );
  }

  Future<List<CategoryModel>> getSectionCategories(int sectionId) {
    return new NetworkCommon().dio.get("getCategories/$sectionId").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results as List).map((e) => CategoryModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<HomeProduct>> getSectionProducts(int sectionId) {
    return new NetworkCommon().dio.get("section/products/$sectionId").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        if (results is List)
          return results.map((e) => HomeProduct.fromJson(e)).toList();
        else
          return [];
      },
    );
  }

  Future<List<HomeProduct>> getCategoryProducts(int sectionId) {
    return new NetworkCommon().dio.get("category/products/$sectionId").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        if (results is List)
          return results.map((e) => HomeProduct.fromJson(e)).toList();
        else
          return [];
      },
    );
  }

  Future<bool> createCommercialStore(CreateStoreModel storeModel) {
    return new NetworkCommon().dio.post("customer/stores", data: storeModel.toJson(false)).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<List<StateModel>> getStates() {
    return new NetworkCommon().dio.get("states").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['states'] as List).map((e) => StateModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<CityModel>> getStateCities(int stateId) {
    return new NetworkCommon().dio.get("cities?id=$stateId").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['cities'] as Map).values.map((e) => CityModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<DealsSectionModel>> getDealsSection() {
    return new NetworkCommon().dio.get("sections?type=deals").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['section'] as List).map((e) => DealsSectionModel.fromJson(e)).toList();
      },
    );
  }

  Future<bool> createOrdinaryAds(CreateOrdinaryAdsModel adsModel) {
    return new NetworkCommon().dio.post("customer/ordinary/ads", data: adsModel.toJson()).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<List<PackageModel>> getDealsPackages() {
    return new NetworkCommon().dio.get("packages").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['packages'] as List).map((e) => PackageModel.fromJson(e)).toList();
      },
    );
  }

  Future<bool> createTrendAds(CreateTrendAdsModel createTrendAdsModel) {
    return new NetworkCommon().dio.post("customer/trends", data: createTrendAdsModel.toJson()).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<bool> createCommercialAds(CreateCommercialAdsModel createCommercialAdsModel) {
    return new NetworkCommon()
        .dio
        .post(
          "customer/commerical/ads",
          data: createCommercialAdsModel.toJson(),
        )
        .then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<bool> createAddress(AddressModel addressModel) {
    return new NetworkCommon().dio.post("user/address", data: addressModel.toJson()).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<List<AddressModel>> getUserAddresses() {
    return new NetworkCommon().dio.get("user/address").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['addresses'] as List).map((e) => AddressModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<CommercialStoreModel>> getCommercialStores(bool isActive) {
    return new NetworkCommon().dio.get("user/commercial/stores", queryParameters: {
      "active": isActive ? "yes" : "no",
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['stores'] as List).map((e) => CommercialStoreModel.fromJson(e)).toList();
      },
    );
  }

  Future<PageModel> getPageData(String identifier) {
    return new NetworkCommon().dio.get("pages/$identifier").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return PageModel.fromJson(results['page']);
      },
    );
  }

  Future<List<MyAdsModel>> getMyAds() {
    return new NetworkCommon().dio.get("user/ads").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['ads'] as List).map((e) => MyAdsModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<DealsSectionModel>> getAdsSections(String type) {
    return new NetworkCommon().dio.get("sections?type=$type").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['section'] as List).map((e) => DealsSectionModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<SliderModel>> getAdsSlider() {
    return new NetworkCommon().dio.get("promotion/sliders?type=ads").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['sliders'] as List).map((e) => SliderModel.fromJson(e)).toList();
      },
    );
  }

  Future<Pair<PaginationModel, List<CommercialAdsModel>>> getCommercialAds({required int page, int? sectionId}) {
    Map<String, dynamic> query = {
      "page": page,
    };
    if (sectionId != null) {
      query['section_id'] = sectionId;
    }
    return new NetworkCommon().dio.get("customer/ads/commercial", queryParameters: query).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        final List<CommercialAdsModel> ads =
            (results['data'] as List).map((e) => CommercialAdsModel.fromJson(e)).toList();
        final PaginationModel page = PaginationModel.fromJson(results['meta']);
        return Pair(page, ads);
      },
    );
  }

  Future<List<MyAdsModel>> getOrdinaryAds() {
    return new NetworkCommon().dio.get("special/advertisements").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['advertisements'] as Map).values.toList().map((e) => MyAdsModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<MyAdsModel>> getMostWatchedAds() {
    return new NetworkCommon().dio.get("most_watched/advertisements").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['advertisements'] as List).map((e) => MyAdsModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<MyAdsModel>> getCategoryAds(int categoryId) {
    return new NetworkCommon().dio.get("category/advertisements", queryParameters: {
      "id": categoryId,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['advertisements'] as List).map((e) => MyAdsModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<MyAdsModel>> searchInCategoryAds(int categoryId, String search) {
    return new NetworkCommon().dio.get("search/categories", queryParameters: {
      "id": categoryId,
      "query": search,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['advertisements'] as List).map((e) => MyAdsModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<MyAdsModel>> getAdsById(int id, SortAndFilterModel? filterData) {
    return new NetworkCommon().dio.get("customer/sections/$id/ads", queryParameters: filterData?.toJson() ?? {}).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['data'] as List).map((e) => MyAdsModel.fromJson(e)).toList();
      },
    );
  }

  Future<bool> createContentView(int contentId, profileType profileType) {
    return new NetworkCommon().dio.post("views", data: {
      "content_id": contentId,
      "type": profileType.name,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<bool> createUserFollow(int userId) {
    return new NetworkCommon().dio.post("customer/users/$userId/follow").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<bool> createUserUnFollow(int userId) {
    return new NetworkCommon().dio.delete("customer/users/$userId/unfollow").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<bool> createStoreFollow(int storeId) {
    return new NetworkCommon().dio.post("customer/stores/$storeId/follow").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<bool> createStoreUnFollow(int storeId) {
    return new NetworkCommon().dio.delete("customer/stores/$storeId/unfollow").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<List<MyStoreModel>> getFollowingStores() {
    return new NetworkCommon().dio.get("customer/following/stores").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['data'] as List).map((e) => MyStoreModel.fromJson(e)).toList();
      },
    );
  }

  Future<UserModel> getUserProfile(int userId) {
    return new NetworkCommon().dio.get("customer/profile/$userId").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return UserModel.fromJson(results['data']);
      },
    );
  }

  Future<bool> createRating(int contentId, double rating) {
    return new NetworkCommon().dio.post("ratings", data: {
      "content_id": contentId,
      "type": "advertisement",
      "rating": rating,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<bool> sendMessage(int recipientId, String message) {
    return new NetworkCommon().dio.post("sendMessage", data: {
      "recipient_id": recipientId,
      "text": message,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<List<UserModel>> getChats() {
    return new NetworkCommon().dio.get("chats").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return results['users'] == null ? [] : (results['users'] as List).map((e) => UserModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<MessageModel>> getChatMessage(int chatId) {
    return new NetworkCommon().dio.get("previous-chats/${chatId}").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['chats'] as List).map((e) => MessageModel.fromJson(e)).toList();
      },
    );
  }

  Future<CommentModel> postComment(MyAdsModel ad, String comment) {
    return new NetworkCommon().dio.post("comments", data: {
      "content_id": ad.id,
      "comment": comment,
      "type": "advertisement",
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return CommentModel.fromJson(results['data']);
      },
    );
  }

  Future<CommentModel> updateComment(CommentModel ad, String comment) {
    return new NetworkCommon().dio.put("comments/${ad.id}", data: {
      "comment": comment,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return CommentModel.fromJson(results['data']);
      },
    );
  }

  Future<int> reportProduct(int productId) {
    return new NetworkCommon().dio.post("report", data: {
      "content_id": productId,
      "type": "product",
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return 0;
      },
    );
  }

  Future<int> reportComment(int adId) {
    return new NetworkCommon().dio.post("report", data: {
      "content_id": adId,
      "type": "comment",
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return 0;
      },
    );
  }

  Future<int> deleteComment(int adId) {
    return new NetworkCommon().dio.delete("comments/$adId").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return 0;
      },
    );
  }

  Future<List<MyAdsModel>> getWishList(String type) {
    return new NetworkCommon().dio.get("wishlists", queryParameters: {
      "type": type,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['data'] as List).map((e) => MyAdsModel.fromJson(e)).toList();
      },
    );
  }

  Future<int> addWishList(String type, int contentId) {
    return new NetworkCommon().dio.post("wishlists", data: {
      "type": type,
      "content_id": contentId,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return 0;
      },
    );
  }

  Future<int> removeWishList(String type, int contentId) {
    return new NetworkCommon().dio.delete("wishlists", data: {
      "type": type,
      "content_id": contentId,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return 0;
      },
    );
  }

  Future<List<MyAdsModel>> getUserAds(int userId) {
    return new NetworkCommon().dio.get("user/advertisements", queryParameters: {
      "id": userId,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['advertisements'] as List).map((e) => MyAdsModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<FeatureModel>> getAdsFeatures(int sectionId) {
    return new NetworkCommon().dio.get("section/features", queryParameters: {
      "id": sectionId,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['features'] as List).map((e) => FeatureModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<MyAdsModel>> gatLastSeen() {
    return new NetworkCommon().dio.get("last-seen/advertisement").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        List<MyAdsModel?> ads = (results['advertisement'] as Map)
            .values
            .toList()
            .map((e) => e is int ? null : MyAdsModel.fromJson(e))
            .toList();
        return ads.whereNotNull().toList();
      },
    );
  }

  Future<bool> postWhatsAppClick(int adsId) {
    return new NetworkCommon().dio.post("advertisement/whatsapp/click", data: {
      "id": adsId,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<MyAdsModel> GetAdvertisementById(int adsId) {
    return new NetworkCommon().dio.get("advertisement", queryParameters: {
      "id": adsId,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return MyAdsModel.fromJson(results['advertisement']);
      },
    );
  }

  Future<List<UserModel>> GetUserFollowings() {
    return new NetworkCommon().dio.get("customer/following/users").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['data'] as List).map((e) => UserModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<MyAdsModel>> getSimilarAds(int id) {
    return new NetworkCommon().dio.get("customer/ads/$id/similar").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['data'] as List).map((e) => MyAdsModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<SizeModel>> getTrendSizes() {
    return new NetworkCommon().dio.get("customer/trends/sizes").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['data'] as List).map((e) => SizeModel.fromJson(e)).toList();
      },
    );
  }

  Future<Pair<PaginationModel, List<TrendAdsModel>>> getVerticalTrendAds(int page) {
    return new NetworkCommon().dio.get("customer/trends/vertical", queryParameters: {
      "page": page,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        final List<TrendAdsModel> verticalAds =
            (results['data'] as List).map((e) => TrendAdsModel.fromJson(e)).toList();
        final PaginationModel page = PaginationModel.fromJson(results['meta']);
        return Pair(page, verticalAds);
      },
    );
  }

  Future<Pair<PaginationModel, List<TrendAdsModel>>> getSmallTrendAds(int page) {
    return new NetworkCommon().dio.get("customer/trends/small", queryParameters: {
      "page": page,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        final List<TrendAdsModel> verticalAds =
            (results['data'] as List).map((e) => TrendAdsModel.fromJson(e)).toList();
        final PaginationModel page = PaginationModel.fromJson(results['meta']);
        return Pair(page, verticalAds);
      },
    );
  }

  Future<Pair<PaginationModel, List<TrendAdsModel>>> getBigTrendAds(int page) {
    return new NetworkCommon().dio.get("customer/trends/big", queryParameters: {
      "page": page,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        final List<TrendAdsModel> verticalAds =
            (results['data'] as List).map((e) => TrendAdsModel.fromJson(e)).toList();
        final PaginationModel page = PaginationModel.fromJson(results['meta']);
        return Pair(page, verticalAds);
      },
    );
  }

  Future<bool> updateAdsStatus(int adsId, int newStatus) {
    return new NetworkCommon().dio.put("customer/ads/$adsId/status", queryParameters: {
      "active": newStatus,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<bool> upgradeAds(int adsId, int packageId) {
    return new NetworkCommon().dio.put("customer/ads/$adsId/upgrade", queryParameters: {
      "package_id": packageId,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<MyStoreModel> myStoreDetailsById(int storeId) {
    return new NetworkCommon().dio.get("customer/stores/$storeId").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return MyStoreModel.fromJson(results['data']);
      },
    );
  }

  Future<StoreProductModel> createStoreProduct(int storeId, StoreProductModel productModel) {
    return new NetworkCommon()
        .dio
        .post("customer/stores/$storeId/products", data: productModel.toJson(isUpdate: false))
        .then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return StoreProductModel.fromJson(results['data']);
      },
    );
  }

  Future<Pair<List<StoreProductModel>, PaginationModel>> getStoreProducts(int storeId, int page) {
    return new NetworkCommon().dio.get("customer/stores/$storeId/products", queryParameters: {
      "page": page,
    }).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        final List<StoreProductModel> products =
            (results["data"] as List).map((e) => StoreProductModel.fromJson(e)).toList();
        final PaginationModel page = PaginationModel.fromJson(results['meta']);
        return Pair(products, page);
      },
    );
  }

  Future<List<SectionAttributesModel>> getSectionsAttributes(int sectionId) {
    return new NetworkCommon().dio.get("customer/sections/$sectionId/attributes").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results["data"] as List).map((e) => SectionAttributesModel.fromJson(e)).toList();
      },
    );
  }

  Future<StoreProductModel> updateStoreProduct(int storeId, StoreProductModel productModel) {
    return new NetworkCommon()
        .dio
        .post("customer/stores/$storeId/products/${productModel.id}", data: productModel.toJson(isUpdate: true))
        .then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return StoreProductModel.fromJson(results['data']);
      },
    );
  }

  Future<bool> updateCommercialStore(CreateStoreModel storeModel, int storeId) {
    return new NetworkCommon().dio.post("customer/stores/$storeId", data: storeModel.toJson(true)).then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<bool> deleteChat(int chatId) {
    return new NetworkCommon().dio.delete("chats/$chatId").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return true;
      },
    );
  }

  Future<List<ColorModel>> getColors() {
    return new NetworkCommon().dio.get("customer/colors").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['data'] as List).map((e) => ColorModel.fromJson(e)).toList();
      },
    );
  }

  Future<List<ProductSizeModel>> getSizes() {
    return new NetworkCommon().dio.get("customer/sizes").then(
      (d) {
        var results = new NetworkCommon().decodeResp(d);
        return (results['data'] as List).map((e) => ProductSizeModel.fromJson(e)).toList();
      },
    );
  }
}
