import 'package:dealz/data/models/address_model.dart';
import 'package:dealz/data/models/attributes_models.dart';
import 'package:dealz/data/models/category_model.dart';
import 'package:dealz/data/models/city_model.dart';
import 'package:dealz/data/models/color_model.dart';
import 'package:dealz/data/models/commercial_ad_model.dart';
import 'package:dealz/data/models/commercial_store_model.dart';
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
import 'package:dealz/data/models/store_details_model.dart';
import 'package:dealz/data/models/store_product_model.dart';
import 'package:dealz/data/models/trend_ads_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/redux/action_report.dart';

class HomeState {
  final Map<String, ActionReport> status;
  HomeModel? homeData;
  final MyStoreModel? storeDetails;
  final Map<String, HomeProduct> storeProductList;
  final Map<String, CategoryModel> sectionCategories;
  final Map<String, HomeProduct> categoryProducts;
  final Map<String, HomeProduct> sectionProducts;
  final Map<String, DealsSectionModel> dealsSections;
  final Map<String, StateModel> states;
  final Map<String, CityModel> cities;
  final Map<String, PackageModel> packages;
  final Map<String, AddressModel> addresses;
  final Map<String, CommercialStoreModel> commercialStore;
  PageModel? pageModel;
  final Map<String, MyAdsModel> myAds;
  final Map<String, SliderModel> adsSliders;
  final Map<String, DealsSectionModel> adsSections;
  final Map<String, MyAdsModel> ordinaryAds;
  final Map<String, MyAdsModel> adsBySection;
  final Map<String, CommercialAdsModel> commercialAds;
  final Map<String, MyAdsModel> mostWantedAds;
  final Map<String, MyAdsModel> categoriesAds;
  final Map<String, MyAdsModel> lastSeen;
  final Map<String, UserModel> chats;
  final Map<String, MessageModel> messages;
  final Map<String, MyAdsModel> wishList;
  final Map<String, MyAdsModel> userAds;
  final Map<String, MyAdsModel> similarAds;
  final Map<String, FeatureModel> features;
  final Map<String, UserModel> followings;
  final Map<String, SizeModel> trendSizes;
  final Map<String, StoreProductModel> storeProducts;
  final Map<int, Map<String, List<TrendAdsModel>>> trendAds;
  final Map<String, SectionAttributesModel> sectionAttributes;
  final PaginationModel? verticalPage;
  final PaginationModel? smallPage;
  final PaginationModel? bigPage;
  final PaginationModel? productsPage;
  final PaginationModel? commercialAdsPage;
  final SortAndFilterModel? filterData;
  final Map<String, MyStoreModel> followingStores;
  final Map<String, ColorModel> colors;
  final Map<String, ProductSizeModel> sizes;

  MyAdsModel? adsModel;
  UserModel? addedByUser;

  HomeState({
    required this.status,
    this.homeData,
    this.storeDetails,
    required this.storeProductList,
    required this.sectionCategories,
    required this.categoryProducts,
    required this.sectionProducts,
    required this.dealsSections,
    required this.states,
    required this.cities,
    required this.packages,
    required this.addresses,
    required this.commercialStore,
    this.pageModel,
    required this.myAds,
    required this.adsSliders,
    required this.adsSections,
    required this.ordinaryAds,
    required this.adsBySection,
    required this.commercialAds,
    required this.mostWantedAds,
    required this.categoriesAds,
    required this.chats,
    required this.messages,
    required this.wishList,
    required this.userAds,
    required this.similarAds,
    required this.features,
    required this.lastSeen,
    required this.followings,
    required this.trendSizes,
    required this.storeProducts,
    required this.sectionAttributes,
    this.productsPage,
    this.verticalPage,
    this.bigPage,
    this.smallPage,
    required this.trendAds,
    this.adsModel,
    this.addedByUser,
    this.filterData,
    required this.followingStores,
    this.commercialAdsPage,
    required this.colors,
    required this.sizes,
  });

  factory HomeState.initial() {
    return HomeState(
      status: Map(),
      homeData: null,
      storeDetails: null,
      storeProductList: Map(),
      sectionCategories: Map(),
      categoryProducts: Map(),
      sectionProducts: Map(),
      dealsSections: Map(),
      states: Map(),
      cities: Map(),
      packages: Map(),
      addresses: Map(),
      commercialStore: Map(),
      pageModel: null,
      myAds: Map(),
      adsSliders: Map(),
      adsSections: Map(),
      ordinaryAds: Map(),
      adsBySection: Map(),
      commercialAds: Map(),
      mostWantedAds: Map(),
      categoriesAds: Map(),
      messages: Map(),
      chats: Map(),
      wishList: Map(),
      userAds: Map(),
      features: Map(),
      lastSeen: Map(),
      followings: Map(),
      similarAds: Map(),
      trendSizes: Map(),
      trendAds: Map(),
      storeProducts: Map(),
      sectionAttributes: Map(),
      followingStores: Map(),
      smallPage: null,
      verticalPage: null,
      bigPage: null,
      adsModel: null,
      addedByUser: null,
      filterData: null,
      productsPage: null,
      commercialAdsPage: null,
      sizes: Map(),
      colors: Map(),
    );
  }

  HomeState copyWith({
    Map<String, ActionReport>? status,
    HomeModel? homeData,
    MyStoreModel? storeDetails,
    Map<String, HomeProduct>? storeProductList,
    Map<String, CategoryModel>? sectionCategories,
    Map<String, HomeProduct>? categoryProducts,
    Map<String, HomeProduct>? sectionProducts,
    Map<String, DealsSectionModel>? dealsSections,
    Map<String, StateModel>? states,
    Map<String, CityModel>? cities,
    Map<String, PackageModel>? packages,
    Map<String, AddressModel>? addresses,
    Map<String, CommercialStoreModel>? commercialStore,
    PageModel? pageModel,
    Map<String, MyAdsModel>? myAds,
    Map<String, SliderModel>? adsSliders,
    Map<String, DealsSectionModel>? adsSections,
    Map<String, MyAdsModel>? ordinaryAds,
    Map<String, MyAdsModel>? adsBySection,
    Map<String, CommercialAdsModel>? commercialAds,
    Map<String, MyAdsModel>? mostWantedAds,
    Map<String, MyAdsModel>? categoriesAds,
    Map<String, UserModel>? chats,
    Map<String, MessageModel>? messages,
    Map<String, MyAdsModel>? wishList,
    Map<String, MyAdsModel>? userAds,
    Map<String, FeatureModel>? features,
    Map<String, MyAdsModel>? lastSeen,
    Map<String, UserModel>? followings,
    MyAdsModel? adsModel,
    UserModel? addedByUser,
    Map<String, MyAdsModel>? similarAds,
    Map<String, SizeModel>? trendSizes,
    Map<int, Map<String, List<TrendAdsModel>>>? trendAds,
    Map<String, StoreProductModel>? storeProducts,
    PaginationModel? smallPage,
    PaginationModel? verticalPage,
    PaginationModel? bigPage,
    Map<String, SectionAttributesModel>? sectionAttributes,
    SortAndFilterModel? filterData,
    PaginationModel? productsPage,
    Map<String, MyStoreModel>? followingStores,
    PaginationModel? commercialAdsPage,
    Map<String, ColorModel>? colors,
    Map<String, ProductSizeModel>? sizes,
  }) {
    return HomeState(
      status: status ?? this.status,
      homeData: homeData ?? this.homeData,
      storeDetails: storeDetails ?? this.storeDetails,
      storeProductList: storeProductList ?? this.storeProductList,
      sectionCategories: sectionCategories ?? this.sectionCategories,
      categoryProducts: categoryProducts ?? this.categoryProducts,
      sectionProducts: sectionProducts ?? this.sectionProducts,
      dealsSections: dealsSections ?? this.dealsSections,
      states: states ?? this.states,
      cities: cities ?? this.cities,
      packages: packages ?? this.packages,
      addresses: addresses ?? this.addresses,
      commercialStore: commercialStore ?? this.commercialStore,
      pageModel: pageModel ?? this.pageModel,
      myAds: myAds ?? this.myAds,
      adsSliders: adsSliders ?? this.adsSliders,
      adsSections: adsSections ?? this.adsSections,
      ordinaryAds: ordinaryAds ?? this.ordinaryAds,
      adsBySection: adsBySection ?? this.adsBySection,
      commercialAds: commercialAds ?? this.commercialAds,
      mostWantedAds: mostWantedAds ?? this.mostWantedAds,
      categoriesAds: categoriesAds ?? this.categoriesAds,
      messages: messages ?? this.messages,
      chats: chats ?? this.chats,
      wishList: wishList ?? this.wishList,
      userAds: userAds ?? this.userAds,
      features: features ?? this.features,
      lastSeen: lastSeen ?? this.lastSeen,
      adsModel: adsModel ?? this.adsModel,
      addedByUser: addedByUser ?? this.addedByUser,
      followings: followings ?? this.followings,
      similarAds: similarAds ?? this.similarAds,
      trendSizes: trendSizes ?? this.trendSizes,
      trendAds: trendAds ?? this.trendAds,
      smallPage: smallPage ?? this.smallPage,
      verticalPage: verticalPage ?? this.verticalPage,
      bigPage: bigPage ?? this.bigPage,
      storeProducts: storeProducts ?? this.storeProducts,
      sectionAttributes: sectionAttributes ?? this.sectionAttributes,
      filterData: filterData ?? this.filterData,
      productsPage: productsPage ?? this.productsPage,
      followingStores: followingStores ?? this.followingStores,
      commercialAdsPage: commercialAdsPage ?? this.commercialAdsPage,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }
}
