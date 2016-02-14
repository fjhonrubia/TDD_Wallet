//
//  FHLWalletTest.m
//  Wallet
//
//  Created by Fco. Javier Honrubia Lopez on 8/2/16.
//
//

#import <XCTest/XCTest.h>
#import "FHLMoney.h"
#import "FHLBroker.h"
#import "FHLWallet.h"

@interface FHLWalletTest : XCTestCase

@property (nonatomic, strong) FHLWallet *wallet;

@end

@implementation FHLWalletTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.wallet = [[FHLWallet alloc] initWithAmount:40 currency:@"EUR"];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.wallet = nil;
    
}

// Test de suma entre diferentes divisas (€40 + $20 = $100) con un ration de conversión 2:1
-(void) testAdditionWithReduction {
    
    FHLBroker *broker = [FHLBroker new];
    [broker addRate: 2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    [self.wallet plus: [FHLMoney dollarWithAmount:20]];
    
    FHLMoney *reduced = [broker reduce:self.wallet toCurrency:@"USD"];
    
    XCTAssertEqualObjects(reduced, [FHLMoney dollarWithAmount:100], @"€40 + $20 = $100 2:1");
    
}

//Test de igualdad
-(void) testGetMoneyWithCurrencyIsOK {
    
    [self.wallet plus: [FHLMoney dollarWithAmount:20]];
    FHLMoney *euros = [self.wallet getMoneyWithCurrency: @"EUR"];
    
    XCTAssertEqualObjects(euros, [FHLMoney euroWithAmount:40], @"€40");
    
}

-(void) testGetMoneyWithCurrencyIsKO {
    
    [self.wallet plus: [FHLMoney dollarWithAmount:20]];
    FHLMoney *euros = [self.wallet getMoneyWithCurrency: @"USD"];
    
    XCTAssertNotEqualObjects(euros, [FHLMoney euroWithAmount:40], @"€40");
    
}

//Test de suma de Moneys a una divisa existente
-(void) testAddMoneyToExistingCurrency {
    
    [self.wallet addMoney:[FHLMoney euroWithAmount:20]];
    FHLMoney *euros = [self.wallet getMoneyWithCurrency: @"EUR"];
    
    XCTAssertEqualObjects(euros,[FHLMoney euroWithAmount:60] , @"40€+20€ = 60€");
}


//Test de suma de Moneys cuando no existen divisas
-(void) testAddMoneyToNoExistingCurrency {
    
    [self.wallet addMoney:[FHLMoney dollarWithAmount:20]];
    FHLMoney *dollars = [self.wallet getMoneyWithCurrency: @"USD"];
    
    XCTAssertEqualObjects(dollars,[FHLMoney dollarWithAmount:20] , @"$0+$20 = 20$");
}

//Test de resta de Moneys a una divisa existente
-(void) testTakeMoneyToExistingCurrency {
    
    [self.wallet takeMoney:[FHLMoney euroWithAmount:20]];
    FHLMoney *euros = [self.wallet getMoneyWithCurrency: @"EUR"];
    
    XCTAssertEqualObjects(euros,[FHLMoney euroWithAmount:20] , @"40€+20€ = 60€");
}


//Test de resta de Moneys cuando no eisten divisas
-(void) testAddTakeoNoExistingCurrency {
    
    [self.wallet takeMoney:[FHLMoney dollarWithAmount:20]];
    FHLMoney *dollars = [self.wallet getMoneyWithCurrency: @"USD"];
    
    XCTAssertEqualObjects(dollars,[FHLMoney dollarWithAmount:-20] , @"$0+$20 = 20$");
}

//Test que obtener el número de dólares del wallet
-(void) testCountOfDollars {
    
    self.wallet = [[FHLWallet alloc] initWithAmount:40 currency:@"USD"];
    [self.wallet takeMoney:[FHLMoney dollarWithAmount:20]];
    NSInteger count = [self.wallet countOfMoneyWithCurrency:@"USD"];
    NSInteger a = [[NSNumber numberWithInt:2]integerValue] ;
    NSInteger b = [[NSNumber numberWithInt:4]integerValue] ;
    
    XCTAssertEqual(count,a,@"count of dollars = 2");
    XCTAssertNotEqual(count,b,@"count of dollars != 4");
    
}

//Test de divisas sin duplicados
-(void) testCurrenciesWithoutDuplicates {
    
    [self.wallet addMoney:[FHLMoney dollarWithAmount:20]];
    [self.wallet addMoney:[FHLMoney dollarWithAmount:20]];
    [self.wallet addMoney:[FHLMoney euroWithAmount:20]];
    
    XCTAssertEqual(self.wallet.diferentCurrencies.count,2,@"number of currencies = 2");
    
}

@end
