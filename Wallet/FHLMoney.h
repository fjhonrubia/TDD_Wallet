//
//  FHLMoney.h
//  Wallet
//
//  Created by Fco. Javier Honrubia Lopez on 26/1/16.
//
//

#import <Foundation/Foundation.h>
@class FHLMoney;
@class FHLBroker;

@protocol FHLMoney <NSObject>

-(id)initWithAmount:(NSInteger) amount
           currency: (NSString *) currency;

-(id<FHLMoney>) times:(NSInteger) multiplier;

-(id<FHLMoney>) plus:(FHLMoney *) other;

-(id<FHLMoney>) reduceToCurrency:(NSString*) currency
                      withBroker:(FHLBroker*) broker;

@end

@interface FHLMoney : NSObject<FHLMoney>

@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, readonly) NSString *currency;

+(id) euroWithAmount:(NSInteger) amount;
+(id) dollarWithAmount:(NSInteger) amount;

@end
