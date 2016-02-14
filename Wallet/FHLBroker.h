//
//  FHLBroker.h
//  Wallet
//
//  Created by Fco. Javier Honrubia Lopez on 8/2/16.
//
//

#import <Foundation/Foundation.h>
#import "FHLMoney.h"

@interface FHLBroker : NSObject

@property (nonatomic, strong) NSMutableDictionary *rates;

-(FHLMoney *)reduce:(id<FHLMoney>) money toCurrency:(NSString *) currency;

-(void) addRate:(NSInteger) rate
   fromCurrency:(NSString*)fromCurrency
     toCurrency:(NSString*)toCurrency;

-(NSString *) keyFromCurrency:(NSString *) fromCurrency
                   toCurrency:(NSString *) toCurrency;

@end
