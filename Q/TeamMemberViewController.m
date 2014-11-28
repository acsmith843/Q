//
//  TeamMemberViewController.m
//  Q
//
//  Created by Adam C. Smith on 11/21/14.
//  Copyright (c) 2014 Adam C. Smith. All rights reserved.
//

#import "TeamMemberViewController.h"
#import "TeamMemberCell.h"
#import "TeamMember.h"
#import "UIImageView+AFNetworking.h"
#import "TeamMemberDetailViewController.h"
#import "Utils.h"

@interface TeamMemberViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *teamMemberCollectionView;
@property (strong, nonatomic) NSArray *teamMembers;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *logoBackgroundImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBarButtonItem;
@property (weak, nonatomic) IBOutlet UISearchBar *memberSearchBar;
@property (strong,nonatomic) NSMutableArray *filteredTeamMemberArray;
@property (strong, nonatomic) TeamMember *currentTeamMember;
@end

@implementation TeamMemberViewController

static NSString * const reuseIdentifier = @"teamMemberCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Meet the Team";
    
    _teamMembers = [TeamMember getMockTeamMembers];
    
    _teamMemberCollectionView.delegate = self;
    _teamMemberCollectionView.dataSource = self;
    
    [self setupBackgroundView];
    
    // set up search
    self.filteredTeamMemberArray = [NSMutableArray arrayWithCapacity:[_teamMembers count]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - setup views

- (void) setupBackgroundView {
    
    [Utils makeViewRounded:self.logoBackgroundImage];
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = self.backgroundView.bounds;
    [self.backgroundView addSubview:visualEffectView];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _teamMembers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TeamMemberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    _currentTeamMember = [_teamMembers objectAtIndex:indexPath.row];
    
    cell.firstNameLabel.text = _currentTeamMember.firstName;
    cell.lastNameLabel.text = _currentTeamMember.lastName;
    cell.titleLabel.text = _currentTeamMember.title;
    [cell.profileImage setImageWithURL:[[NSURL alloc] initWithString:_currentTeamMember.imageUrl]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    _currentTeamMember = [_teamMembers objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"memberDetailSegue" sender:self];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGSize mElementSize = CGSizeMake((self.view.frame.size.width / 2), 185);
    return mElementSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
     return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}



#pragma mark - segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"memberDetailSegue"]) {
        
        TeamMemberDetailViewController *dest = (TeamMemberDetailViewController *)[segue destinationViewController];
        [dest setCurrentTeamMember:_currentTeamMember];
    }
}

- (IBAction)searchButtonPressed:(id)sender {
    
    if (_memberSearchBar.frame.origin.y < 50) {
        [self animateView:_teamMemberCollectionView distance:44];
        [self animateView:_memberSearchBar distance:44];
    } else {
        [self animateView:_teamMemberCollectionView distance:-44];
        [self animateView:_memberSearchBar distance:-44];
    }

}

- (void) animateView:(UIView *)view distance:(int)dist {
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^ {
                         CGRect frame = view.frame;
                         frame.origin.y += dist;
                         frame.origin.x = 0;
                         view.frame = frame;
                     }
                     completion:^(BOOL finished)
     {
         NSLog(@"Completed");
     }];
}
@end
