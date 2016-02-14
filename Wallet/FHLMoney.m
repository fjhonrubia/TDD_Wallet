//
//  FHLMoney.m
//  Wallet
//
//  Created by Fco. Javier Honrubia Lopez on 26/1/16.
//
//

#import "FHLMoney.h"
#import "FHLBroker.h"

@interface FHLMoney()

@property (nonatomic, strong) NSNumber *amount;

@end

@implementation FHLMoney

+(id)euroWithAmount:(NSInteger) amount {
    return [[FHLMoney alloc] initWithAmount:amount currency:@"EUR"];
}

+(id)dollarWithAmount:(NSInteger)amount{
    return [[FHLMoney alloc] initWithAmount:amount currency:@"USD"];
}

-(id)initWithAmount:(NSInteger)amount currency:(NSString *)currency{
    
    if (self = [super init]) {
        _amount = @(amount);
        _currency = currency;
    }
    return self;
    
}

-(id<FHLMoney>) times:(NSInteger) multiplier{
    
    FHLMoney *newMoney = [[FHLMoney alloc]
                          initWithAmount:[self.amount integerValue] * multiplier currency:self.currency] ;
    
    return newMoney;
    
}

-(id<FHLMoney>) plus:(FHLMoney *) other{
    
    NSInteger totalAmount = [self.amount integerValue] +
    [other.amount integerValue];
    
    FHLMoney *total = [[FHLMoney alloc] initWithAmount:totalAmount
                                              currency:self.currency];
    
    return total;
    
}

-(id<FHLMoney>) reduceToCurrency:(NSString*) currency
                      withBroker:(FHLBroker*) broker{
    
    
    FHLMoney *result;
    double rate = [[broker.rates
                    objectForKey:[broker keyFromCurrency:self.currency
                                              toCurrency:currency]] doubleValue];
    
    // Comprobación que las divisas de origen y destino son las mismas
    if ([self.currency isEqual:currency]) {
        result = self;
    }else if (rate == 0){
        // NO hay tasa de conversión
        [NSException raise:@"NoConversionRateException"
                    format:@"Must have a conversion from %@ to %@", self.currency, currency];
        
    }else{
        // Conversión
        NSInteger newAmount = [self.amount integerValue] * rate;
        
        result = [[FHLMoney alloc]
                  initWithAmount:newAmount
                  currency:currency];
        
    }
    
    
    return result;
    
}

-(NSString *) description{
    
    return [NSString stringWithFormat:@"<%@: %@ %@>",
            [self class],self.currency, self.amount];
    
}

-(BOOL)isEqual:(id)object{
    
    if ([self.currency isEqual:[object currency]]) {
        return [self. amount isEqual: [object amount]];
    }else{
        return NO;
    }
    
}

-(NSUInteger) hash{
    
    return [self.amount integerValue];
}

@end
