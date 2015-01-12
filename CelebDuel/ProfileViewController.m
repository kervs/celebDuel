//
//  ProfileViewController.m
//  CelebDuel
//
//  Created by Kervins Valcourt on 1/10/15.
//  Copyright (c) 2015 EastoftheWestEnd. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()<UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UIButton *takePictureBtn;
@property (strong, nonatomic) IBOutlet UIButton *addPictureBtn;
@property (nonatomic,strong) UIImagePickerController *picker;
@property (assign, nonatomic)BOOL isEditing;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.takePictureBtn.hidden = YES;
    self.addPictureBtn.hidden = YES;
    self.isEditing = NO;
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/1.75;
    self.profileImageView.clipsToBounds = YES;

    
}
- (IBAction)takePictureDidPressed:(id)sender {
    [self.picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:self.picker animated:YES completion:nil];
    
}
- (IBAction)editBtnDidPressed:(id)sender {
    if (self.isEditing == NO) {
        [self.editBtn setTitle:@"Done" forState:UIControlStateNormal];
        self.takePictureBtn.hidden = NO;
        self.addPictureBtn.hidden = NO;
        self.isEditing = YES;
    }else  {
        [self.editBtn setTitle:@"Edit" forState:UIControlStateNormal];
        self.takePictureBtn.hidden = YES;
        self.addPictureBtn.hidden = YES;
        self.isEditing = NO;
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info  {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.profileImageView setImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPictureDidPressed:(id)sender {
    [self.picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.picker animated:YES completion:nil];
    
}
- (IBAction)cancelBtnDidPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
