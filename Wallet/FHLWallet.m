//
//  FHLWallet.m
//  Wallet
//
//  Created by Fco. Javier Honrubia Lopez on 8/2/16.
//
//

#import "FHLWallet.h"

@interface FHLWallet ()

@property (nonatomic, strong) NSMutableArray *moneys;

@end

@implementation FHLWallet

-(id) initWithAmount:(NSInteger) amount  currency:(NSString *) currency{
    
    if (self = [super init]) {
        FHLMoney *money = [[FHLMoney alloc] initWithAmount:amount currency: currency];
        _moneys = [NSMutableArray array];
        [_moneys addObject: money];
        
        _diferentCurrencies = [NSMutableOrderedSet new];
        [_diferentCurrencies addObject:money.currency];
        
    }
    return self;
    
}

-(id<FHLMoney>)plus:(FHLMoney *)money{
    
    [self.moneys addObject: money];
    return self;
    
}

-(id<FHLMoney>) times:(NSInteger) multiplier{
    
    NSMutableArray *newMoneys = [NSMutableArray arrayWithCapacity: self.moneys.count];
    
    for (FHLMoney *each in self.moneys) {
        
        FHLMoney *newMoney = [each times:multiplier];
        [newMoneys addObject: newMoney];
    }
    self.moneys = newMoneys;
    return self;
    
}


-(id<FHLMoney>) reduceToCurrency:(NSString*) currency
                      withBroker:(FHLBroker*) broker{
    
    FHLMoney *result = [[FHLMoney alloc] initWithAmount:0 currency:currency];
    
    for (FHLMoney *each in self.moneys) {
        result = [result plus:[each reduceToCurrency:currency withBroker:broker]];
    }
    
    return result;
    
}

-(FHLMoney *) getMoneyWithCurrency:(NSString *)currency
{
    
    FHLMoney *totalMoneyWithCurrency = [[FHLMoney alloc]initWithAmount:0 currency:currency];
    for (FHLMoney *each in self.moneys)
    {
        if ([each.currency isEqualToString:currency])
        {
            totalMoneyWithCurrency = [totalMoneyWithCurrency plus:each];
        }
    }
    return totalMoneyWithCurrency;
    
}

-(NSInteger) countOfMoneyWithCurrency:(NSString *)currency
{
    
    long totalCountOfMoneyWithCurrency = 0;
    
    for (FHLMoney *each in self.moneys)
    {
        if ([each.currency isEqualToString:currency])
        {
            totalCountOfMoneyWithCurrency++;
        }
    }
    
    return (NSInteger) totalCountOfMoneyWithCurrency;
    
}

-(void) addMoney:(FHLMoney *)money
{
    
    [self.moneys addObject:money];
    [self.diferentCurrencies addObject:money.currency];
    
}

-(void)takeMoney:(FHLMoney *)money
{
    
    FHLMoney *newMoney = [[FHLMoney alloc]initWithAmount:(0 - [money.amount integerValue]) currency:money.currency] ;
    
    [self addMoney:newMoney];
}

@end
