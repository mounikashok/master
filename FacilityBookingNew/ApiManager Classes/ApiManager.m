
#import "ApiManager.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>
@implementation ApiManager

+ (ApiManager*)sharedManager {
    
    static ApiManager* _sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}
+(AFHTTPSessionManager*)operationManager{
    
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", apiBaseURL]];
    AFHTTPSessionManager* operationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded", nil]];
  
  AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
  securityPolicy.allowInvalidCertificates = YES;
  
  [securityPolicy setValidatesDomainName:NO];
  operationManager.securityPolicy = securityPolicy;
    
  
  AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
  [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  operationManager.requestSerializer = serializer;
    return operationManager;
}

+(AFHTTPSessionManager*)operationManager23{
  
  NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://63182win.hostedims.org/vsservices/api/json/syncreply/"]];
  AFHTTPSessionManager* operationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded", nil]];
  
  
  AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
  [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  operationManager.requestSerializer = serializer;
  return operationManager;
}
+(AFHTTPSessionManager*)operationManager1{
  
  NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", apiBaseURL]];
  AFHTTPSessionManager* operationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded", nil]];
  
  AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
  securityPolicy.allowInvalidCertificates = YES;
  
  [securityPolicy setValidatesDomainName:NO];
  
  operationManager.securityPolicy = securityPolicy;
  
  return operationManager;
}

+(AFHTTPSessionManager*)operationManager2{
  
  NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", apiBaseURL]];
  AFHTTPSessionManager* operationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",nil]];
  AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
  [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  operationManager.requestSerializer = serializer;
  return operationManager;
}

+(AFHTTPSessionManager*)operationManagerCall{
  
  NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.95.19.211/API/"]];
  AFHTTPSessionManager* operationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded", nil]];
  
  return operationManager;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        //self.deviceTokenId = @"";
    }
    return self;
}

- (NSString*)jsonStringWithJsonDict:(NSDictionary*)jsonDict {
    NSString* jsonString = @"";
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:nil];
    if (jsonData)
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

- (void)apicheck{
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                @"809",@"areaCode",
                @"Nigeria - Mobile",@"areaName",
                @"1",@"channels",
                @"",@"city",
                @"",@"cnam",
                @"234",@"countryCode",
                @"NGN",@"countryPhoneCode",
                @"",@"dIDWWUniqueCode",
                @"0",@"localAreaId",
                @"",@"nPA",
                @"",@"nXX",
                @"",@"phoneGroup",
                @"8099949998",@"phoneNumber",
                @"1",@"quantity",
                @"",@"stateCode",
                @"0",@"voxboneGroupId",
                nil];
    NSArray *array = [NSArray arrayWithObjects:dataDict, nil];
    NSDictionary* dataDict1;
    dataDict1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                @"298",@"clientID",
                @"1",@"countryId",
                @"false",@"promotion",
                array,@"purches",
                @"",@"resellerDb",
                @"",@"resellerRetailClient",
                @"false",@"subscription",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager23];
    [operationManager.requestSerializer setValue:@"Basic ZW1tYW51ZWw6RW1tYW51ZWw3ODk=" forHTTPHeaderField:@"Authorization"];
    [operationManager POST:@"client.dids.numbers.buy" parameters:dataDict1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
    }];
}


- (void)otp{
  NSDictionary* dataDict;
  dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
              @"+91",@"code",
              @"7013847337",@"mobile_number",
              nil];
  AFHTTPSessionManager* operationManager = [[self class] operationManagerCall];
  [operationManager POST:@"otp.php" parameters:dataDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"%@",responseObject);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"%@",error.description);
  }];
}


- (NSString*) hmacForKeyAndData: (NSString*) myString key: (NSString*) key
{
  
  NSString *data = myString;
  const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
  const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
  unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
  CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
  
  NSMutableString *result = [NSMutableString string];
  for (int i = 0; i < sizeof(cHMAC); i++)
  {
    [result appendFormat:@"%02hhx", cHMAC[i]];
  }
  
  NSLog(@"%@",result);
  NSString *hmac_string = [NSString stringWithFormat:@"%@",result];
  return hmac_string;
}

//For SignUp Api
- (void)signUpWithDetails:(NSArray*)details
                  success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"name",
                [details objectAtIndex:2], @"email",
                [details objectAtIndex:3], @"phone",
                [details objectAtIndex:4], @"password",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Login Api
- (void)loginWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure{
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"username",
                [details objectAtIndex:2], @"password",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For OTP Api
- (void)OTPWithDetails:(NSArray*)details
               success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"otp",
                [details objectAtIndex:2], @"userid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Forgot Api
- (void)forgotWithDetails:(NSArray*)details
                  success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"email",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Social Api
- (void)socialLoginWithDetails:(NSArray*)details
                       success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"name",
                [details objectAtIndex:2], @"email",
                [details objectAtIndex:3], @"Profile",
                [details objectAtIndex:4], @"logintype",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager1];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Home Api
- (void)homeWithDetails:(NSArray*)details
                success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
    
}

//For Favourite Api
- (void)favouriteWithDetails:(NSArray*)details
                     success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                [details objectAtIndex:2],@"groundid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Search Api
- (void)searchWithDetails:(NSArray*)details
                  success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                [details objectAtIndex:2],@"keyword",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Filter Api
- (void)filterWithDetails:(NSArray*)details
                  success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                [details objectAtIndex:2],@"price",
                [details objectAtIndex:3],@"rating",
                [details objectAtIndex:4],@"location",
                [details objectAtIndex:5],@"amenties",
                [details objectAtIndex:6],@"startdate",
                [details objectAtIndex:7],@"enddate",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Ground Details Api
- (void)groundDetailsWithDetails:(NSArray*)details
                         success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                [details objectAtIndex:2],@"gid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
    
}

//For Teams Api
- (void)teamsWithDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure{
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For PlayersList Api
- (void)playersListWithDetails:(NSArray*)details
                       success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For BookNow Api
- (void)bookNowWithDetails:(NSArray*)details
                   success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                [details objectAtIndex:2],@"gid",
                [details objectAtIndex:3],@"date",
                [details objectAtIndex:4],@"timeslot",
                [details objectAtIndex:5],@"teamid",
                [details objectAtIndex:6],@"price",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Tournment Api
- (void)tournmentWithDetails:(NSArray*)details
                     success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Tournment Details Api
- (void)tournmentDetailsWithDetails:(NSArray*)details
                            success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"tid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For My Bookings Api
- (void)myBookingsWithDetails:(NSArray*)details
                      success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Booking Details Api
- (void)myBookingDetails:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"bookingid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
    
}

//For UserProfile Api
- (void)userProfileApiWithDetails:(NSArray*)details
                          success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Update User Profile Api
- (void)updateUserProfileWithDetails:(NSArray*)details
                             success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                [details objectAtIndex:2],@"name",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:[details objectAtIndex:3] name:@"userfile" fileName:@"image.png" mimeType:@"image/png"];

    } progress:nil success:success failure:failure];
}

//For get Favourites Api
- (void)getFavouriteApiWithDetails:(NSArray*)details
                          success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For get Notification Api
- (void)getNotificationsApiWithDetails:(NSArray*)details
                          success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For get Notification Api
- (void)registrationApiWithDetails:(NSArray*)details
                               success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                [details objectAtIndex:2],@"teamname",
                [details objectAtIndex:3],@"team",
                [details objectAtIndex:4],@"player",
                [details objectAtIndex:5],@"name",
                [details objectAtIndex:6],@"email",
                [details objectAtIndex:7],@"phone",
                [details objectAtIndex:8],@"price",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For get Transactions Api
- (void)getTransactionsApiWithDetails:(NSArray*)details
                              success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Player Edit Api
- (void)playerEdit:(NSArray*)details
           success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                [details objectAtIndex:2],@"teamname",
                [details objectAtIndex:3],@"team",
                [details objectAtIndex:4],@"player",
                [details objectAtIndex:5],@"name",
                [details objectAtIndex:6],@"email",
                [details objectAtIndex:7],@"phone",
                [details objectAtIndex:8],@"price",
                [details objectAtIndex:9],@"playerid",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}

//For Add Wallet Api
- (void)addWallet:(NSArray*)details
          success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict;
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                [details objectAtIndex:0],@"action",
                [details objectAtIndex:1],@"userid",
                [details objectAtIndex:2],@"amount",
                nil];
    AFHTTPSessionManager* operationManager = [[self class] operationManager];
    [operationManager.requestSerializer setValue:@"CODEX@123" forHTTPHeaderField:@"x-api-key"];
    [operationManager POST:@"user" parameters:dataDict progress:nil success:success failure:failure];
}





- (NSString *)getUserAgent {
  NSString *dVersion = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
  NSString *aVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
  NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
  
  dVersion = [dVersion stringByReplacingOccurrencesOfString:@"." withString:@"-"];
  NSString *aggent = [NSString stringWithFormat:@"LoquaceDialer/ios-%@/%@(%@)",dVersion,aVersion,build];
  return aggent;
}

- (void)getTokenDetails:(NSArray*)details
                success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure{
  NSDictionary* dataDict;
  dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
              [details objectAtIndex:0],@"username",
              [details objectAtIndex:1],@"password",
              nil];
  AFHTTPSessionManager* operationManager;
  if ([details.lastObject isEqualToString:@"1"]) {
   operationManager = [[self class] operationManager23];
  }
  else{
    operationManager = [[self class] operationManager];
  }
  [operationManager.requestSerializer setValue:[self getUserAgent] forHTTPHeaderField:@"User-Agent"];
  [operationManager.requestSerializer setValue:@"krify-test.nems.it" forHTTPHeaderField:@"X-Loquace-Tenant"];
  [operationManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
  [operationManager POST:@"auth/tokens" parameters:dataDict progress:nil success:success failure:failure];
}

- (void)getSettings:(NSArray*)details
                success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure{

  NSLog(@"%@ %@",[self getUserAgent],[details objectAtIndex:0] );
  
  AFHTTPSessionManager* operationManager = [[self class] operationManager1];
  
  NSLog(@"%@ %@",[self getUserAgent],[details objectAtIndex:0] );
  [operationManager.requestSerializer setValue:[self getUserAgent] forHTTPHeaderField:@"User-Agent"];
  [operationManager.requestSerializer setValue:@"krify-test.nems.it" forHTTPHeaderField:@"X-Loquace-Tenant"];
  [operationManager.requestSerializer setValue:[details objectAtIndex:0] forHTTPHeaderField:@"X-AUTH-TOKEN"];
  [operationManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
  [operationManager GET:@"settings" parameters:nil progress:nil success:success failure:failure];
}

- (void)createMobileRepo:(NSArray*)details
            success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure{
  
  AFHTTPSessionManager* operationManager = [[self class] operationManager1];
  [operationManager.requestSerializer setValue:[self getUserAgent] forHTTPHeaderField:@"User-Agent"];
  [operationManager.requestSerializer setValue:@"krify-test.nems.it" forHTTPHeaderField:@"X-Loquace-Tenant"];
  [operationManager.requestSerializer setValue:[details objectAtIndex:0] forHTTPHeaderField:@"X-AUTH-TOKEN"];
  [operationManager PUT:@"contact/lists/mobile-app" parameters:nil success:success failure:failure];
}

- (void)deleteMobileRepo:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure{
  
  AFHTTPSessionManager* operationManager = [[self class] operationManager1];
  [operationManager.requestSerializer setValue:[self getUserAgent] forHTTPHeaderField:@"User-Agent"];
  [operationManager.requestSerializer setValue:@"krify-test.nems.it" forHTTPHeaderField:@"X-Loquace-Tenant"];
  [operationManager.requestSerializer setValue:[details objectAtIndex:0] forHTTPHeaderField:@"X-AUTH-TOKEN"];
  [operationManager DELETE:@"contact/lists/mobile-app" parameters:nil success:success failure:failure];
}

- (void)uploadMobileContacts:(NSArray*)details
                 success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure{
  
  AFHTTPSessionManager* operationManager = [[self class] operationManager];
  [operationManager.requestSerializer setValue:[self getUserAgent] forHTTPHeaderField:@"User-Agent"];
  [operationManager.requestSerializer setValue:@"krify-test.nems.it" forHTTPHeaderField:@"X-Loquace-Tenant"];
  [operationManager.requestSerializer setValue:[details objectAtIndex:0] forHTTPHeaderField:@"X-AUTH-TOKEN"];
  [operationManager POST:@"contact/lists/mobile-app" parameters:[details objectAtIndex:1] progress:nil success:success failure:failure];
}

- (void)pullPBXContacts:(NSArray*)details
                     success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure{
  
  AFHTTPSessionManager* operationManager = [[self class] operationManager2];
  [operationManager.requestSerializer setValue:[self getUserAgent] forHTTPHeaderField:@"User-Agent"];
  [operationManager.requestSerializer setValue:@"krify-test.nems.it" forHTTPHeaderField:@"X-Loquace-Tenant"];
  [operationManager.requestSerializer setValue:[details objectAtIndex:0] forHTTPHeaderField:@"X-AUTH-TOKEN"];
  [operationManager GET:@"contact/changesets?fields=id,summary,timestamp&limit=1" parameters:nil progress:nil success:success failure:failure];
}

-(void)fielUpload{
  
  NSDictionary* dataDict;
  dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
              @"48E29009-FB8C-A6E0-DB1CA81A1EF0148F",@"userid",
              @"radan",@"brand",
              @"This is my caption",@"caption",
              nil];
  
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:nil];
  NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  NSLog(@"%@",jsonString);
  
  NSDictionary* dataDict1;
  dataDict1 = [[NSDictionary alloc] initWithObjectsAndKeys:
              jsonString,@"structInputParams",
              nil];
  
  NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.verosoftware.com/_api/"]];
  AFHTTPSessionManager* operationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",nil]];
  
  [operationManager POST:@"api.cfc?method=ImageUpload" parameters:dataDict1 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    UIImage *imag = [UIImage imageNamed:@"144.png"];
    [formData appendPartWithFileData:UIImagePNGRepresentation(imag) name:@"myImage" fileName:@"image1.png" mimeType:@"image/png"];
    
  } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"%@",responseObject);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"%@",error);
  }];
}
- (void)create{
  
  NSDictionary* dataDict;
  dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
              @"25",@"lempid",
              @"test1",@"username",
              @"2016-11-03",@"chqdate",
              @"122",@"chqno",
              @"Test",@"comment",
              @"2015-02-02",@"balancedate",
              @"2",@"paytype",
              @"2",@"vouchertype",
              @"0",@"totalamount",
              @"1",@"payamount",
              @"abd",@"bankname",
              @"rm",@"receipttype",
              @"123",@"recpno",
              nil];
  
  NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://202.62.71.30/accounts/mobapp/"]];
  AFHTTPSessionManager* operationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",nil]];
  
  AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
  [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  operationManager.requestSerializer = serializer;
  
  [operationManager POST:@"addreceipt.php" parameters:dataDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
      UIImage *imag = [UIImage imageNamed:@"144.png"];
      [formData appendPartWithFileData:UIImagePNGRepresentation(imag) name:@"sign" fileName:@"image1.jpg" mimeType:@"imge/jpeg"];
    
  } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"%@",responseObject);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"%@",error);
  }];
  
}
- (void)ahora{
  //[self login:@"1234568"];
  NSDictionary* dataDict;
  dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
              @"574886e234f0c411006e7a7e",@"_id",
              @"nohhjgghh kkk",@"address",
              @"12467",@"affiliateNumber",
              @"amoxidal ",@"alergies",
              @"Mar-28-1983",@"birthDate",
              @"94949",@"cellphone",
              @"Enfermedad de los tejidos mfaltiples ",@"chronicDeseases",
              @"",@"chronicMedication",
              @"cliffhangers",@"city",
              @"Argentina",@"country",
              @"paciente@ahoradoctor.com",@"email",
              @"insurance company",@"insuranceCompany",
              @"3",@"insurancePlan",
              @"svbsbj",@"lastName",
              @"doctor",@"name",
              @"superi",@"otherComments",
              @"123456789",@"password",
              @"1558421312",@"phone",
              @"Lucia Bosch",@"relativeName",
              @"1558373717",@"relativePhone",
              @"Madre",@"relativeRelation",
              @"hsjsjjjj",@"state",
              @"-1",@"status",
              @"521326",@"zipCode",
              nil];
  
  AFHTTPSessionManager* operationManager = [[self class] operationManager12];
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  [operationManager.requestSerializer setValue:[ud valueForKey:@"Authorization"] forHTTPHeaderField:@"X-Auth-Token"];
  [operationManager PUT:@"patient/profiles" parameters:dataDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"%@",responseObject);
    [self login:@"123456789"];
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"%@",error);
  }];
  
  
}
+(AFHTTPSessionManager*)operationManager12{
  
  
  NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://medxapi.herokuapp.com/ad/v1.1/sandbox/"]];
  AFHTTPSessionManager* operationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded", nil]];
  AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
  [serializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
  [serializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Accept"];
  operationManager.requestSerializer = serializer;
  return operationManager;
  
}
+(AFHTTPSessionManager*)operationManager11{
  
  NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://medxapi.herokuapp.com/ad/v1.1/sandbox/"]];
  
  AFHTTPSessionManager* operationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",nil]];
  return operationManager;
}
- (void)login:(NSString *)pass{
  
  NSDictionary* dataDict;
  dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
              @"paciente@ahoradoctor.com",@"email",
              pass,@"password",
              nil];
  
  NSLog(@"the dict details is %@",dataDict);
  AFHTTPSessionManager* operationManager = [[self class] operationManager11];

  [operationManager POST:@"public/access/login" parameters:dataDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"%@",responseObject);
    NSMutableDictionary *json = [[NSMutableDictionary alloc]init];
    json=responseObject;
    if ([[json valueForKey:@"status"]integerValue] == 0) {

      NSString *authorization = [NSString stringWithFormat:@"%@",[[json valueForKey:@"result"]valueForKey:@"token"]];

      NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
      [ud setValue:authorization forKey:@"Authorization"];;
      [ud synchronize];
      
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"%@",error);
  }];
  
  
}
- (void)extras{
  
 // [self signup];
  
  NSDictionary* dataDict;
  dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
              @"Kakinada, Andhra Pradesh, India",@"address",
              @"123456789",@"device_id",
              @"2000-02-02",@"dob",
              @"ramana@krify.net",@"email",
              @"1",@"gender",
              @"1",@"language",
              @"16.9890648",@"latitude",
              @"82.2474648",@"longitude",
              @"1234567899",@"mobile_number",
              @"123456",@"password",
              @"1",@"platform",
              @"",@"profile_pic",
              @"ramana",@"user_name",
              nil];
  
  NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://10.1.10.7/bitbucketworkspace/athlegacy_web/mobapp/v1/"]];
  AFHTTPSessionManager* operationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  
  operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",nil]];
  
  
  
  [operationManager.requestSerializer setValue:@"6fc78bad2f4a1a264be5b019d9e2ec3d" forHTTPHeaderField:@"Authorization"];
  [operationManager POST:@"login" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"%@",responseObject);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"%@",error);
  }];
  
  
}
-(void)scan{
  NSDictionary* dataDict1;
  dataDict1 = [[NSDictionary alloc] initWithObjectsAndKeys:
               @"ratna",@"lottoGameId",
               @"kavya",@"lottoEntryDate",
               @"ratnakavya@krify.co.in",@"lottoNumber",
               @"krify",@"restaurantId",
               @"true",@"acceptTerms",
               nil];
  
  
  NSDictionary* dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                            dataDict1, @"lottoEntry",
                            nil];
  
  
  NSError *error;
  NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dataDict
                                                     options:NSJSONWritingPrettyPrinted error:&error];
  NSString*  jsonStiring = [[NSString alloc]initWithData:jsonData encoding:NSASCIIStringEncoding];
  
  
  
  NSString *urlString;
  urlString =@"https://secure.coffeelotto.com.au/libraries/mobile/inc_rapidfire_lotto_mobile_handler_v1.0.php?action=enterLotto";
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
  [request setURL:[NSURL URLWithString:urlString]];
  [request setHTTPMethod:@"POST"];
  NSString *boundary = @"---------------------------14737809831466499882746641449";
  [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
  
  NSMutableData *body = [NSMutableData data];
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  NSString *param1 = [jsonStiring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"enterLottoJson\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[[NSString stringWithString:param1] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  
  [request setHTTPBody:body];
  // now lets make the connection to the web
  NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  NSString *returnString = nil;
  returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
  NSLog(@"%@",returnString);
}
-(void)login{
  NSMutableURLRequest *fbRequest1;
  fbRequest1 = [[NSMutableURLRequest alloc] initWithURL:
                [NSURL URLWithString:[NSString stringWithFormat:@"https://secure.coffeelotto.com.au/libraries/mobile/inc_rapidfire_lotto_mobile_handler_v1.0.php?action=doLogin&username=nt@skediatech.com.au&password=cof2016*!d"]]];
  [fbRequest1 setHTTPMethod:@"GET"];
  NSData *fbResponse1 = [NSURLConnection sendSynchronousRequest:fbRequest1 returningResponse:nil error:nil];
  NSString *stringResponse1 = nil;
  stringResponse1 = [[NSString alloc] initWithData:fbResponse1 encoding:NSASCIIStringEncoding];
  NSLog(@"%@",stringResponse1);
}
-(void)signup{
  NSDictionary* dataDict1;
  dataDict1 = [[NSDictionary alloc] initWithObjectsAndKeys:
               @"ratna",@"firstname",
               @"kavya",@"lastname",
               @"ratnakavya@krify.co.in",@"email",
               @"krify",@"password",
               @"true",@"acceptTerms",
               @"1234567890",@"phoneMobile",
               nil];
  
  
  NSDictionary* dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                            dataDict1, @"user",
                            nil];
  
  
  NSError *error;
  NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dataDict
                                                     options:NSJSONWritingPrettyPrinted error:&error];
  NSString*  jsonStiring = [[NSString alloc]initWithData:jsonData encoding:NSASCIIStringEncoding];
  
  
  
  NSString *urlString;
  urlString =@"https://secure.coffeelotto.com.au/libraries/mobile/inc_rapidfire_lotto_mobile_handler_v1.0.php?action=registerUser";
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
  [request setURL:[NSURL URLWithString:urlString]];
  [request setHTTPMethod:@"POST"];
  NSString *boundary = @"---------------------------14737809831466499882746641449";
  [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
  
  NSMutableData *body = [NSMutableData data];
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  NSString *param1 = [jsonStiring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userJson\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[[NSString stringWithString:param1] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  
  [request setHTTPBody:body];
  // now lets make the connection to the web
  NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  NSString *returnString = nil;
  returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
  NSLog(@"%@",returnString);
}
-(void)forgotpass{
  NSString *urlString;
  urlString =@"https://secure.coffeelotto.com.au/libraries/mobile/inc_rapidfire_lotto_mobile_handler_v1.0.php?action=forgottenPassword";
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
  [request setURL:[NSURL URLWithString:urlString]];
  [request setHTTPMethod:@"POST"];
  NSString *boundary = @"---------------------------14737809831466499882746641449";
  [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
  
  NSMutableData *body = [NSMutableData data];
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  NSString *param1 = @"ratnakavya@krify.net";
  [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[[NSString stringWithString:param1] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  
  [request setHTTPBody:body];
  // now lets make the connection to the web
  NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  NSString *returnString = nil;
  returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
  NSLog(@"%@",returnString);
}

+(AFHTTPSessionManager*)operationManager3{
  
  NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://secure.coffeelotto.com.au/libraries/mobile/"]];
  
  AFHTTPSessionManager* operationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/x-www-form-urlencoded",@"text/html",@"text/plain",nil]];
  
  AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
  [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  operationManager.requestSerializer = serializer;
  
  AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
  securityPolicy.allowInvalidCertificates = YES;
  
  [securityPolicy setValidatesDomainName:NO];
  
  return operationManager;
}
+(AFHTTPSessionManager*)operationManagerpaort{
  
  NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://104.154.155.60/API-JSON/"]];
  AFHTTPSessionManager* operationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  [operationManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/json",nil]];
  AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
  [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  operationManager.requestSerializer = serializer;
  return operationManager;
}
- (void)signupP{
  NSDictionary* dataDict;
  dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
              @"58H32B19G5PK6F2X0",@"device_token",
              @"Test",@"firstname",
              @"India",@"country",
              @"58H32B19G5PK6F2X0",@"key",
              @"v2.7.0",@"version",
              @"7355163212",@"phone",
              @"91",@"prefix",
              nil];
  AFHTTPSessionManager* operationManager = [[self class] operationManagerpaort];
  [operationManager POST:@"register.php" parameters:dataDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"%@",responseObject);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"%@",error.description);
  }];
}
-(void)getFile{
    NSString *urlString;
    urlString =@"https://api.w3tel.net/mob/v1/voicemail/messages/100722018022620180226135030100";
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9qd3QubG9jYWxob3N0IiwiaWF0IjoxNTE4OTgzNzcxLCJleHAiOjE1MzE5NDM3NzEsImNvbnRleHQiOnsidXNlciI6eyJ1c2VyX2xvZ2luIjoiY29tcGFueTFAdzN0ZWwubmV0IiwidXNlcl9pZCI6IjgwMiJ9fX0.KQmx88QrITl5WzzTef9IMvwrxKWi2YGHUonTGNaaUzs" forHTTPHeaderField:@"Authorization"];//change this according to your need.

    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = nil;
    returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",returnString);
    
    
    
    /*NSURL *url = [NSURL URLWithString:@"https://api.w3tel.net/mob/v1/100722018022620180226135030100"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [request setValue:@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9qd3QubG9jYWxob3N0IiwiaWF0IjoxNTE4OTgzNzcxLCJleHAiOjE1MzE5NDM3NzEsImNvbnRleHQiOnsidXNlciI6eyJ1c2VyX2xvZ2luIjoiY29tcGFueTFAdzN0ZWwubmV0IiwidXNlcl9pZCI6IjgwMiJ9fX0.KQmx88QrITl5WzzTef9IMvwrxKWi2YGHUonTGNaaUzs" forHTTPHeaderField:@"token"];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES ];*/
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    mdata = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mdata appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString  *filePath = [NSString stringWithFormat:@"%u/%@", NSDocumentDirectory,@"usman.wav"];
    [mdata writeToFile:filePath atomically:YES];
}
@end
