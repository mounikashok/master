

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "ApiDefines.h"
@interface ApiManager : NSObject{
    NSMutableData *mdata;
}

+ (ApiManager*)sharedManager;
+ (AFHTTPSessionManager*)operationManager;
- (instancetype)init;
-(NSString*)jsonStringWithJsonDict:(NSDictionary*)jsonDict;
- (void)apicheck;

//For SignUp Api
- (void)signUpWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
//For Login Api
- (void)loginWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
//For OTP Api
- (void)OTPWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
//For Forgot Api
- (void)forgotWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
//For Social Api
- (void)socialLoginWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
//For Home Api
- (void)homeWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
//For Favourite Api
- (void)favouriteWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
//For get Favourites Api
- (void)getFavouriteApiWithDetails:(NSArray*)details
                           success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
//For Search Api
- (void)searchWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
//For Filter Api
- (void)filterWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

//For Ground Details Api
- (void)groundDetailsWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

//For BookNow Api
- (void)bookNowWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

//For Teams Api
- (void)teamsWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

//For PlayersList Api
- (void)playersListWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

//For Tournment Api
- (void)tournmentWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

//For Tournment Details Api
- (void)tournmentDetailsWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;


//For My Bookings Api
- (void)myBookingsWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

//For Booking Details Api
- (void)myBookingDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;



//For UserProfile Api
- (void)userProfileApiWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;


//For Update User Profile Api
- (void)updateUserProfileWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

//For get Notification Api
- (void)getNotificationsApiWithDetails:(NSArray*)details
                               success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

//For Registration Api
- (void)registrationApiWithDetails:(NSArray*)details
                               success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
//For get Transactions Api
- (void)getTransactionsApiWithDetails:(NSArray*)details
                               success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

//For Player edit Api
- (void)playerEdit:(NSArray*)details
                               success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

//For Add Wallet Api
- (void)addWallet:(NSArray*)details
                               success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;




- (void)getTokenDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

- (void)getSettings:(NSArray*)details
                   success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
- (void)createMobileRepo:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
- (void)deleteMobileRepo:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
- (void)uploadMobileContacts:(NSArray*)details
                     success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;
- (void)pullPBXContacts:(NSArray*)details
                success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure;

- (void)create;
- (void)extras;
- (void)ahora;
- (void)signupP;
- (void)otp;
-(void)fielUpload;
-(void)getFile;
@end
