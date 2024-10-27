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
import 'package:dealz/data/models/product_size_model.dart';
import 'package:dealz/data/models/size_model.dart';
import 'package:dealz/data/models/slider_model.dart';
import 'package:dealz/data/models/state_model.dart';
import 'package:dealz/data/models/store_details_model.dart';
import 'package:dealz/data/models/store_product_model.dart';
import 'package:dealz/data/models/trend_ads_model.dart';
import 'package:dealz/data/models/user.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/redux/home/home_action.dart';
import 'package:redux/redux.dart';

class HomeViewModel {
  final HomeModel? homeData;
  final UserModel? user;
  final MyStoreModel? storeDetails;
  final List<HomeProduct> storeProductList;
  final List<CategoryModel> sectionCategories;
  final List<HomeProduct> categoryProducts;
  final List<HomeProduct> sectionProducts;
  final List<DealsSectionModel> dealsSections;
  final List<StateModel> states;
  final List<CityModel> cities;
  final List<PackageModel> packages;
  final List<AddressModel> addresses;
  final List<CommercialStoreModel> commercialStore;
  final PageModel? pageModel;
  final List<MyAdsModel> myAds;
  final List<SliderModel> adsSliders;
  final List<DealsSectionModel> adsSections;
  final List<MyAdsModel> ordinaryAds;
  final List<MyAdsModel> adsBySection;
  final List<CommercialAdsModel> commercialAds;
  final List<MyAdsModel> mostWantedAds;
  final List<MyAdsModel> categoriesAds;
  final List<MessageModel> messages;
  final List<UserModel> chats;
  final List<MyAdsModel> wishlist;
  final List<MyAdsModel> userAds;
  final List<MyAdsModel> lastSeenAds;
  final List<MyAdsModel> similarAds;
  final List<FeatureModel> features;
  final MyAdsModel? singleAd;
  final UserModel? addedByUser;
  final List<UserModel> followingsUsers;
  final List<SizeModel> trendSizes;
  final List<Map<String, List<TrendAdsModel>>> trendsAds;
  final List<StoreProductModel> storeProducts;
  final List<SectionAttributesModel> sectionAttributes;
  final SortAndFilterModel? sortAndFilterModel;
  final List<MyStoreModel> followingStore;
  final List<ProductSizeModel> sizes;
  final List<ColorModel> colors;

  final Function(String) getHomeData;
  final Function(int) getStoreDetails;
  final Function(int) getStoreProductList;
  final Function(int) getSectionCategories;
  final Function(int) getSectionProductList;
  final Function(int) getCategoryProductList;
  final Function() getDealsSections;
  final Function() getStates;
  final Function(int) getCities;
  final Function(CreateStoreModel) createStore;
  final Function(CreateOrdinaryAdsModel) createOrdinaryAds;
  final Function() getPackages;
  final Function(CreateTrendAdsModel) createTrendAds;
  final Function(CreateCommercialAdsModel) createCommercialAds;
  final Function() getAddresses;
  final Function(AddressModel) createAddress;
  final Function(bool) getCommercialStores;
  final Function(String) getPageData;
  final Function() getMyAds;
  final Function() getSliderAds;
  final Function(String) getSectionAds;
  final Function() getOrdinaryAds;
  final Function(int) getAdsBySection;
  final Function(bool, [int?]) getCommercialAds;
  final Function(int, profileType) createContentView;
  final Function(UserModel) followUser;
  final Function(UserModel) unfollowUser;
  final Function(MyStoreModel) followStore;
  final Function(MyStoreModel) unfollowStore;
  final Function() getMostWantedAds;
  final Function(int) getCategoryAds;
  final Function(int, String) searchInAds;
  final Function(int, double) createRating;
  final Function(int) getChatMessage;
  final Function(int, String) sendMessage;
  final Function() getChats;
  final Function(MyAdsModel, String) createComment;
  final Function(MyAdsModel, CommentModel) deleteComment;
  final Function(CommentModel, String) updateComment;
  final Function(int) reportComment;
  final Function(int) reportProduct;
  final Function(String) getWishList;
  final Function(String, MyAdsModel) addWishList;
  final Function(String, MyAdsModel) removeWishList;
  final Function(int) getUserAds;
  final Function(int) getAdsFeatures;
  final Function() getLastSeen;
  final Function(int) postWhatsappClick;
  final Function(int) getAdById;
  final Function(int) getUserProfile;
  final Function() getFollowingsUsers;
  final Function(int) getSimilarAds;
  final Function() getTrendSizes;
  final Function(bool) getTrendsAds;
  final Function(MyAdsModel) updateAdsStatus;
  final Function(int, MyAdsModel, int) upgradeAds;
  final Function(int, StoreProductModel) addProductToStore;
  final Function(int, StoreProductModel) updateProductToStore;
  final Function(int, bool) getStoreProducts;
  final Function(int) getSectionAttributes;
  final Function(SortAndFilterModel) syncSortFilterData;
  final Function(int, CreateStoreModel) updateStore;
  final Function(int) deleteChat;
  final Function() getFollowingStores;
  final Function() getSizes;
  final Function() getColors;

  final ActionReport getHomeDataReport;
  final ActionReport getStoreDetailsReport;
  final ActionReport getStoreProductListReport;
  final ActionReport getSectionCategoriesReport;
  final ActionReport getSectionProductListReport;
  final ActionReport getCategoryProductListReport;
  final ActionReport getDealsSectionsReport;
  final ActionReport getStatesReport;
  final ActionReport getCitiesReport;
  final ActionReport createStoreReport;
  final ActionReport createOrdinaryAdsReport;
  final ActionReport getPackagesReport;
  final ActionReport createTrendAdsReport;
  final ActionReport createAddressesReport;
  final ActionReport getAddressesReport;
  final ActionReport getCommercialStoresReport;
  final ActionReport getPageModelReport;
  final ActionReport getMyAdsReport;
  final ActionReport getSliderAdsReport;
  final ActionReport getSectionAdsReport;
  final ActionReport getTrendAdsReport;
  final ActionReport getOrdinaryAdsReport;
  final ActionReport getAdsBySectionReport;
  final ActionReport getCommercialAdsReport;
  final ActionReport createContentViewReport;
  final ActionReport followUserReport;
  final ActionReport followStoreReport;
  final ActionReport getMostWantedAdsReport;
  final ActionReport getCategoryAdsReport;
  final ActionReport createRatingReport;
  final ActionReport sendMessageReport;
  final ActionReport getChatsReport;
  final ActionReport getChatMessagesReport;
  final ActionReport createCommentReport;
  final ActionReport getWishListReport;
  final ActionReport addWishListReport;
  final ActionReport getUserAdsReport;
  final ActionReport updateCommentReport;
  final ActionReport deleteCommentReport;
  final ActionReport reportCommentReport;
  final ActionReport getLastSeenReport;
  final ActionReport getAdByIdReport;
  final ActionReport getUserProfileReport;
  final ActionReport getFollowingsUsersReport;
  final ActionReport getSimilarAdsReport;
  final ActionReport getTrendSizesReport;
  final ActionReport getTrendsAdsReport;
  final ActionReport updateAdsReport;
  final ActionReport addProductToStoreReport;
  final ActionReport updateProductToStoreReport;
  final ActionReport getStoreProductsReport;
  final ActionReport getSectionAttributesReport;
  final ActionReport updateStoreReport;
  final ActionReport deleteChatReport;
  final ActionReport reportProductReport;
  final ActionReport getFollowingStoresReport;
  final ActionReport getColorsReport;
  final ActionReport getSizesReport;

  HomeViewModel({
    this.homeData,
    this.user,
    this.storeDetails,
    required this.getHomeData,
    required this.getHomeDataReport,
    required this.getStoreDetails,
    required this.getStoreDetailsReport,
    required this.getStoreProductList,
    required this.getStoreProductListReport,
    required this.storeProductList,
    required this.sectionCategories,
    required this.getSectionCategories,
    required this.getSectionCategoriesReport,
    required this.categoryProducts,
    required this.sectionProducts,
    required this.getSectionProductList,
    required this.getSectionProductListReport,
    required this.getCategoryProductList,
    required this.getCategoryProductListReport,
    required this.dealsSections,
    required this.getDealsSections,
    required this.getDealsSectionsReport,
    required this.states,
    required this.getStates,
    required this.getStatesReport,
    required this.cities,
    required this.getCities,
    required this.getCitiesReport,
    required this.createStore,
    required this.createStoreReport,
    required this.createOrdinaryAds,
    required this.createOrdinaryAdsReport,
    required this.packages,
    required this.getPackages,
    required this.getPackagesReport,
    required this.createTrendAds,
    required this.createTrendAdsReport,
    required this.createCommercialAds,
    required this.createAddressesReport,
    required this.addresses,
    required this.getAddresses,
    required this.createAddress,
    required this.getAddressesReport,
    required this.commercialStore,
    required this.getCommercialStores,
    required this.getCommercialStoresReport,
    this.pageModel,
    required this.getPageData,
    required this.getPageModelReport,
    required this.myAds,
    required this.getMyAds,
    required this.getMyAdsReport,
    required this.adsSliders,
    required this.adsSections,
    required this.getSliderAds,
    required this.getSliderAdsReport,
    required this.getSectionAds,
    required this.getSectionAdsReport,
    required this.ordinaryAds,
    required this.getTrendAdsReport,
    required this.getOrdinaryAds,
    required this.getOrdinaryAdsReport,
    required this.adsBySection,
    required this.getAdsBySection,
    required this.getAdsBySectionReport,
    required this.commercialAds,
    required this.getCommercialAds,
    required this.getCommercialAdsReport,
    required this.createContentView,
    required this.createContentViewReport,
    required this.followUser,
    required this.followUserReport,
    required this.unfollowUser,
    required this.mostWantedAds,
    required this.getMostWantedAds,
    required this.getMostWantedAdsReport,
    required this.categoriesAds,
    required this.getCategoryAds,
    required this.getCategoryAdsReport,
    required this.searchInAds,
    required this.createRating,
    required this.createRatingReport,
    required this.getChatMessage,
    required this.getChats,
    required this.messages,
    required this.chats,
    required this.getChatMessagesReport,
    required this.getChatsReport,
    required this.sendMessage,
    required this.sendMessageReport,
    required this.createComment,
    required this.createCommentReport,
    required this.getWishList,
    required this.addWishList,
    required this.removeWishList,
    required this.addWishListReport,
    required this.getWishListReport,
    required this.wishlist,
    required this.getUserAds,
    required this.getUserAdsReport,
    required this.userAds,
    required this.reportComment,
    required this.reportCommentReport,
    required this.updateComment,
    required this.deleteComment,
    required this.deleteCommentReport,
    required this.updateCommentReport,
    required this.features,
    required this.getAdsFeatures,
    required this.lastSeenAds,
    required this.getLastSeen,
    required this.getLastSeenReport,
    required this.postWhatsappClick,
    this.singleAd,
    required this.getAdById,
    required this.getAdByIdReport,
    this.addedByUser,
    required this.getUserProfile,
    required this.getUserProfileReport,
    required this.getFollowingsUsers,
    required this.getFollowingsUsersReport,
    required this.followingsUsers,
    required this.getSimilarAds,
    required this.getSimilarAdsReport,
    required this.similarAds,
    required this.getTrendSizes,
    required this.getTrendSizesReport,
    required this.trendSizes,
    required this.trendsAds,
    required this.getTrendsAds,
    required this.getTrendsAdsReport,
    required this.updateAdsStatus,
    required this.upgradeAds,
    required this.updateAdsReport,
    required this.addProductToStore,
    required this.addProductToStoreReport,
    required this.getStoreProducts,
    required this.getStoreProductsReport,
    required this.storeProducts,
    required this.getSectionAttributes,
    required this.getSectionAttributesReport,
    required this.sectionAttributes,
    this.sortAndFilterModel,
    required this.syncSortFilterData,
    required this.updateProductToStoreReport,
    required this.updateProductToStore,
    required this.updateStore,
    required this.updateStoreReport,
    required this.deleteChat,
    required this.deleteChatReport,
    required this.reportProduct,
    required this.reportProductReport,
    required this.followStore,
    required this.followStoreReport,
    required this.unfollowStore,
    required this.getFollowingStores,
    required this.getFollowingStoresReport,
    required this.followingStore,
    required this.sizes,
    required this.colors,
    required this.getSizes,
    required this.getColors,
    required this.getColorsReport,
    required this.getSizesReport,
  });

  static HomeViewModel fromStore(Store<AppState> store) {
    return HomeViewModel(
      homeData: store.state.homeState.homeData,
      user: store.state.authState.user,
      storeDetails: store.state.homeState.storeDetails,
      storeProductList: store.state.homeState.storeProductList.values.toList(),
      sectionCategories: store.state.homeState.sectionCategories.values.toList(),
      categoryProducts: store.state.homeState.categoryProducts.values.toList(),
      sectionProducts: store.state.homeState.sectionProducts.values.toList(),
      dealsSections: store.state.homeState.dealsSections.values.toList(),
      states: store.state.homeState.states.values.toList(),
      cities: store.state.homeState.cities.values.toList(),
      packages: store.state.homeState.packages.values.toList(),
      addresses: store.state.homeState.addresses.values.toList(),
      commercialStore: store.state.homeState.commercialStore.values.toList(),
      pageModel: store.state.homeState.pageModel,
      myAds: store.state.homeState.myAds.values.toList(),
      adsSliders: store.state.homeState.adsSliders.values.toList(),
      adsSections: store.state.homeState.adsSections.values.toList(),
      ordinaryAds: store.state.homeState.ordinaryAds.values.toList(),
      adsBySection: store.state.homeState.adsBySection.values.toList(),
      commercialAds: store.state.homeState.commercialAds.values.toList(),
      mostWantedAds: store.state.homeState.mostWantedAds.values.toList(),
      categoriesAds: store.state.homeState.categoriesAds.values.toList(),
      chats: store.state.homeState.chats.values.toList(),
      messages: store.state.homeState.messages.values.toList(),
      wishlist: store.state.homeState.wishList.values.toList(),
      userAds: store.state.homeState.userAds.values.toList(),
      features: store.state.homeState.features.values.toList(),
      lastSeenAds: store.state.homeState.lastSeen.values.toList(),
      singleAd: store.state.homeState.adsModel,
      addedByUser: store.state.homeState.addedByUser,
      followingsUsers: store.state.homeState.followings.values.toList(),
      similarAds: store.state.homeState.similarAds.values.toList(),
      trendSizes: store.state.homeState.trendSizes.values.toList(),
      trendsAds: store.state.homeState.trendAds.values.toList(),
      storeProducts: store.state.homeState.storeProducts.values.toList(),
      sectionAttributes: store.state.homeState.sectionAttributes.values.toList(),
      sortAndFilterModel: store.state.homeState.filterData,
      followingStore: store.state.homeState.followingStores.values.toList(),
      sizes: store.state.homeState.sizes.values.toList(),
      colors: store.state.homeState.colors.values.toList(),
      getSectionProductList: (sectionId) {
        store.dispatch(GetSectionProductsAction(sectionId: sectionId));
      },
      getCategoryProductList: (categoryId) {
        store.dispatch(GetCategoryProductsAction(categoryId: categoryId));
      },
      getHomeData: (homeType) {
        store.dispatch(GetHomeDataAction(homeType));
      },
      getStoreDetails: (id) {
        store.dispatch(GetStoreDetailsAction(id: id));
      },
      getStoreProductList: (id) {
        store.dispatch(GetStoreProductListAction(id: id));
      },
      getSectionCategories: (sectionId) {
        store.dispatch(GetSectionCategoriesAction(sectionId: sectionId));
      },
      getDealsSections: () {
        store.dispatch(GetSectionsAction());
      },
      getStates: () {
        store.dispatch(GetStatesAction());
      },
      getCities: (stateId) {
        store.dispatch(GetCitiesAction(stateId: stateId));
      },
      createStore: (createStoreModel) {
        store.dispatch(CreateCommercialStoreAction(createStoreModel: createStoreModel));
      },
      createOrdinaryAds: (createOrdinaryAdsModel) {
        store.dispatch(CreateOrdinaryAdsAction(createOrdinaryAdsModel: createOrdinaryAdsModel));
      },
      getPackages: () {
        store.dispatch(GetPackagesAction());
      },
      createTrendAds: (createTrendAdsModel) {
        store.dispatch(CreateTrendAdsAction(createTrendAdsModel: createTrendAdsModel));
      },
      createCommercialAds: (createCommercialAdsModel) {
        store.dispatch(CreateCommercialAdsAction(createCommercialAdsModel: createCommercialAdsModel));
      },
      getAddresses: () {
        store.dispatch(GetAddressAction());
      },
      createAddress: (addressModel) {
        store.dispatch(CreateAddressAction(addressModel: addressModel));
      },
      getCommercialStores: (isActive) {
        store.dispatch(GetCommercialStoresAction(isActive));
      },
      getPageData: (pageName) {
        store.dispatch(GetPageDataAction(identifier: pageName));
      },
      getMyAds: () {
        store.dispatch(GetMyAdsAction());
      },
      getSliderAds: () {
        store.dispatch(GetAdsSliderAction());
      },
      getSectionAds: (type) {
        store.dispatch(GetAdsSectionsAction(type));
      },
      getOrdinaryAds: () {
        store.dispatch(GetOrdinaryAdsAction());
      },
      getAdsBySection: (sectionId) {
        store.dispatch(GetAdsBySectionAction(sectionId: sectionId));
      },
      getCommercialAds: (pagination, [sectionId]) {
        store.dispatch(GetCommercialAdsAction(pagination: pagination, sectionId: sectionId));
      },
      createContentView: (id, profileType) {
        store.dispatch(CreateContentViewAction(type: profileType, contentId: id));
      },
      followUser: (user) {
        store.dispatch(FollowUserAction(user: user));
      },
      unfollowUser: (user) {
        store.dispatch(UnFollowUserAction(user: user));
      },
      getMostWantedAds: () {
        store.dispatch(GetMostWatchedAdsAction());
      },
      getCategoryAds: (categoryId) {
        store.dispatch(GetAdsCategoriesAction(categoryId));
      },
      searchInAds: (categoryId, search) {
        store.dispatch(SearchInAdsCategoriesAction(categoryId, search));
      },
      createRating: (contentId, rating) {
        store.dispatch(CreateRatingAction(
          contentId: contentId,
          rating: rating,
        ));
      },
      sendMessage: (id, message) {
        store.dispatch(SendMessageAction(userId: id, message: message));
      },
      getChatMessage: (chatId) {
        store.dispatch(GetChatMessagesAction(chatId: chatId));
      },
      getChats: () {
        store.dispatch(GetChatsAction());
      },
      createComment: (content, comment) {
        store.dispatch(CreateCommentAction(content: content, comment: comment));
      },
      getWishList: (type) {
        store.dispatch(GetWishListAction(type: type));
      },
      addWishList: (type, adsModel) {
        store.dispatch(AddToWishListAction(type: type, myAdsModel: adsModel));
      },
      removeWishList: (type, adsModel) {
        store.dispatch(DeleteFromWishListAction(type: type, myAdsModel: adsModel));
      },
      getUserAds: (userId) {
        store.dispatch(GetUserAdsAction(userId));
      },
      reportComment: (id) {
        store.dispatch(ReportCommentAction(commentId: id));
      },
      updateComment: (comment, text) {
        store.dispatch(UpdateCommentAction(comment: comment, commentText: text));
      },
      deleteComment: (ads, comment) {
        store.dispatch(DeleteCommentAction(comment: comment, adsModel: ads));
      },
      getAdsFeatures: (sectionId) {
        store.dispatch(GetAdsFeaturesAction(sectionId));
      },
      getLastSeen: () {
        store.dispatch(GetLastSeenAction());
      },
      postWhatsappClick: (adsId) {
        store.dispatch(PostWhatsappClicksAction(adsId));
      },
      getAdById: (adsId) {
        store.dispatch(GetAdsByIdAction(adsId));
      },
      getUserProfile: (userId) {
        store.dispatch(GetUserProfileAction(userId));
      },
      getFollowingsUsers: () {
        store.dispatch(GetFollowingsAction());
      },
      getSimilarAds: (id) {
        store.dispatch(GetSimilarAdsAction(id));
      },
      getTrendSizes: () {
        store.dispatch(GetTrendSizesAction());
      },
      getTrendsAds: (isPagination) {
        store.dispatch(GetTrendVerticalAdsAction(isPagination));
        store.dispatch(GetTrendBigAdsAction(isPagination));
      },
      updateAdsStatus: (ads) {
        store.dispatch(UpdateAdsStatusAction(ads));
      },
      upgradeAds: (packageId, ads, packageDays) {
        store.dispatch(UpgradeAdsAction(
          packageDays: packageDays,
          packageId: packageId,
          adsModel: ads,
        ));
      },
      addProductToStore: (storeId, product) {
        store.dispatch(AddProductToStoreAction(storeId: storeId, productModel: product));
      },
      getStoreProducts: (storeId, pagination) {
        store.dispatch(GetStoreProductsAction(storeId: storeId, pagination: pagination));
      },
      getSectionAttributes: (sectionId) {
        store.dispatch(GetSectionAttributesAction(sectionId));
      },
      syncSortFilterData: (filterData) {
        store.dispatch(SyncFilterDataAction(filterData));
      },
      updateProductToStore: (storeId, product) {
        store.dispatch(UpdateProductToStoreAction(storeId: storeId, productModel: product));
      },
      updateStore: (storeId, storeModel) {
        store.dispatch(UpdateCommercialStoreAction(createStoreModel: storeModel, storeId: storeId));
      },
      deleteChat: (chatId) {
        store.dispatch(DeleteChatAction(chatId));
      },
      reportProduct: (productId) {
        store.dispatch(ReportProductAction(productId));
      },
      followStore: (storeDetails) {
        store.dispatch(FollowStoreAction(storeDetails));
      },
      unfollowStore: (storeDetails) {
        store.dispatch(UnFollowStoreAction(storeDetails));
      },
      getFollowingStores: () {
        store.dispatch(GetFollowingStoresAction());
      },
      getSizes: () {
        store.dispatch(GetSizesAction());
      },
      getColors: () {
        store.dispatch(GetColorsAction());
      },
      getSizesReport: store.state.homeState.status['GetSizesAction'] ?? ActionReport(),
      getColorsReport: store.state.homeState.status['GetColorsAction'] ?? ActionReport(),
      getFollowingStoresReport: store.state.homeState.status['GetFollowingStoresAction'] ?? ActionReport(),
      followStoreReport: store.state.homeState.status['FollowStoreAction'] ?? ActionReport(),
      reportProductReport: store.state.homeState.status['ReportProductAction'] ?? ActionReport(),
      deleteChatReport: store.state.homeState.status['DeleteChatAction'] ?? ActionReport(),
      updateStoreReport: store.state.homeState.status['UpdateCommercialStoreAction'] ?? ActionReport(),
      updateProductToStoreReport: store.state.homeState.status['UpdateProductToStoreAction'] ?? ActionReport(),
      getSectionAttributesReport: store.state.homeState.status['GetSectionAttributesAction'] ?? ActionReport(),
      getStoreProductsReport: store.state.homeState.status['GetStoreProductsAction'] ?? ActionReport(),
      addProductToStoreReport: store.state.homeState.status['AddProductToStoreAction'] ?? ActionReport(),
      updateAdsReport: store.state.homeState.status['UpdateAdsStatusAction'] ?? ActionReport(),
      getTrendsAdsReport: store.state.homeState.status['GetTrendAdsAction'] ?? ActionReport(),
      getTrendSizesReport: store.state.homeState.status['GetTrendSizesAction'] ?? ActionReport(),
      getSimilarAdsReport: store.state.homeState.status['GetSimilarAdsAction'] ?? ActionReport(),
      getFollowingsUsersReport: store.state.homeState.status['GetFollowingsAction'] ?? ActionReport(),
      getUserProfileReport: store.state.homeState.status['GetUserProfileAction'] ?? ActionReport(),
      getAdByIdReport: store.state.homeState.status['GetAdsByIdAction'] ?? ActionReport(),
      getLastSeenReport: store.state.homeState.status['GetLastSeenAction'] ?? ActionReport(),
      reportCommentReport: store.state.homeState.status['ReportCommentAction'] ?? ActionReport(),
      updateCommentReport: store.state.homeState.status['UpdateCommentAction'] ?? ActionReport(),
      deleteCommentReport: store.state.homeState.status['DeleteCommentAction'] ?? ActionReport(),
      getUserAdsReport: store.state.homeState.status['GetUserAdsAction'] ?? ActionReport(),
      getWishListReport: store.state.homeState.status['GetWishListAction'] ?? ActionReport(),
      addWishListReport: store.state.homeState.status['AddToWishListAction'] ?? ActionReport(),
      createCommentReport: store.state.homeState.status['CreateCommentAction'] ?? ActionReport(),
      sendMessageReport: store.state.homeState.status['SendMessageAction'] ?? ActionReport(),
      getChatsReport: store.state.homeState.status['GetChatsAction'] ?? ActionReport(),
      getChatMessagesReport: store.state.homeState.status['GetChatMessagesAction'] ?? ActionReport(),
      createRatingReport: store.state.homeState.status['CreateRatingAction'] ?? ActionReport(),
      getCategoryAdsReport: store.state.homeState.status['GetAdsCategoriesAction'] ?? ActionReport(),
      getMostWantedAdsReport: store.state.homeState.status['GetMostWatchedAdsAction'] ?? ActionReport(),
      followUserReport: store.state.homeState.status['FollowUserAction'] ?? ActionReport(),
      createContentViewReport: store.state.homeState.status['CreateContentViewAction'] ?? ActionReport(),
      getCommercialAdsReport: store.state.homeState.status['GetCommercialAdsAction'] ?? ActionReport(),
      getAdsBySectionReport: store.state.homeState.status['GetAdsBySectionAction'] ?? ActionReport(),
      getTrendAdsReport: store.state.homeState.status['GetTrendAdsAction'] ?? ActionReport(),
      getOrdinaryAdsReport: store.state.homeState.status['GetOrdinaryAdsAction'] ?? ActionReport(),
      getSectionAdsReport: store.state.homeState.status['GetAdsSectionsAction'] ?? ActionReport(),
      getSliderAdsReport: store.state.homeState.status['GetAdsSliderAction'] ?? ActionReport(),
      getMyAdsReport: store.state.homeState.status['GetMyAdsAction'] ?? ActionReport(),
      getPageModelReport: store.state.homeState.status['GetPageDataAction'] ?? ActionReport(),
      getCommercialStoresReport: store.state.homeState.status['GetCommercialStoresAction'] ?? ActionReport(),
      getAddressesReport: store.state.homeState.status['GetAddressAction'] ?? ActionReport(),
      createAddressesReport: store.state.homeState.status['CreateAddressAction'] ?? ActionReport(),
      createTrendAdsReport: store.state.homeState.status['CreateTrendAdsAction'] ?? ActionReport(),
      getPackagesReport: store.state.homeState.status['GetPackagesAction'] ?? ActionReport(),
      createOrdinaryAdsReport: store.state.homeState.status['CreateOrdinaryAdsAction'] ?? ActionReport(),
      createStoreReport: store.state.homeState.status['CreateCommercialStoreAction'] ?? ActionReport(),
      getCitiesReport: store.state.homeState.status['GetCitiesAction'] ?? ActionReport(),
      getStatesReport: store.state.homeState.status['GetStatesAction'] ?? ActionReport(),
      getDealsSectionsReport: store.state.homeState.status['GetSectionsAction'] ?? ActionReport(),
      getStoreProductListReport: store.state.homeState.status['GetStoreProductListAction'] ?? ActionReport(),
      getHomeDataReport: store.state.homeState.status['GetHomeDataAction'] ?? ActionReport(),
      getStoreDetailsReport: store.state.homeState.status['GetStoreDetailsAction'] ?? ActionReport(),
      getSectionCategoriesReport: store.state.homeState.status['GetSectionCategoriesAction'] ?? ActionReport(),
      getSectionProductListReport: store.state.homeState.status['GetSectionProductsAction'] ?? ActionReport(),
      getCategoryProductListReport: store.state.homeState.status['GetCategoryProductsAction'] ?? ActionReport(),
    );
  }
}
