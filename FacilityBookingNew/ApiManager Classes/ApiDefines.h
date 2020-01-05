
#ifndef ApiDefines_h
#define ApiDefines_h

//#define apiBaseURL @"https://intranet.maddogcasting.com/castr/maddogextras/mobapp/v1/"
#define apiBaseURL @"http://sampletemplates.net.in/facilitybooking/api/Example/"
#define defaultAuthorization @"b8416f2680eb164d61b33f6606f94b6d"
#define AuthorizationName @"Authorization"

//SignUp Screen - file(loginViewController)
#define signUpURL @"signup"
//params
#define signUpEmail @"email"
#define signUpPassword @"password"
#define signUpUserFirstName @"first_name"
#define signUpUserLastName @"last_name"
#define signUpUserLatitude @"latitude"
#define signUpUserLongitude @"longitude"
#define signUpUserPlatform @"platform"
#define signUpUserDeviceId @"device_id"

//Login screen -file(loginViewController)
#define loginURL @"login"

//SignUp & Login screen -file(loginViewController)
#define fbLoginURL @"fblogin"
//params
#define profilePic @"profile_pic"
#define fbID @"fb_id"

//forgot password screen
#define forgotPasswordURL @"forgotpassword"

//Categoties api
#define CategoriesApi @"categories"
//params
#define categoriesApiMin @"min"
#define categoriesApiMax @"max"

//sub Categories Api
#define SubCategoriesApi @"subcategories"
//params
#define SubCategoryID @"category_id"
#define SubMin @"min"
#define SubMax @"max"

//Face of the month
#define FaceOfMonth @"faceofthemonth"


//vendors api
#define VendorsApi @"vendorslist"
//params
#define vendorCategoryID @"category_id"
#define vendorSubCategoryID @"subcategory_id"
#define vendorLatitude @"latitude"
#define vendorLonggitude @"longitude"
#define vendorSearchText @"search_text"
#define vendorSortBy @"sort_by"
#define vendorThemes @"themes"
#define vendorMin @"min"
#define vendorMax @"max"

#define themesApi @"themes"
//params
#define themesCatID @"category_id"
#define themesMin @"min"
#define themesMax @"max"

//add to WishList api
#define addWishListApi @"addwishlist"
//params
#define addWishListUserId @"user_id"
#define addWishlistSubCatId @"subcategory_id"
#define addWishListCatId @"category_id"

//Favorites screen
#define favoritesApi @"favorites"

//add favorite api
#define addFavoriteApi @"addfavorite"
//Params
#define vendorIDParam @"vendor_id"


#define logoutApi @"logout"
//parmas
#define logoutUserId @"user_id"
#define logoutDeviceId @"device_id"

#endif /* ApiDefines_h */
