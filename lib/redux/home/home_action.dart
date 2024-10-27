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
import 'package:dealz/data/models/product_size_model.dart';
import 'package:dealz/data/models/size_model.dart';
import 'package:dealz/data/models/slider_model.dart';
import 'package:dealz/data/models/state_model.dart';
import 'package:dealz/data/models/store_product_model.dart';
import 'package:dealz/data/models/trend_ads_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/redux/action_report.dart';

class HomeStatusAction {
  final String actionName = "HomeStatusAction";
  final ActionReport report;

  HomeStatusAction({required this.report});
}

class GetHomeDataAction {
  final String actionName = "GetHomeDataAction";
  final String homeType;

  GetHomeDataAction(this.homeType);
}

class SyncHomeDataAction {
  final String actionName = "SyncHomeDataAction";
  final HomeModel homeModel;

  SyncHomeDataAction({
    required this.homeModel,
  });
}

class GetStoreDetailsAction {
  final String actionName = "GetStoreDetailsAction";
  final int id;

  GetStoreDetailsAction({
    required this.id,
  });
}

class SyncStoreDetailsAction {
  final String actionName = "SyncStoreDetailsAction";
  final MyStoreModel storeDetails;

  SyncStoreDetailsAction({
    required this.storeDetails,
  });
}

class GetStoreProductListAction {
  final String actionName = "GetStoreProductListAction";
  final int id;

  GetStoreProductListAction({
    required this.id,
  });
}

class SyncStoreProductListAction {
  final String actionName = "SyncStoreProductListAction";
  final List<HomeProduct> storeProductList;

  SyncStoreProductListAction({
    required this.storeProductList,
  });
}

class GetSectionCategoriesAction {
  final String actionName = "GetSectionCategoriesAction";
  final int sectionId;

  GetSectionCategoriesAction({
    required this.sectionId,
  });
}

class SyncSectionCategoriesAction {
  final String actionName = "SyncSectionCategoriesAction";
  final List<CategoryModel> sectionCategories;

  SyncSectionCategoriesAction({
    required this.sectionCategories,
  });
}

class GetSectionProductsAction {
  final String actionName = "GetSectionProductsAction";
  final int sectionId;

  GetSectionProductsAction({
    required this.sectionId,
  });
}

class SyncSectionProductsAction {
  final String actionName = "SyncSectionProductsAction";
  final List<HomeProduct> sectionProducts;

  SyncSectionProductsAction({
    required this.sectionProducts,
  });
}

class GetCategoryProductsAction {
  final String actionName = "GetCategoryProductsAction";
  final int categoryId;

  GetCategoryProductsAction({
    required this.categoryId,
  });
}

class SyncCategoryProductsAction {
  final String actionName = "SyncCategoryProductsAction";
  final List<HomeProduct> categoryProducts;

  SyncCategoryProductsAction({
    required this.categoryProducts,
  });
}

class CreateCommercialStoreAction {
  final String actionName = "CreateOrdinaryAdsAction";
  final CreateStoreModel createStoreModel;

  CreateCommercialStoreAction({
    required this.createStoreModel,
  });
}

class UpdateCommercialStoreAction {
  final String actionName = "UpdateCommercialStoreAction";
  final CreateStoreModel createStoreModel;
  final int storeId;

  UpdateCommercialStoreAction({
    required this.createStoreModel,
    required this.storeId,
  });
}

class GetCitiesAction {
  final String actionName = "GetCitiesAction";
  final int stateId;

  GetCitiesAction({
    required this.stateId,
  });
}

class SyncCitiesAction {
  final String actionName = "SyncCitiesAction";
  final List<CityModel> cities;

  SyncCitiesAction({
    required this.cities,
  });
}

class GetStatesAction {
  final String actionName = "GetStatesAction";

  GetStatesAction();
}

class SyncStatesAction {
  final String actionName = "SyncStatesAction";
  final List<StateModel> states;

  SyncStatesAction({
    required this.states,
  });
}

class GetSectionsAction {
  final String actionName = "GetSectionsAction";

  GetSectionsAction();
}

class SyncSectionsAction {
  final String actionName = "SyncSectionsAction";
  final List<DealsSectionModel> sections;

  SyncSectionsAction({
    required this.sections,
  });
}

class CreateOrdinaryAdsAction {
  final String actionName = "CreateOrdinaryAdsAction";
  final CreateOrdinaryAdsModel createOrdinaryAdsModel;

  CreateOrdinaryAdsAction({
    required this.createOrdinaryAdsModel,
  });
}

class GetPackagesAction {
  final String actionName = "GetPackagesAction";

  GetPackagesAction();
}

class SyncPackagesAction {
  final String actionName = "SyncPackagesAction";
  final List<PackageModel> packages;

  SyncPackagesAction({
    required this.packages,
  });
}

class CreateTrendAdsAction {
  final String actionName = "CreateOrdinaryAdsAction";
  final CreateTrendAdsModel createTrendAdsModel;

  CreateTrendAdsAction({
    required this.createTrendAdsModel,
  });
}

class CreateCommercialAdsAction {
  final String actionName = "CreateOrdinaryAdsAction";
  final CreateCommercialAdsModel createCommercialAdsModel;

  CreateCommercialAdsAction({
    required this.createCommercialAdsModel,
  });
}

class UpdateCommercialAdsAction {
  final String actionName = "UpdateCommercialAdsAction";
  final CreateCommercialAdsModel createCommercialAdsModel;
  final int storeId;

  UpdateCommercialAdsAction({
    required this.createCommercialAdsModel,
    required this.storeId,
  });
}

class CreateAddressAction {
  final String actionName = "CreateAddressAction";
  final AddressModel addressModel;

  CreateAddressAction({
    required this.addressModel,
  });
}

class GetAddressAction {
  final String actionName = "GetAddressAction";

  GetAddressAction();
}

class SyncAddressAction {
  final String actionName = "SyncAddressAction";
  final List<AddressModel> addresses;

  SyncAddressAction({
    required this.addresses,
  });
}

class GetCommercialStoresAction {
  final String actionName = "GetCommercialStoresAction";
  final bool isActive;

  GetCommercialStoresAction(this.isActive);
}

class SyncCommercialStoresAction {
  final String actionName = "SyncCommercialStoresAction";
  final List<CommercialStoreModel> commercialStores;

  SyncCommercialStoresAction({
    required this.commercialStores,
  });
}

class GetPageDataAction {
  final String actionName = "GetPageDataAction";
  final String identifier;

  GetPageDataAction({
    required this.identifier,
  });
}

class SyncPageDataAction {
  final String actionName = "SyncPageDataAction";
  final PageModel pageData;

  SyncPageDataAction({
    required this.pageData,
  });
}

class GetMyAdsAction {
  final String actionName = "GetMyAdsAction";

  GetMyAdsAction();
}

class SyncMyAdsAction {
  final String actionName = "SyncMyAdsAction";
  final List<MyAdsModel> myAds;

  SyncMyAdsAction({
    required this.myAds,
  });
}

class GetAdsSectionsAction {
  final String actionName = "GetAdsSectionsAction";
  final String type;

  GetAdsSectionsAction(this.type);
}

class SyncAdsSectionsAction {
  final String actionName = "SyncAdsSectionsAction";
  final List<DealsSectionModel> adsSections;

  SyncAdsSectionsAction({
    required this.adsSections,
  });
}

class GetAdsSliderAction {
  final String actionName = "GetAdsSliderAction";

  GetAdsSliderAction();
}

class SyncAdsSliderAction {
  final String actionName = "SyncAdsSliderAction";
  final List<SliderModel> adsSlider;

  SyncAdsSliderAction({
    required this.adsSlider,
  });
}

class GetTrendVerticalAdsAction {
  final String actionName = "GetTrendAdsAction";
  final bool isPagination;

  GetTrendVerticalAdsAction(this.isPagination);
}

class SyncTrendVerticalAdsAction {
  final String actionName = "SyncTrendVerticalAdsAction";
  final List<TrendAdsModel> verticalAds;
  final PaginationModel page;

  SyncTrendVerticalAdsAction({
    required this.verticalAds,
    required this.page,
  });
}

class GetTrendSmallAdsAction {
  final String actionName = "GetTrendAdsAction";
  final bool isPagination;

  GetTrendSmallAdsAction(this.isPagination);
}

class SyncTrendSmallAdsAction {
  final String actionName = "SyncTrendSmallAdsAction";
  final List<TrendAdsModel> smallAds;
  final PaginationModel page;

  SyncTrendSmallAdsAction({
    required this.smallAds,
    required this.page,
  });
}

class GetTrendBigAdsAction {
  final String actionName = "GetTrendAdsAction";
  final bool isPagination;

  GetTrendBigAdsAction(this.isPagination);
}

class SyncTrendBigAdsAction {
  final String actionName = "SyncTrendBigAdsAction";
  final List<TrendAdsModel> bigAds;
  final PaginationModel page;

  SyncTrendBigAdsAction({
    required this.bigAds,
    required this.page,
  });
}

class GetOrdinaryAdsAction {
  final String actionName = "GetOrdinaryAdsAction";

  GetOrdinaryAdsAction();
}

class SyncOrdinaryAdsAction {
  final String actionName = "SyncOrdinaryAdsAction";
  final List<MyAdsModel> ordinaryAds;

  SyncOrdinaryAdsAction({
    required this.ordinaryAds,
  });
}

class GetAdsBySectionAction {
  final String actionName = "GetCategoryProductsAction";
  final int sectionId;

  GetAdsBySectionAction({
    required this.sectionId,
  });
}

class SyncAdsBySectionAction {
  final String actionName = "SyncAdsBySectionAction";
  final List<MyAdsModel> adsBySection;

  SyncAdsBySectionAction({
    required this.adsBySection,
  });
}

class GetCommercialAdsAction {
  final String actionName = "GetCommercialAdsAction";
  final bool pagination;
  final int? sectionId;

  GetCommercialAdsAction({
    required this.pagination,
    this.sectionId,
  });
}

class SyncCommercialAdsAction {
  final String actionName = "SyncCommercialAdsAction";
  final List<CommercialAdsModel> commercialAds;
  final PaginationModel adPage;

  SyncCommercialAdsAction({
    required this.commercialAds,
    required this.adPage,
  });
}

class CreateContentViewAction {
  final String actionName = "CreateContentViewAction";
  final int contentId;
  final profileType type;

  CreateContentViewAction({
    required this.contentId,
    required this.type,
  });
}

class FollowUserAction {
  final String actionName = "FollowUserAction";
  final UserModel user;

  FollowUserAction({
    required this.user,
  });
}

class UnFollowUserAction {
  final String actionName = "FollowUserAction";
  final UserModel user;

  UnFollowUserAction({
    required this.user,
  });
}

class FollowStoreAction {
  final String actionName = "FollowStoreAction";
  final MyStoreModel storeDetails;

  FollowStoreAction(this.storeDetails);
}

class UnFollowStoreAction {
  final String actionName = "FollowStoreAction";
  final MyStoreModel storeDetails;

  UnFollowStoreAction(this.storeDetails);
}

class GetFollowingStoresAction {
  final String actionName = "GetFollowingStoresAction";

  GetFollowingStoresAction();
}

class SyncFollowingStoresAction {
  final String actionName = "SyncFollowingStoresAction";
  final List<MyStoreModel> stores;

  SyncFollowingStoresAction(this.stores);
}

class GetMostWatchedAdsAction {
  final String actionName = "GetMostWatchedAdsAction";

  GetMostWatchedAdsAction();
}

class SyncMostWatchedAdsAction {
  final String actionName = "SyncMostWatchedAdsAction";
  final List<MyAdsModel> mostWantedAds;

  SyncMostWatchedAdsAction({
    required this.mostWantedAds,
  });
}

class GetAdsCategoriesAction {
  final String actionName = "GetAdsCategoriesAction";
  final int categoryId;

  GetAdsCategoriesAction(this.categoryId);
}

class SyncAdsCategoriesAction {
  final String actionName = "SyncAdsCategoriesAction";
  final List<MyAdsModel> ads;

  SyncAdsCategoriesAction({
    required this.ads,
  });
}

class SearchInAdsCategoriesAction {
  final String actionName = "GetAdsCategoriesAction";
  final int categoryId;
  final String search;

  SearchInAdsCategoriesAction(this.categoryId, this.search);
}

class CreateRatingAction {
  final String actionName = "CreateRatingAction";
  final int contentId;
  final double rating;

  CreateRatingAction({
    required this.contentId,
    required this.rating,
  });
}

class SendMessageAction {
  final String actionName = "SendMessageAction";
  final int userId;
  final String message;

  SendMessageAction({
    required this.userId,
    required this.message,
  });
}

class GetChatsAction {
  final String actionName = "GetChatsAction";

  GetChatsAction();
}

class SyncChatsAction {
  final String actionName = "SyncChatsAction";
  final List<UserModel> users;

  SyncChatsAction(this.users);
}

class GetChatMessagesAction {
  final String actionName = "GetChatMessagesAction";
  final int chatId;

  GetChatMessagesAction({required this.chatId});
}

class SyncChatMessagesAction {
  final String actionName = "SyncChatMessagesAction";
  final List<MessageModel> messages;

  SyncChatMessagesAction({required this.messages});
}

class CreateCommentAction {
  final String actionName = "CreateCommentAction";
  final MyAdsModel content;
  final String comment;

  CreateCommentAction({required this.content, required this.comment});
}

class UpdateCommentAction {
  final String actionName = "CreateCommentAction";
  final CommentModel comment;
  final String commentText;

  UpdateCommentAction({required this.comment, required this.commentText});
}

class ReportCommentAction {
  final String actionName = "ReportCommentAction";
  final int commentId;

  ReportCommentAction({required this.commentId});
}

class DeleteCommentAction {
  final String actionName = "DeleteCommentAction";
  final CommentModel comment;
  final MyAdsModel adsModel;

  DeleteCommentAction({required this.comment, required this.adsModel});
}

class GetWishListAction {
  final String actionName = "GetWishListAction";
  final String type;

  GetWishListAction({required this.type});
}

class SyncWishListAction {
  final String actionName = "GetWishListAction";
  final List<MyAdsModel> wishlist;

  SyncWishListAction({required this.wishlist});
}

class AddToWishListAction {
  final String actionName = "AddToWishListAction";
  final String type;
  final MyAdsModel myAdsModel;

  AddToWishListAction({required this.type, required this.myAdsModel});
}

class DeleteFromWishListAction {
  final String actionName = "AddToWishListAction";
  final String type;
  final MyAdsModel myAdsModel;

  DeleteFromWishListAction({required this.type, required this.myAdsModel});
}

class GetUserAdsAction {
  final String actionName = "GetUserAdsAction";
  final int userId;

  GetUserAdsAction(this.userId);
}

class SyncUserAdsAction {
  final String actionName = "SyncUserAdsAction";
  final List<MyAdsModel> userAds;

  SyncUserAdsAction(this.userAds);
}

class GetAdsFeaturesAction {
  final String actionName = "GetAdsFeaturesAction";
  final int sectionId;

  GetAdsFeaturesAction(this.sectionId);
}

class SyncAdsFeaturesAction {
  final String actionName = "SyncAdsFeaturesAction";
  final List<FeatureModel> features;

  SyncAdsFeaturesAction(this.features);
}

class GetLastSeenAction {
  final String actionName = "GetLastSeenAction";

  GetLastSeenAction();
}

class SyncLastSeenAction {
  final String actionName = "SyncLastSeenAction";
  final List<MyAdsModel> ads;

  SyncLastSeenAction(this.ads);
}

class PostWhatsappClicksAction {
  final String actionName = "PostWhatsappClicksAction";
  final int adsId;

  PostWhatsappClicksAction(this.adsId);
}

class GetAdsByIdAction {
  final String actionName = "GetAdsByIdAction";
  final int adsId;

  GetAdsByIdAction(this.adsId);
}

class SyncAdsByIdAction {
  final String actionName = "SyncAdsByIdAction";
  final MyAdsModel myAdsModel;

  SyncAdsByIdAction(this.myAdsModel);
}

class GetUserProfileAction {
  final String actionName = "GetUserProfileAction";
  final int userId;

  GetUserProfileAction(this.userId);
}

class SyncUserProfileAction {
  final String actionName = "SyncUserProfileAction";
  final UserModel user;

  SyncUserProfileAction(this.user);
}

class GetFollowingsAction {
  final String actionName = "GetFollowingsAction";

  GetFollowingsAction();
}

class SyncFollowingsAction {
  final String actionName = "SyncFollowingsAction";
  final List<UserModel> followings;

  SyncFollowingsAction(this.followings);
}

class GetSimilarAdsAction {
  final String actionName = "GetSimilarAdsAction";
  final int adsId;

  GetSimilarAdsAction(this.adsId);
}

class SyncSimilarAdsAction {
  final String actionName = "SyncSimilarAdsAction";
  final List<MyAdsModel> similarAds;

  SyncSimilarAdsAction(this.similarAds);
}

class GetTrendSizesAction {
  final String actionName = "GetTrendSizesAction";

  GetTrendSizesAction();
}

class SyncTrendSizesAction {
  final String actionName = "SyncTrendSizesAction";
  final List<SizeModel> trendSizes;

  SyncTrendSizesAction(this.trendSizes);
}

class UpdateAdsStatusAction {
  final String actionName = "UpdateAdsStatusAction";
  final MyAdsModel adsModel;

  UpdateAdsStatusAction(this.adsModel);
}

class UpgradeAdsAction {
  final String actionName = "UpdateAdsStatusAction";
  final int packageId;
  final int packageDays;
  final MyAdsModel adsModel;

  UpgradeAdsAction({required this.packageId, required this.adsModel, required this.packageDays});
}

class AddProductToStoreAction {
  final String actionName = "AddProductToStoreAction";
  final int storeId;
  final StoreProductModel productModel;

  AddProductToStoreAction({required this.storeId, required this.productModel});
}

class UpdateProductToStoreAction {
  final String actionName = "UpdateProductToStoreAction";
  final int storeId;
  final StoreProductModel productModel;

  UpdateProductToStoreAction({required this.storeId, required this.productModel});
}

class GetStoreProductsAction {
  final String actionName = "GetStoreProductsAction";
  final int storeId;
  final bool pagination;

  GetStoreProductsAction({required this.storeId, required this.pagination});
}

class SyncStoreProductsAction {
  final String actionName = "SyncStoreProductsAction";
  final List<StoreProductModel> products;
  final PaginationModel productsPage;

  SyncStoreProductsAction({
    required this.products,
    required this.productsPage,
  });
}

class SyncOneStoreProductsAction {
  final String actionName = "SyncOneStoreProductsAction";
  final StoreProductModel product;

  SyncOneStoreProductsAction({required this.product});
}

class GetSectionAttributesAction {
  final String actionName = "GetSectionAttributesAction";
  final int sectionId;

  GetSectionAttributesAction(this.sectionId);
}

class SyncSectionAttributesAction {
  final String actionName = "SyncSectionAttributesAction";
  final List<SectionAttributesModel> attributes;

  SyncSectionAttributesAction(this.attributes);
}

class SyncFilterDataAction {
  final String actionName = "SyncFilterDataAction";
  final SortAndFilterModel filterData;

  SyncFilterDataAction(this.filterData);
}

class DeleteChatAction {
  final String actionName = "DeleteChatAction";
  final int chatId;

  DeleteChatAction(this.chatId);
}

class ReportProductAction {
  final String actionName = "ReportProductAction";
  final int productId;

  ReportProductAction(this.productId);
}

class GetColorsAction {
  final String actionName = "GetColorsAction";

  GetColorsAction();
}

class SyncColorsAction {
  final String actionName = "SyncColorsAction";
  final List<ColorModel> colors;

  SyncColorsAction(this.colors);
}

class GetSizesAction {
  final String actionName = "GetSizesAction";

  GetSizesAction();
}

class SyncSizesAction {
  final String actionName = "SyncSizesAction";
  final List<ProductSizeModel> sizes;

  SyncSizesAction(this.sizes);
}
