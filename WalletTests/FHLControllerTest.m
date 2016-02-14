//
//  FHLControllerTest.m
//  Wallet
//
//  Created by Fco. Javier Honrubia Lopez on 8/2/16.
//
//

#import <XCTest/XCTest.h>
#import "FHLWalletTableViewController.h"
#import "FHLWallet.h"

@interface FHLControllerTest : XCTestCase

@property (nonatomic, strong) FHLWalletTableViewController *walletVC;
@property (nonatomic, strong) FHLWallet *wallet;

@end

@implementation FHLControllerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.wallet = [[FHLWallet alloc] initWithAmount:1 currency:@"USD"];
    [self.wallet addMoney:[FHLMoney euroWithAmount:1]];
    
    self.walletVC = [[FHLWalletTableViewController alloc] initWithModel:self.wallet];
}

//Test que comprueba que una tabla tiene 3 secciones (el número de divisas diferentes (EUR + USD) + 1)
-(void) testThatTablehasOneSectionPorCurrency{
    
    NSInteger sections = [self.walletVC numberOfSectionsInTableView:nil];
    
    XCTAssertEqual(sections, 3, @"Number of section is the number of diferente Currencies (USD + EUR) + 1");
    
    
}

//Test que comprueba que el número de celdas de una sección es el número de Moneys + 1
-(void) testThatNumberOfCellsIsNumberOfMoneysOfOneCurrencyPlusOne{
    
    [self.wallet addMoney:[FHLMoney dollarWithAmount:2]];
    
    XCTAssertEqual(3, [self.walletVC tableView:nil numberOfRowsInSection:0], @"Number of cells is the number of moneys + 1");
    
}

@end
