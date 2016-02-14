//
//  FHLMoneyTest.m
//  Wallet
//
//  Created by Fco. Javier Honrubia Lopez on 26/1/16.
//
//

#import <XCTest/XCTest.h>
#import "FHLMoney.h"

@interface FHLMoneyTest : XCTestCase

@end

@implementation FHLMoneyTest

//Test de divisas
-(void) testCurrencies {
    
    XCTAssertEqualObjects(@"EUR", [[FHLMoney euroWithAmount:1] currency], @"The currency of euros should be EUR");
    
    XCTAssertEqualObjects(@"USD", [[FHLMoney dollarWithAmount:1] currency], @"The currency of $1 should be USD");
    
}

//Test de multiplicación
-(void)testMultiplication {
    
    FHLMoney *euro = [FHLMoney euroWithAmount:5];
    FHLMoney *ten = [FHLMoney euroWithAmount:10];
    FHLMoney *total = [euro times:2];
    
    XCTAssertEqualObjects(total, ten, @"€5 * 2 should be €10");
    
}

//Test de igualdad
-(void) testEquality {
    
    FHLMoney *five = [FHLMoney euroWithAmount:5];
    FHLMoney *ten = [FHLMoney euroWithAmount:10];
    FHLMoney *total = [five times:2];
    
    XCTAssertEqualObjects(ten, total, @"Equivalent objects should be equal!");
    XCTAssertEqualObjects([FHLMoney dollarWithAmount:4], [[FHLMoney dollarWithAmount:2] times:2], @"Equivalent objects should be equal!");
    
}

//Test de diferentes divisas
-(void) testDifferentCurrencies {
    
    FHLMoney *euro = [FHLMoney euroWithAmount:1];
    FHLMoney *dollar = [FHLMoney dollarWithAmount:1];
    
    XCTAssertNotEqualObjects(euro, dollar, @"Different currencies should not be equal!");
}

//Test de Hash
-(void) testHash {
    
    FHLMoney *a = [FHLMoney euroWithAmount:2];
    FHLMoney *b = [FHLMoney euroWithAmount:2];
    
    XCTAssertEqual([a hash], [b hash], @"Equal objects must have same hash");
    XCTAssertEqual([[FHLMoney dollarWithAmount:1]hash],
                   [[FHLMoney dollarWithAmount:1] hash], @"Equal objects must have same hash" );
}

//Test de almacenamiento
-(void) testAmountStorage {
    
    FHLMoney *euro = [FHLMoney euroWithAmount:2];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    XCTAssertEqual(2, [[euro performSelector:@selector(amount)]integerValue], @"The value retrieved should be the same as the stored");
    
    XCTAssertEqual(2, [[[FHLMoney dollarWithAmount:2]performSelector:@selector(amount)]integerValue], @"The value retrieved should be the same as the stored");
#pragma clang diagnostic pop
    
    
}

//Test de suma sencilla
-(void) testSimpleAddition {
    
    XCTAssertEqualObjects([[FHLMoney dollarWithAmount:5] plus:
                           [FHLMoney dollarWithAmount:5]],
                          [FHLMoney dollarWithAmount:10],
                          @"$5 + $5 = $10");
    
}

//Test de que amount de Money es igual que su hash
-(void) testThatHashIsAmount {
    
    FHLMoney *one = [FHLMoney dollarWithAmount:1];
    
    XCTAssertEqual([one hash], 1, @"The hash must be the same as the amount");
    
}


//Test de la propiedad description de Money
-(void) testDescription {
    
    FHLMoney *one = [FHLMoney dollarWithAmount:1];
    NSString *desc = @"<FHLMoney: USD 1>";
    
    XCTAssertEqualObjects(desc, [one description], @"Description must match template");
    
}
@end
