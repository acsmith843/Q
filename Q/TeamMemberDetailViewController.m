//
//  TeamMemberDetailViewController.m
//  Q
//
//  Created by Adam C. Smith on 11/21/14.
//  Copyright (c) 2014 Adam C. Smith. All rights reserved.
//

#import "TeamMemberDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Utils.h"
#import "TeamMember.h"
#import "TeamMemberBioCell.h"
#import "TeamMemberSpecialtiesCell.h"

@interface TeamMemberDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *logoBackgroundImage;

//header view
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;

//table view
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TeamMemberDetailViewController

static NSString * const bioIdentifier = @"bioCell";
static NSString * const specialitiesIdentifier = @"specialtiesCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _currentTeamMember.firstName;
    
    [self setupBackgroundView];
    [self setupHeaderView];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - setup views

- (void) setupBackgroundView {
    
    [Utils makeViewRounded:self.logoBackgroundImage];
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = self.backgroundView.bounds;
    [self.backgroundView addSubview:visualEffectView];
}

- (void) setupHeaderView {
    
    _headerView.layer.borderWidth = 1.0f;
    _headerView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    _logoImage.image = [UIImage imageNamed:@"Q.png"];
    [Utils makeViewRounded:_logoImage];
    
    [_profileImage setImageWithURL:[[NSURL alloc] initWithString:_currentTeamMember.imageUrl]];
    [Utils makeViewRounded:_profileImage];
    
    _fullName.text = [NSString stringWithFormat:@"%@ %@", _currentTeamMember.firstName, _currentTeamMember.lastName];
    _titleLabel.text = _currentTeamMember.title;
}

- (void) setupTableView {
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.estimatedRowHeight = 44.0;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}



#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        TeamMemberBioCell *cell = [tableView dequeueReusableCellWithIdentifier:bioIdentifier];
        if (cell == nil) {
            cell = [[TeamMemberBioCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:bioIdentifier];
        }
        
        cell.bioLabel.text = _currentTeamMember.bio;
        
        return cell;
        
    } else {
       
        TeamMemberSpecialtiesCell *cell = [tableView dequeueReusableCellWithIdentifier:specialitiesIdentifier];
        if (cell == nil) {
            cell = [[TeamMemberSpecialtiesCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:specialitiesIdentifier];
        }
        
        [cell.tagListView addTags:_currentTeamMember.specialties andRearrange:YES];
        
        return cell;
    }
}

#pragma mark - UITableView delegate

// TODO


#pragma mark - button actions

- (IBAction)emailButtonPressed:(id)sender {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:[NSString stringWithFormat:@"%@ %@", _currentTeamMember.firstName, _currentTeamMember.lastName]
                                          message:_currentTeamMember.emailAddress
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    UIAlertAction *emailAction = [UIAlertAction
                               actionWithTitle:@"Email"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"Email action");
                                   [self sendMail];
                               }];
    
    [alertController addAction:emailAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)phoneButtonPressed:(id)sender {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:[NSString stringWithFormat:@"%@ %@", _currentTeamMember.firstName, _currentTeamMember.lastName]
                                          message:_currentTeamMember.phoneNumber
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *callAction = [UIAlertAction
                                 actionWithTitle:@"Call"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action)
                                 {
                                     NSLog(@"Call action");
                                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", _currentTeamMember.phoneNumber]]];
                                 }];
    
    UIAlertAction *addToContactsAction = [UIAlertAction
                                    actionWithTitle:@"Add To Contacts"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        NSLog(@"Add action");
                                    }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    [alertController addAction:callAction];
    [alertController addAction:addToContactsAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - mail methods

-(void) sendMail {
    
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    
    [mailComposer setToRecipients:[NSArray arrayWithObjects:_currentTeamMember.emailAddress, nil]];
    
    [self presentViewController:mailComposer animated:YES completion:nil];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    if (result) {
        NSLog(@"Result : %d",result);
    }
    
    if (error) {
        NSLog(@"Error sending email: %@", error);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
