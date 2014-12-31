//
//  MainViewController.m
//  CelebDuel
//
//  Created by Kervins Valcourt on 11/15/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AddFunds.h"
#import "PaymentViewController.h"


@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIBarButtonItem *menuButton;
@property (nonatomic,strong)UIBarButtonItem *addJob;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MainViewController
static NSString *CellIdentifier = @"Cell Identifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    
    self.menuButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.leftBarButtonItem = self.menuButton;
    self.addJob = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"addFunds"] style:UIBarButtonItemStylePlain target:self action:@selector(addFundsFired:)];
    self.navigationItem.rightBarButtonItem = self.addJob;
    
    self.title = @"The OJ";
    [self.view addSubview:self.tableView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"DEMOFirstViewController will appear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"DEMOFirstViewController will disappear");
}



#pragma mark - buttons

- (void)upcomingEventFired:(id)sender {
    PaymentViewController *payment = [[PaymentViewController alloc ]init];
    
    [self.navigationController pushViewController:payment animated:NO];
}

- (void)addFundsFired:(id)sender {
    AddFunds *fundsView = [[AddFunds alloc]init];
    [self presentViewController:fundsView animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource Methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"Fee", @"Type Bet",@"Sort By"];
    cell.textLabel.text = titles[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    
    return cell;
}




@end
