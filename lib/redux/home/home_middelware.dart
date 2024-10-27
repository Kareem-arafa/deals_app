import 'package:dealz/data/models/comment_model.dart';
import 'package:dealz/data/models/my_ads_model.dart';
import 'package:dealz/data/models/pagination_model.dart';
import 'package:dealz/data/repository/home_repository.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/redux/home/home_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createHomeMiddleware([
  HomeRepository _repository = const HomeRepository(),
]) {
  final getHomeData = _getHomeData(_repository);
  final getStoreDetails = _getStoreDetails(_repository);
  final getStoreProductList = _getStoreProductList(_repository);
  final getSectionCategories = _getSectionCategories(_repository);
  final getSectionProductList = _getSectionProductList(_repository);
  final getCategoryProductList = _getCategoryProductList(_repository);
  final createCommercialStore = _createCommercialStore(_repository);
  final getDealsSections = _getDealsSections(_repository);
  final getStates = _getStates(_repository);
  final getCities = _getCities(_repository);
  final createOrdinaryAds = _createOrdinaryAds(_repository);
  final getPackages = _getPackages(_repository);
  final createTrendAds = _createTrendAds(_repository);
  final createCommercialAds = _createCommercialAds(_repository);
  final getAddress = _getAddress(_repository);
  final createAddress = _createAddress(_repository);
  final getCommercialStore = _getCommercialStore(_repository);
  final getPageDate = _getPageData(_repository);
  final getMyAds = _getMyAds(_repository);
  final getAdsSliders = _getAdsSliders(_repository);
  final getAdsSections = _getAdsSections(_repository);
  final getOrdinaryAds = _getOrdinaryAds(_repository);
  final getAdsBySection = _getAdsBySection(_repository);
  final getCommercialAds = _getCommercialAds(_repository);
  final createContentView = _createContentView(_repository);
  final followUser = _followUser(_repository);
  final unFollowUser = _unFollowUser(_repository);
  final mostWatchedAds = _mostWatchedAds(_repository);
  final getCategoriesAds = _getCategoriesAds(_repository);
  final searchInAds = _searchInAds(_repository);
  final createRating = _createRating(_repository);
  final sendMessage = _sendMessage(_repository);
  final getMessages = _getMessages(_repository);
  final getChats = _getChats(_repository);
  final createComment = _createComment(_repository);
  final getWishList = _getWishList(_repository);
  final addWishList = _addWishList(_repository);
  final deleteWishList = _deleteWishList(_repository);
  final userAds = _userAds(_repository);
  final deleteComment = _deleteComment(_repository);
  final reportComment = _reportComment(_repository);
  final updateComment = _updateComment(_repository);
  final getAdsFeatures = _getAdsFeatures(_repository);
  final getLastSeen = _getLastSeen(_repository);
  final postWhatsappClick = _postWhatsappClick(_repository);
  final getAdById = _getAdById(_repository);
  final getUserProfile = _getUserProfile(_repository);
  final getFollowingsUsers = _getFollowingsUsers(_repository);
  final getSimilarAds = _getSimilarAds(_repository);
  final getTrendSizes = _getTrendSizes(_repository);
  final getVerticalTrendAds = _getVerticalTrendAds(_repository);
  final getSmallTrendAds = _getSmallTrendAds(_repository);
  final getBigTrendAds = _getBigTrendAds(_repository);
  final updateAdsStatus = _updateAdsStatus(_repository);
  final upgradeAds = _upgradeAds(_repository);
  final addProductToStore = _addProductToStore(_repository);
  final getStoreProducts = _getStoreProducts(_repository);
  final getSectionAttributes = _getSectionAttributes(_repository);
  final updateStoreProduct = _updateStoreProduct(_repository);
  final updateCommercialStore = _updateCommercialStore(_repository);
  final deleteChatAction = _deleteChatAction(_repository);
  final reportProduct = _reportProduct(_repository);
  final followStore = _followStore(_repository);
  final unFollowStore = _unFollowStore(_repository);
  final getFollowingStores = _getFollowingStores(_repository);
  final getColors = _getColors(_repository);
  final getSizes = _getSizes(_repository);

  return [
    TypedMiddleware<AppState, GetHomeDataAction>(getHomeData),
    TypedMiddleware<AppState, GetStoreDetailsAction>(getStoreDetails),
    TypedMiddleware<AppState, GetStoreProductListAction>(getStoreProductList),
    TypedMiddleware<AppState, GetSectionCategoriesAction>(getSectionCategories),
    TypedMiddleware<AppState, GetSectionProductsAction>(getSectionProductList),
    TypedMiddleware<AppState, GetCategoryProductsAction>(getCategoryProductList),
    TypedMiddleware<AppState, CreateCommercialStoreAction>(createCommercialStore),
    TypedMiddleware<AppState, GetSectionsAction>(getDealsSections),
    TypedMiddleware<AppState, GetStatesAction>(getStates),
    TypedMiddleware<AppState, GetCitiesAction>(getCities),
    TypedMiddleware<AppState, CreateOrdinaryAdsAction>(createOrdinaryAds),
    TypedMiddleware<AppState, GetPackagesAction>(getPackages),
    TypedMiddleware<AppState, CreateTrendAdsAction>(createTrendAds),
    TypedMiddleware<AppState, CreateCommercialAdsAction>(createCommercialAds),
    TypedMiddleware<AppState, GetAddressAction>(getAddress),
    TypedMiddleware<AppState, CreateAddressAction>(createAddress),
    TypedMiddleware<AppState, GetCommercialStoresAction>(getCommercialStore),
    TypedMiddleware<AppState, GetPageDataAction>(getPageDate),
    TypedMiddleware<AppState, GetMyAdsAction>(getMyAds),
    TypedMiddleware<AppState, GetAdsSliderAction>(getAdsSliders),
    TypedMiddleware<AppState, GetAdsSectionsAction>(getAdsSections),
    TypedMiddleware<AppState, GetOrdinaryAdsAction>(getOrdinaryAds),
    TypedMiddleware<AppState, GetAdsBySectionAction>(getAdsBySection),
    TypedMiddleware<AppState, GetCommercialAdsAction>(getCommercialAds),
    TypedMiddleware<AppState, CreateContentViewAction>(createContentView),
    TypedMiddleware<AppState, FollowUserAction>(followUser),
    TypedMiddleware<AppState, UnFollowUserAction>(unFollowUser),
    TypedMiddleware<AppState, GetMostWatchedAdsAction>(mostWatchedAds),
    TypedMiddleware<AppState, GetAdsCategoriesAction>(getCategoriesAds),
    TypedMiddleware<AppState, SearchInAdsCategoriesAction>(searchInAds),
    TypedMiddleware<AppState, CreateRatingAction>(createRating),
    TypedMiddleware<AppState, SendMessageAction>(sendMessage),
    TypedMiddleware<AppState, GetChatsAction>(getChats),
    TypedMiddleware<AppState, GetChatMessagesAction>(getMessages),
    TypedMiddleware<AppState, CreateCommentAction>(createComment),
    TypedMiddleware<AppState, GetWishListAction>(getWishList),
    TypedMiddleware<AppState, AddToWishListAction>(addWishList),
    TypedMiddleware<AppState, DeleteFromWishListAction>(deleteWishList),
    TypedMiddleware<AppState, GetUserAdsAction>(userAds),
    TypedMiddleware<AppState, UpdateCommentAction>(updateComment),
    TypedMiddleware<AppState, ReportCommentAction>(reportComment),
    TypedMiddleware<AppState, DeleteCommentAction>(deleteComment),
    TypedMiddleware<AppState, GetAdsFeaturesAction>(getAdsFeatures),
    TypedMiddleware<AppState, GetLastSeenAction>(getLastSeen),
    TypedMiddleware<AppState, PostWhatsappClicksAction>(postWhatsappClick),
    TypedMiddleware<AppState, GetAdsByIdAction>(getAdById),
    TypedMiddleware<AppState, GetUserProfileAction>(getUserProfile),
    TypedMiddleware<AppState, GetFollowingsAction>(getFollowingsUsers),
    TypedMiddleware<AppState, GetSimilarAdsAction>(getSimilarAds),
    TypedMiddleware<AppState, GetTrendSizesAction>(getTrendSizes),
    TypedMiddleware<AppState, GetTrendSmallAdsAction>(getSmallTrendAds),
    TypedMiddleware<AppState, GetTrendBigAdsAction>(getBigTrendAds),
    TypedMiddleware<AppState, GetTrendVerticalAdsAction>(getVerticalTrendAds),
    TypedMiddleware<AppState, UpdateAdsStatusAction>(updateAdsStatus),
    TypedMiddleware<AppState, UpgradeAdsAction>(upgradeAds),
    TypedMiddleware<AppState, AddProductToStoreAction>(addProductToStore),
    TypedMiddleware<AppState, GetStoreProductsAction>(getStoreProducts),
    TypedMiddleware<AppState, GetSectionAttributesAction>(getSectionAttributes),
    TypedMiddleware<AppState, UpdateProductToStoreAction>(updateStoreProduct),
    TypedMiddleware<AppState, UpdateCommercialStoreAction>(updateCommercialStore),
    TypedMiddleware<AppState, DeleteChatAction>(deleteChatAction),
    TypedMiddleware<AppState, ReportProductAction>(reportProduct),
    TypedMiddleware<AppState, FollowStoreAction>(followStore),
    TypedMiddleware<AppState, UnFollowStoreAction>(unFollowStore),
    TypedMiddleware<AppState, GetFollowingStoresAction>(getFollowingStores),
    TypedMiddleware<AppState, GetSizesAction>(getSizes),
    TypedMiddleware<AppState, GetColorsAction>(getColors),
  ];
}

Middleware<AppState> _getHomeData(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.homeData = null;
    repository.getHomeData(action.homeType).then((homeData) {
      next(SyncHomeDataAction(homeModel: homeData));
      completed(next, action);
    })/*.catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    })*/;
  };
}

Middleware<AppState> _getStoreDetails(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.myStoreDetailsById(action.id).then((storeDetails) {
      next(SyncStoreDetailsAction(storeDetails: storeDetails));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getStoreProductList(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    store.state.homeState.storeProductList.clear();
    running(next, action);
    repository.getStoreProductList(action.id).then((storeProductList) {
      next(SyncStoreProductListAction(storeProductList: storeProductList));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getSectionCategories(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    store.state.homeState.sectionCategories.clear();
    running(next, action);
    repository.getSectionCategories(action.sectionId).then((sectionCategories) {
      next(SyncSectionCategoriesAction(sectionCategories: sectionCategories));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getSectionProductList(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    store.state.homeState.sectionProducts.clear();
    running(next, action);
    repository.getSectionProducts(action.sectionId).then((products) {
      next(SyncSectionProductsAction(sectionProducts: products));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getCategoryProductList(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    store.state.homeState.categoryProducts.clear();
    running(next, action);
    repository.getCategoryProducts(action.categoryId).then((products) {
      next(SyncCategoryProductsAction(categoryProducts: products));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _createCommercialStore(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.createCommercialStore(action.createStoreModel).then((products) {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getDealsSections(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.dealsSections.clear();
    repository.getDealsSection().then((sections) {
      next(SyncSectionsAction(sections: sections));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getStates(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.states.clear();
    repository.getStates().then((states) {
      next(SyncStatesAction(states: states));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getCities(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.cities.clear();
    repository.getStateCities(action.stateId).then((cities) {
      next(SyncCitiesAction(cities: cities));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _createOrdinaryAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.createOrdinaryAds(action.createOrdinaryAdsModel).then((cities) {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getPackages(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.packages.clear();
    repository.getDealsPackages().then((packages) {
      next(SyncPackagesAction(packages: packages));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _createTrendAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.createTrendAds(action.createTrendAdsModel).then((packages) {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _createCommercialAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.createCommercialAds(action.createCommercialAdsModel).then((packages) {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getAddress(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.addresses.clear();
    repository.getUserAddresses().then((addresses) {
      next(SyncAddressAction(addresses: addresses));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _createAddress(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.createAddress(action.addressModel).then((addresses) {
      next(GetAddressAction());
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getCommercialStore(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.commercialStore.clear();
    repository.getCommercialStores(action.isActive).then((stores) {
      next(SyncCommercialStoresAction(commercialStores: stores));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getPageData(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.pageModel = null;
    repository.getPageData(action.identifier).then((page) {
      next(SyncPageDataAction(pageData: page));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getMyAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.myAds.clear();
    repository.getMyAds().then((ads) {
      next(SyncMyAdsAction(myAds: ads));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getAdsSliders(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.adsSliders.clear();
    repository.getAdsSlider().then((sliders) {
      next(SyncAdsSliderAction(adsSlider: sliders));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getAdsSections(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.adsSections.clear();
    repository.getAdsSections(action.type).then((sections) {
      next(SyncAdsSectionsAction(adsSections: sections));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getOrdinaryAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.ordinaryAds.clear();
    repository.getOrdinaryAds().then((ads) {
      next(SyncOrdinaryAdsAction(ordinaryAds: ads));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getAdsBySection(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.adsBySection.clear();
    repository.getAdsById(action.sectionId, store.state.homeState.filterData).then((ads) {
      next(SyncAdsBySectionAction(adsBySection: ads));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getCommercialAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    PaginationModel page;
    if (action.pagination) {
      if (store.state.homeState.commercialAdsPage!.isLastPage) return;
      page = store.state.homeState.commercialAdsPage!;
      page.currentPage = page.currentPage! + 1;
      running(next, action);
    } else {
      running(next, action);
      store.state.homeState.commercialAds.clear();
      page = PaginationModel(currentPage: 1, total: 1);
    }
    repository.getCommercialAds(page: page.currentPage ?? 1, sectionId: action.sectionId).then((ads) {
      next(SyncCommercialAdsAction(commercialAds: ads.second, adPage: ads.first));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _createContentView(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.createContentView(action.contentId, action.type).then((data) {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _followUser(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    final user = (action as FollowUserAction).user;
    repository.createUserFollow(user.id!).then((data) {
      completed(next, action);
      user.isFollowing = true;
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _unFollowUser(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    final user = (action as UnFollowUserAction).user;
    repository.createUserUnFollow(user.id!).then((data) {
      completed(next, action);
      user.isFollowing = false;
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _followStore(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    final storeDetails = (action as FollowStoreAction).storeDetails;
    repository.createStoreFollow(storeDetails.id!).then((data) {
      completed(next, action);
      storeDetails.isFollowing = true;
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _unFollowStore(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    final storeDetails = (action as UnFollowStoreAction).storeDetails;
    repository.createStoreUnFollow(storeDetails.id!).then((data) {
      completed(next, action);
      storeDetails.isFollowing = false;
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _mostWatchedAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.mostWantedAds.clear();
    repository.getMostWatchedAds().then((ads) {
      next(SyncMostWatchedAdsAction(mostWantedAds: ads));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getCategoriesAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.categoriesAds.clear();
    repository.getCategoryAds(action.categoryId).then((ads) {
      next(SyncAdsCategoriesAction(ads: ads));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _searchInAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.categoriesAds.clear();
    repository.searchInCategoryAds(action.categoryId, action.search).then((ads) {
      next(SyncAdsCategoriesAction(ads: ads));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _createRating(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.createRating(action.contentId, action.rating).then((ads) {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getChats(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.chats.clear();
    repository.getChats().then((chats) {
      next(SyncChatsAction(chats));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _sendMessage(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.sendMessage(action.userId, action.message).then((chats) {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getMessages(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.messages.clear();
    repository.getChatMessage(action.chatId).then((messages) {
      next(SyncChatMessagesAction(messages: messages));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _createComment(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    MyAdsModel product = (action as CreateCommentAction).content;
    repository.postComment(action.content, action.comment).then((messages) {
      product.comments?.add(messages);
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _updateComment(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    CommentModel comment = (action as UpdateCommentAction).comment;
    repository.updateComment(comment, action.commentText).then((messages) {
      comment.comment = action.commentText;
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getWishList(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.wishList.clear();
    repository.getWishList(action.type).then((wishList) {
      next(SyncWishListAction(wishlist: wishList));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _addWishList(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    MyAdsModel ads = (action as AddToWishListAction).myAdsModel;
    repository.addWishList(action.type, action.myAdsModel.id!).then((wishList) {
      ads.inWishlist = !(ads.inWishlist ?? false);
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _deleteWishList(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    MyAdsModel ads = (action as DeleteFromWishListAction).myAdsModel;
    repository.removeWishList(action.type, action.myAdsModel.id!).then((wishList) {
      ads.inWishlist = !(ads.inWishlist ?? false);
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _userAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.userAds.clear();
    repository.getUserAds(action.userId).then((ads) {
      next(SyncUserAdsAction(ads));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _deleteComment(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    MyAdsModel adsModel = (action as DeleteCommentAction).adsModel;
    repository.deleteComment(action.comment.id!).then((ads) {
      adsModel.comments?.remove(action.comment);
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _reportComment(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.reportComment(action.commentId).then((ads) {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getAdsFeatures(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.getAdsFeatures(action.sectionId).then((features) {
      completed(next, action);
      next(SyncAdsFeaturesAction(features));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getLastSeen(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.lastSeen.clear();
    repository.gatLastSeen().then((ads) {
      completed(next, action);
      next(SyncLastSeenAction(ads));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _postWhatsappClick(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.postWhatsAppClick(action.adsId).then((ads) {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getAdById(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.adsModel = null;
    repository.GetAdvertisementById(action.adsId).then((myAdsModel) {
      completed(next, action);
      next(SyncAdsByIdAction(myAdsModel));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getUserProfile(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.addedByUser = null;
    repository.getUserProfile(action.userId).then((user) {
      completed(next, action);
      next(SyncUserProfileAction(user));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getFollowingsUsers(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.followings.clear();
    repository.GetUserFollowings().then((followings) {
      completed(next, action);
      next(SyncFollowingsAction(followings));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getSimilarAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.similarAds.clear();
    repository.getSimilarAds(action.adsId).then((similarAds) {
      completed(next, action);
      next(SyncSimilarAdsAction(similarAds));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getTrendSizes(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.trendSizes.clear();
    repository.getTrendSizes().then((trendSizes) {
      completed(next, action);
      next(SyncTrendSizesAction(trendSizes));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getVerticalTrendAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    PaginationModel page;
    if (action.isPagination) {
      if ((store.state.homeState.verticalPage!.isLastPage)) return;
      page = store.state.homeState.verticalPage!;
      page.currentPage = page.currentPage! + 1;
    } else {
      running(next, action);
      store.state.homeState.trendAds.clear();
      page = PaginationModel(currentPage: 1, total: 1);
    }

    repository.getVerticalTrendAds(page.currentPage ?? 1).then((verticalTrendAds) {
      completed(next, action);
      next(SyncTrendVerticalAdsAction(verticalAds: verticalTrendAds.second, page: verticalTrendAds.first));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getSmallTrendAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    PaginationModel page;
    if (action.isPagination) {
      if (store.state.homeState.smallPage!.isLastPage) return;
      page = store.state.homeState.smallPage!;
      page.currentPage = page.currentPage! + 1;
    } else {
      running(next, action);
      store.state.homeState.trendAds.clear();
      page = PaginationModel(currentPage: 1, total: 1);
    }
    repository.getSmallTrendAds(page.currentPage ?? 1).then((smallTrendAds) {
      completed(next, action);
      next(SyncTrendSmallAdsAction(smallAds: smallTrendAds.second, page: smallTrendAds.first));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getBigTrendAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    PaginationModel page;
    if (action.isPagination) {
      if (store.state.homeState.bigPage!.isLastPage) return;
      page = store.state.homeState.bigPage!;
      page.currentPage = page.currentPage! + 1;
    } else {
      running(next, action);
      store.state.homeState.trendAds.clear();
      page = PaginationModel(currentPage: 1, total: 1);
    }
    repository.getBigTrendAds(page.currentPage ?? 1).then((bigTrendAds) {
      completed(next, action);
      next(SyncTrendBigAdsAction(bigAds: bigTrendAds.second, page: bigTrendAds.first));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _updateAdsStatus(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    final MyAdsModel adsModel = (action as UpdateAdsStatusAction).adsModel;
    final int newStatus = (adsModel.active ?? 1) == 1 ? 0 : 1;
    repository.updateAdsStatus(adsModel.id!, newStatus).then((bigTrendAds) {
      completed(next, action);
      adsModel.active = newStatus;
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _upgradeAds(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    final MyAdsModel adsModel = (action as UpgradeAdsAction).adsModel;
    repository.upgradeAds(adsModel.id!, action.packageId).then((bigTrendAds) {
      completed(next, action);
      adsModel.remainingDays = action.packageDays;
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _addProductToStore(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.createStoreProduct(action.storeId, action.productModel).then((product) {
      completed(next, action);
      next(SyncOneStoreProductsAction(product: product));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getStoreProducts(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    PaginationModel page;
    if (action.pagination) {
      if (store.state.homeState.productsPage!.isLastPage) return;
      page = store.state.homeState.productsPage!;
      page.currentPage = page.currentPage! + 1;
      running(next, action);
    } else {
      running(next, action);
      store.state.homeState.storeProducts.clear();
      page = PaginationModel(currentPage: 1, total: 1);
    }
    repository.getStoreProducts(action.storeId, page.currentPage ?? 1).then((products) {
      completed(next, action);
      next(SyncStoreProductsAction(
        products: products.first,
        productsPage: products.second,
      ));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getSectionAttributes(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.sectionAttributes.clear();
    repository.getSectionsAttributes(action.sectionId).then((attributes) {
      completed(next, action);
      next(SyncSectionAttributesAction(attributes));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _updateStoreProduct(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.updateStoreProduct(action.storeId, action.productModel).then((product) {
      completed(next, action);
      next(SyncOneStoreProductsAction(product: product));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _updateCommercialStore(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.updateCommercialStore(action.createStoreModel, action.storeId).then((product) {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _deleteChatAction(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.deleteChat(action.chatId).then((product) {
      store.state.homeState.chats.remove(action.chatId.toString());
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _reportProduct(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.reportProduct(action.productId).then((product) {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getFollowingStores(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.followingStores.clear();
    repository.getFollowingStores().then((stores) {
      completed(next, action);
      next(SyncFollowingStoresAction(stores));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getColors(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.colors.clear();
    repository.getColors().then((colors) {
      completed(next, action);
      next(SyncColorsAction(colors));
    })/*.catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    })*/;
  };
}

Middleware<AppState> _getSizes(HomeRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    store.state.homeState.sizes.clear();
    repository.getSizes().then((sizes) {
      completed(next, action);
      next(SyncSizesAction(sizes));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

void catchError(NextDispatcher next, action, error) {
  next(
    HomeStatusAction(
      report: ActionReport(actionName: action.actionName, status: ActionStatus.error, msg: error.toString()),
    ),
  );
}

void completed(NextDispatcher next, action) {
  next(
    HomeStatusAction(
      report: ActionReport(
          actionName: action.actionName, status: ActionStatus.complete, msg: "${action.actionName} is completed"),
    ),
  );
}

void running(NextDispatcher next, action) {
  next(
    HomeStatusAction(
      report: ActionReport(
          actionName: action.actionName, status: ActionStatus.running, msg: "${action.actionName} is running"),
    ),
  );
}

void idEmpty(NextDispatcher next, action) {
  next(
    HomeStatusAction(
      report: ActionReport(actionName: action.actionName, status: ActionStatus.error, msg: "Id is empty"),
    ),
  );
}
