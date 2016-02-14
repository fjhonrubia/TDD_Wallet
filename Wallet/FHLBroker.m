//
//  FHLBroker.m
//  Wallet
//
//  Created by Fco. Javier Honrubia Lopez on 8/2/16.
//
//

#import "FHLBroker.h"

@implementation FHLBroker

-(id) init{
    if (self = [super init]) {
        _rates = [@{}mutableCopy];
    }
    return self;
}

-(FHLMoney*)reduce:(id<FHLMoney>) money
        toCurrency:(NSString *) currency{
    
    return [money reduceToCurrency:currency
                        withBroker:self];
    
}

-(void) addRate:(NSInteger) rate
   fromCurrency:(NSString*)fromCurrency
     toCurrency:(NSString*)toCurrency{
    
    
    [self.rates setObject:@(rate)
                   forKey:[self keyFromCurrency:fromCurrency
                                     toCurrency:toCurrency]];
    NSNumber *invRate =@(1.0/rate);
    [self.rates setObject:invRate
                   forKey:[self keyFromCurrency:toCurrency
                                     toCurrency:fromCurrency]];
    
    
}

-(NSString *) keyFromCurrency:(NSString *) fromCurrency
                   toCurrency:(NSString *) toCurrency{
    
    return [NSString stringWithFormat:@"%@-%@", fromCurrency, toCurrency];
}


@end
