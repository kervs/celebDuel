//
//  MainViewController.m
//  CelebDuel
//
//  Created by Kervins Valcourt on 11/15/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,strong)UIToolbar *toolBar;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UIBarButtonItem *addFunds;
@property (nonatomic,strong)UIBarButtonItem *menuButton;
@property (nonatomic,strong)UIBarButtonItem *upComingEvent;
@property (nonatomic,strong)UIBarButtonItem *liveEvent;
@property (nonatomic,strong)UIBarButtonItem *history;
@property (nonatomic,strong)UIBarButtonItem *filters;
@end

@implementation MainViewController
static NSString *CellIdentifier = @"Cell Identifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.addFunds = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"addFunds"] style:UIBarButtonItemStylePlain target:self action:@selector(addFundsFired:)];
    
    self.upComingEvent = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"upcoming"] style:UIBarButtonItemStylePlain target:self action:@selector(upcomingEventFired:)];
    
    self.liveEvent = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"live"] style:UIBarButtonItemStylePlain target:self action:@selector(liveEventFired:)];
    
    self.history = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"history"] style:UIBarButtonItemStylePlain target:self action:@selector(historyEventFired:)];
    
     UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    NSArray *itemsArray = [NSArray arrayWithObjects:_addFunds,flexButton, _upComingEvent,flexButton,_liveEvent,flexButton,_history, nil];
    
    
    
    

    

    
    
    
    self.menuButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.leftBarButtonItem = self.menuButton;
    
    self.filters = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"filters"] style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
    self.navigationItem.rightBarButtonItem = self.filters;
    
   
    self.toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    self.toolBar.backgroundColor = [UIColor redColor];
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame) -44 ) collectionViewLayout:layout];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.title = @"CelebDuel";
    
    
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    
    
    [self.view addSubview:_toolBar];
    [self.toolBar setItems:itemsArray];
    [self.view addSubview:_collectionView];
    
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


#pragma mark - UICollectionViewDataSource Methods


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor greenColor];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0; // This is the minimum inter item spacing, can be more
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2, 300);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
