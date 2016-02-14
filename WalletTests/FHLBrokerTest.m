//
//  FHLBrokerTest.m
//  Wallet
//
//  Created by Fco. Javier Honrubia Lopez on 8/2/16.
//
//

#import <XCTest/XCTest.h>
#import "FHLMoney.h"
#import "FHLBroker.h"

@interface FHLBrokerTest : XCTestCase

@property (nonatomic, strong) FHLBroker *emptyBroker;
@property (nonatomic, strong) FHLMoney *oneDollar;

@end

@implementation FHLBrokerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.emptyBroker = [FHLBroker new];
    self.oneDollar = [FHLMoney dollarWithAmount:1];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.emptyBroker = nil;
    self.oneDollar = nil;
}

//Test de una conversión simple entre divisas
-(void) testSimpleReduction {
    
    
    FHLMoney *sum = [[FHLMoney dollarWithAmount:5] plus:[FHLMoney dollarWithAmount:5]];
    FHLMoney *reduced = [self.emptyBroker reduce: sum toCurrency: @"USD"];
    
    XCTAssertEqualObjects(sum, reduced, @"Conversion to same currency should be a NOP");
    
}

// Test de que $10 == €5 con un ratio de conversión 2:1
-(void) testReduction {
    
    [self.emptyBroker addRate: 2 fromCurrency:@"EUR" toCurrency:@"USD"];
    FHLMoney *dollars = [FHLMoney dollarWithAmount:10];
    FHLMoney *euros = [FHLMoney euroWithAmount:5];
    FHLMoney *converted = [self.emptyBroker reduce:dollars toCurrency:@"EUR"];
    
    XCTAssertEqualObjects(converted, euros, @"$10 == €5 2:1");
    
}

//Test de que si no hay cambio se lanza una excepción
-(void) testThatNoRateRaisesException {
    
    XCTAssertThrows([self.emptyBroker reduce:self.oneDollar toCurrency:@"EUR"],
                    @"No rates should cause exception");
    
}

//Test de que una conversión nil no debería hacer nada
-(void) testThatNilConversionDoesNotChangeMoney {
    
    XCTAssertEqualObjects(self.oneDollar,
                          [self.emptyBroker reduce:self.oneDollar
                                        toCurrency:@"USD"],
                          @"Nil conversion should have no effect");
}

@end
