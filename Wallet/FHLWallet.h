//
//  FHLWallet.h
//  Wallet
//
//  Created by Fco. Javier Honrubia Lopez on 8/2/16.
//
//

#import <Foundation/Foundation.h>
#import "FHLMoney.h"

@interface FHLWallet : NSObject<FHLMoney>

@property (strong,nonatomic) NSMutableOrderedSet * diferentCurrencies;

-(FHLMoney *) getMoneyWithCurrency:(NSString *)currency;
-(void) addMoney:(FHLMoney *)money;
-(void) takeMoney:(FHLMoney *)money;

-(NSInteger) countOfMoneyWithCurrency:(NSString *)currency;

@end
