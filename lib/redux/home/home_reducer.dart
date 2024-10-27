import 'package:dealz/data/models/create_trend_ads_model.dart';
import 'package:dealz/data/models/trend_ads_model.dart';
import 'package:dealz/redux/home/home_action.dart';
import 'package:dealz/redux/home/home_state.dart';
import 'package:redux/redux.dart';

final homeReducer = combineReducers<HomeState>([
  TypedReducer<HomeState, HomeStatusAction>(_syncHomeState),
  TypedReducer<HomeState, SyncHomeDataAction>(_syncHomeData),
  TypedReducer<HomeState, SyncStoreDetailsAction>(_syncStoreDetails),
  TypedReducer<HomeState, SyncStoreProductListAction>(_syncStoreProductList),
  TypedReducer<HomeState, SyncSectionCategoriesAction>(_syncSectionCategories),
  TypedReducer<HomeState, SyncCategoryProductsAction>(_syncCategoryProducts),
  TypedReducer<HomeState, SyncSectionProductsAction>(_syncSectionProducts),
  TypedReducer<HomeState, SyncCitiesAction>(_syncCities),
  TypedReducer<HomeState, SyncStatesAction>(_syncStates),
  TypedReducer<HomeState, SyncSectionsAction>(_syncSections),
  TypedReducer<HomeState, SyncPackagesAction>(_syncPackages),
  TypedReducer<HomeState, SyncAddressAction>(_syncAddresses),
  TypedReducer<HomeState, SyncCommercialStoresAction>(_syncCommercialStore),
  TypedReducer<HomeState, SyncPageDataAction>(_syncPageData),
  TypedReducer<HomeState, SyncMyAdsAction>(_syncMyAds),
  TypedReducer<HomeState, SyncAdsSliderAction>(_syncAdsSliders),
  TypedReducer<HomeState, SyncAdsSectionsAction>(_syncAdsSections),
  TypedReducer<HomeState, SyncOrdinaryAdsAction>(_syncOrdinaryAds),
  TypedReducer<HomeState, SyncAdsBySectionAction>(_syncAdsBySection),
  TypedReducer<HomeState, SyncCommercialAdsAction>(_syncCommercialAds),
  TypedReducer<HomeState, SyncMostWatchedAdsAction>(_syncMostWantedAds),
  TypedReducer<HomeState, SyncAdsCategoriesAction>(_syncCategoriesAds),
  TypedReducer<HomeState, SyncChatsAction>(_syncChats),
  TypedReducer<HomeState, SyncChatMessagesAction>(_syncChatMessages),
  TypedReducer<HomeState, SyncWishListAction>(_syncWishList),
  TypedReducer<HomeState, SyncUserAdsAction>(_syncUserAds),
  TypedReducer<HomeState, SyncAdsFeaturesAction>(_syncFeatures),
  TypedReducer<HomeState, SyncLastSeenAction>(_syncLastSeen),
  TypedReducer<HomeState, SyncAdsByIdAction>(_syncSingleAd),
  TypedReducer<HomeState, SyncUserProfileAction>(_syncUserProfile),
  TypedReducer<HomeState, SyncFollowingsAction>(_syncFollowings),
  TypedReducer<HomeState, SyncSimilarAdsAction>(_syncSimilarAds),
  TypedReducer<HomeState, SyncTrendSizesAction>(_syncTrendSizes),
  TypedReducer<HomeState, SyncTrendVerticalAdsAction>(_syncVerticalAds),
  TypedReducer<HomeState, SyncTrendBigAdsAction>(_syncBigAds),
  TypedReducer<HomeState, SyncTrendSmallAdsAction>(_syncSmallAds),
  TypedReducer<HomeState, SyncStoreProductsAction>(_syncStoreProducts),
  TypedReducer<HomeState, SyncOneStoreProductsAction>(_syncOneStoreProducts),
  TypedReducer<HomeState, SyncSectionAttributesAction>(_syncSectionAttributesAction),
  TypedReducer<HomeState, SyncFilterDataAction>(_syncFilterDataAction),
  TypedReducer<HomeState, SyncFollowingStoresAction>(_syncFollowingStores),
  TypedReducer<HomeState, SyncSizesAction>(_syncSizes),
  TypedReducer<HomeState, SyncColorsAction>(_syncColors),
]);

HomeState _syncHomeState(HomeState state, HomeStatusAction action) {
  var status = state.status;
  status.update(action.report.actionName ?? '', (v) => action.report, ifAbsent: () => action.report);

  return state.copyWith(status: status);
}

HomeState _syncHomeData(HomeState state, SyncHomeDataAction action) {
  return state.copyWith(homeData: action.homeModel);
}

HomeState _syncStoreDetails(HomeState state, SyncStoreDetailsAction action) {
  return state.copyWith(storeDetails: action.storeDetails);
}

HomeState _syncStoreProductList(HomeState state, SyncStoreProductListAction action) {
  for (var product in action.storeProductList) {
    state.storeProductList.update(product.id.toString(), (value) => product, ifAbsent: () => product);
  }

  return state.copyWith(storeProductList: state.storeProductList);
}

HomeState _syncSectionCategories(HomeState state, SyncSectionCategoriesAction action) {
  for (var category in action.sectionCategories) {
    state.sectionCategories.update(category.id.toString(), (value) => category, ifAbsent: () => category);
  }

  return state.copyWith(sectionCategories: state.sectionCategories);
}

HomeState _syncCategoryProducts(HomeState state, SyncCategoryProductsAction action) {
  for (var product in action.categoryProducts) {
    state.categoryProducts.update(product.id.toString(), (value) => product, ifAbsent: () => product);
  }

  return state.copyWith(categoryProducts: state.categoryProducts);
}

HomeState _syncSectionProducts(HomeState state, SyncSectionProductsAction action) {
  for (var product in action.sectionProducts) {
    state.sectionProducts.update(product.id.toString(), (value) => product, ifAbsent: () => product);
  }

  return state.copyWith(sectionProducts: state.sectionProducts);
}

HomeState _syncCities(HomeState state, SyncCitiesAction action) {
  for (var city in action.cities) {
    state.cities.update(city.id.toString(), (value) => city, ifAbsent: () => city);
  }
  return state.copyWith(cities: state.cities);
}

HomeState _syncStates(HomeState state, SyncStatesAction action) {
  for (var stateModel in action.states) {
    state.states.update(stateModel.id.toString(), (value) => stateModel, ifAbsent: () => stateModel);
  }
  return state.copyWith(states: state.states);
}

HomeState _syncSections(HomeState state, SyncSectionsAction action) {
  for (var section in action.sections) {
    state.dealsSections.update(section.id.toString(), (value) => section, ifAbsent: () => section);
  }
  return state.copyWith(dealsSections: state.dealsSections);
}

HomeState _syncPackages(HomeState state, SyncPackagesAction action) {
  for (var package in action.packages) {
    state.packages.update(package.id.toString(), (value) => package, ifAbsent: () => package);
  }
  return state.copyWith(packages: state.packages);
}

HomeState _syncAddresses(HomeState state, SyncAddressAction action) {
  for (var address in action.addresses) {
    state.addresses.update(address.id.toString(), (value) => address, ifAbsent: () => address);
  }
  return state.copyWith(addresses: state.addresses);
}

HomeState _syncCommercialStore(HomeState state, SyncCommercialStoresAction action) {
  for (var store in action.commercialStores) {
    state.commercialStore.update(store.id.toString(), (value) => store, ifAbsent: () => store);
  }
  return state.copyWith(commercialStore: state.commercialStore);
}

HomeState _syncPageData(HomeState state, SyncPageDataAction action) {
  return state.copyWith(pageModel: action.pageData);
}

HomeState _syncMyAds(HomeState state, SyncMyAdsAction action) {
  for (var ad in action.myAds) {
    state.myAds.update(ad.id.toString(), (value) => ad, ifAbsent: () => ad);
  }
  return state.copyWith(myAds: state.myAds);
}

HomeState _syncAdsSliders(HomeState state, SyncAdsSliderAction action) {
  for (var slider in action.adsSlider) {
    state.adsSliders.update(slider.id.toString(), (value) => slider, ifAbsent: () => slider);
  }
  return state.copyWith(adsSliders: state.adsSliders);
}

HomeState _syncAdsSections(HomeState state, SyncAdsSectionsAction action) {
  for (var section in action.adsSections) {
    state.adsSections.update(section.id.toString(), (value) => section, ifAbsent: () => section);
  }
  return state.copyWith(adsSections: state.adsSections);
}

HomeState _syncOrdinaryAds(HomeState state, SyncOrdinaryAdsAction action) {
  for (var ad in action.ordinaryAds) {
    state.ordinaryAds.update(ad.id.toString(), (value) => ad, ifAbsent: () => ad);
  }
  return state.copyWith(ordinaryAds: state.ordinaryAds);
}

HomeState _syncAdsBySection(HomeState state, SyncAdsBySectionAction action) {
  for (var ad in action.adsBySection) {
    state.adsBySection.update(ad.id.toString(), (value) => ad, ifAbsent: () => ad);
  }
  return state.copyWith(adsBySection: state.adsBySection);
}

HomeState _syncCommercialAds(HomeState state, SyncCommercialAdsAction action) {
  for (var ad in action.commercialAds) {
    state.commercialAds.update(ad.id.toString(), (value) => ad, ifAbsent: () => ad);
  }
  return state.copyWith(commercialAds: state.commercialAds, commercialAdsPage: action.adPage);
}

HomeState _syncMostWantedAds(HomeState state, SyncMostWatchedAdsAction action) {
  for (var ad in action.mostWantedAds) {
    state.mostWantedAds.update(ad.id.toString(), (value) => ad, ifAbsent: () => ad);
  }
  return state.copyWith(mostWantedAds: state.mostWantedAds);
}

HomeState _syncCategoriesAds(HomeState state, SyncAdsCategoriesAction action) {
  for (var ad in action.ads) {
    state.categoriesAds.update(ad.id.toString(), (value) => ad, ifAbsent: () => ad);
  }
  return state.copyWith(categoriesAds: state.categoriesAds);
}

HomeState _syncChats(HomeState state, SyncChatsAction action) {
  for (var user in action.users) {
    state.chats.update(user.id.toString(), (value) => user, ifAbsent: () => user);
  }
  return state.copyWith(chats: state.chats);
}

HomeState _syncChatMessages(HomeState state, SyncChatMessagesAction action) {
  for (var message in action.messages) {
    state.messages.update(message.id.toString(), (value) => message, ifAbsent: () => message);
  }
  return state.copyWith(messages: state.messages);
}

HomeState _syncWishList(HomeState state, SyncWishListAction action) {
  for (var wish in action.wishlist) {
    state.wishList.update(wish.id.toString(), (value) => wish, ifAbsent: () => wish);
  }
  return state.copyWith(wishList: state.wishList);
}

HomeState _syncUserAds(HomeState state, SyncUserAdsAction action) {
  for (var ad in action.userAds) {
    state.userAds.update(ad.id.toString(), (value) => ad, ifAbsent: () => ad);
  }
  return state.copyWith(userAds: state.userAds);
}

HomeState _syncFeatures(HomeState state, SyncAdsFeaturesAction action) {
  for (var feature in action.features) {
    state.features.update(feature.id.toString(), (value) => feature, ifAbsent: () => feature);
  }
  return state.copyWith(features: state.features);
}

HomeState _syncLastSeen(HomeState state, SyncLastSeenAction action) {
  for (var ads in action.ads) {
    state.lastSeen.update(ads.id.toString(), (value) => ads, ifAbsent: () => ads);
  }
  return state.copyWith(lastSeen: state.lastSeen);
}

HomeState _syncFollowings(HomeState state, SyncFollowingsAction action) {
  for (var user in action.followings) {
    state.followings.update(user.id.toString(), (value) => user, ifAbsent: () => user);
  }
  return state.copyWith(followings: state.followings);
}

HomeState _syncTrendSizes(HomeState state, SyncTrendSizesAction action) {
  for (var size in action.trendSizes) {
    state.trendSizes.update(size.size.toString(), (value) => size, ifAbsent: () => size);
  }
  return state.copyWith(trendSizes: state.trendSizes);
}

HomeState _syncSimilarAds(HomeState state, SyncSimilarAdsAction action) {
  for (var ads in action.similarAds) {
    state.similarAds.update(ads.id.toString(), (value) => ads, ifAbsent: () => ads);
  }
  return state.copyWith(similarAds: state.similarAds);
}

HomeState _syncSingleAd(HomeState state, SyncAdsByIdAction action) {
  return state.copyWith(adsModel: action.myAdsModel);
}

HomeState _syncUserProfile(HomeState state, SyncUserProfileAction action) {
  return state.copyWith(addedByUser: action.user);
}

HomeState _syncVerticalAds(HomeState state, SyncTrendVerticalAdsAction action) {
  Map<String, List<TrendAdsModel>> verticalTrendAds = <String, List<TrendAdsModel>>{
    trendsSize.vertical.name: action.verticalAds,
  };
  Map<String, List<TrendAdsModel>> oldVerticalTrendAds =
      state.trendAds[action.page.currentPage ?? 0] ?? verticalTrendAds;
  oldVerticalTrendAds.update(trendsSize.vertical.name, (value) => action.verticalAds,
      ifAbsent: () => action.verticalAds);
  state.trendAds
      .update(action.page.currentPage ?? 0, (value) => oldVerticalTrendAds, ifAbsent: () => oldVerticalTrendAds);
  return state.copyWith(verticalPage: action.page, trendAds: state.trendAds);
}

HomeState _syncSmallAds(HomeState state, SyncTrendSmallAdsAction action) {
  Map<String, List<TrendAdsModel>> smallTrendAds = <String, List<TrendAdsModel>>{
    trendsSize.small.name: action.smallAds,
  };
  Map<String, List<TrendAdsModel>> oldSmallTrendAds = state.trendAds[action.page.currentPage ?? 0] ?? smallTrendAds;
  oldSmallTrendAds.update(trendsSize.small.name, (value) => action.smallAds, ifAbsent: () => action.smallAds);
  state.trendAds.update(action.page.currentPage ?? 0, (value) => oldSmallTrendAds, ifAbsent: () => oldSmallTrendAds);
  return state.copyWith(smallPage: action.page, trendAds: state.trendAds);
}

HomeState _syncBigAds(HomeState state, SyncTrendBigAdsAction action) {
  Map<String, List<TrendAdsModel>> bigTrendAds = <String, List<TrendAdsModel>>{
    trendsSize.big.name: action.bigAds,
  };
  Map<String, List<TrendAdsModel>> oldBigTrendAds = state.trendAds[action.page.currentPage ?? 0] ?? bigTrendAds;
  oldBigTrendAds.update(trendsSize.big.name, (value) => action.bigAds, ifAbsent: () => action.bigAds);
  state.trendAds.update(action.page.currentPage ?? 0, (value) => oldBigTrendAds, ifAbsent: () => oldBigTrendAds);
  return state.copyWith(bigPage: action.page, trendAds: state.trendAds);
}

HomeState _syncStoreProducts(HomeState state, SyncStoreProductsAction action) {
  for (var product in action.products) {
    state.storeProducts.update(product.id.toString(), (value) => product, ifAbsent: () => product);
  }

  return state.copyWith(
    storeProducts: state.storeProducts,
    productsPage: action.productsPage,
  );
}

HomeState _syncSectionAttributesAction(HomeState state, SyncSectionAttributesAction action) {
  for (var attribute in action.attributes) {
    state.sectionAttributes.update(attribute.id.toString(), (value) => attribute, ifAbsent: () => attribute);
  }

  return state.copyWith(sectionAttributes: state.sectionAttributes);
}

HomeState _syncOneStoreProducts(HomeState state, SyncOneStoreProductsAction action) {
  state.storeProducts.update(action.product.id.toString(), (value) => action.product, ifAbsent: () => action.product);

  return state.copyWith(storeProducts: state.storeProducts);
}

HomeState _syncFollowingStores(HomeState state, SyncFollowingStoresAction action) {
  for (var store in action.stores) {
    state.followingStores.update(store.id.toString(), (value) => store, ifAbsent: () => store);
  }
  return state.copyWith(followingStores: state.followingStores);
}

HomeState _syncFilterDataAction(HomeState state, SyncFilterDataAction action) {
  return state.copyWith(filterData: action.filterData);
}

HomeState _syncColors(HomeState state, SyncColorsAction action) {
  for (var color in action.colors) {
    state.colors.update(color.id.toString(), (value) => color, ifAbsent: () => color);
  }
  return state.copyWith(colors: state.colors);
}

HomeState _syncSizes(HomeState state, SyncSizesAction action) {
  for (var size in action.sizes) {
    state.sizes.update(size.id.toString(), (value) => size, ifAbsent: () => size);
  }
  return state.copyWith(sizes: state.sizes);
}
