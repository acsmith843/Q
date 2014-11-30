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
@property (strong, nonatomic) NSMutableArray *teamMemberArray;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *logoBackgroundImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBarButtonItem;
@property (strong,nonatomic) NSMutableArray *filteredTeamMemberArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) TeamMember *currentTeamMember;
@property BOOL isFiltered;
@end

@implementation TeamMemberViewController

static NSString * const reuseIdentifier = @"teamMemberCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Meet the Team";
    
    _teamMemberArray = [TeamMember getMockTeamMembers];
    
    _teamMemberCollectionView.delegate = self;
    _teamMemberCollectionView.dataSource = self;
    
    _searchBar.delegate = self;
    
    [self setupBackgroundView];
    
    // set up search
    _filteredTeamMemberArray = [NSMutableArray arrayWithCapacity:[_teamMemberArray count]];
    _isFiltered = NO;
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
    
    if (_isFiltered) {
        return [_filteredTeamMemberArray count];
    } else {
        return [_teamMemberArray count];
    }

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TeamMemberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Check to see whether the normal table or search results table is being displayed and set the object from the appropriate array
    if (_searchBar.text.length > 0) {
        _currentTeamMember = [_filteredTeamMemberArray objectAtIndex:indexPath.row];
    } else {
        _currentTeamMember = [_teamMemberArray objectAtIndex:indexPath.row];
    }
    
    cell.firstNameLabel.text = _currentTeamMember.firstName;
    cell.lastNameLabel.text = _currentTeamMember.lastName;
    cell.titleLabel.text = _currentTeamMember.title;
    [cell.profileImage setImageWithURL:[[NSURL alloc] initWithString:_currentTeamMember.imageUrl]];
    
    return cell;
}



#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    _currentTeamMember = [_teamMemberArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"memberDetailSegue" sender:self];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGSize mElementSize = CGSizeMake(((self.view.frame.size.width / 2) - 1), 185);
    return mElementSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
     return UIEdgeInsetsMake(.5,.5,0,.5);  // top, left, bottom, right
}



#pragma mark - segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"memberDetailSegue"]) {
        
        TeamMemberDetailViewController *dest = (TeamMemberDetailViewController *)[segue destinationViewController];
        [dest setCurrentTeamMember:_currentTeamMember];
    }
}



#pragma mark - button actions

- (IBAction)searchButtonPressed:(id)sender {
    
    if (_searchBar.frame.origin.y < 50) {
        [self animateView:_teamMemberCollectionView distance:44];
        [self animateView:_searchBar distance:44];
    } else {
        [self animateView:_teamMemberCollectionView distance:-44];
        [self animateView:_searchBar distance:-44];
    }

}



#pragma mark - animations

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



#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length > 0) {
        
        // Update the filtered array based on the search text and scope.
        // Remove all objects from the filtered search array
        [_filteredTeamMemberArray removeAllObjects];
        
        // Filter the array using NSPredicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.firstName contains[c] %@) OR (SELF.lastName contains[c] %@)", searchText, searchText];
        
        _filteredTeamMemberArray = [NSMutableArray arrayWithArray:[_teamMemberArray filteredArrayUsingPredicate:predicate]];
        
        _isFiltered = YES;
        
    } else {
        
        _isFiltered = NO;
    }
    
    [self.teamMemberCollectionView reloadData];
}

@end
