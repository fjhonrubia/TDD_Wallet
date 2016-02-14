//
//  FHLWalletTableViewController.m
//  Wallet
//
//  Created by Fco. Javier Honrubia Lopez on 8/2/16.
//
//

#import "FHLWalletTableViewController.h"
#import "FHLWallet.h"


@interface FHLWalletTableViewController ()

@property (nonatomic, strong) FHLWallet *model;

@end

@implementation FHLWalletTableViewController

-(id) initWithModel:(FHLWallet *) model {
    
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _model = model;
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.model.diferentCurrencies count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model countOfMoneyWithCurrency:[self.model.diferentCurrencies objectAtIndex:section]]+1;
}

@end
