//
//  FirstViewController.m
//  TabBarExampleApp
//
//  Created by Ezequiel on 12/19/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

#import "FirstViewController.h"
#import "MessageFirstViewController.h"
#import "MessageSecondViewController.h"
#import "TabBarExampleApp-Swift.h"
#import "IASKAppSettingsViewController.h"

#define MAIL_BODY_MSG @"sup bud?!"
#define MAIL_SUBJ_MSG @"Hallo there!"
#define MAIL_REC_ADDRESS1 @"nicolas.palmieri@globant.com" 
#define MAIL_REC_ADDRESS2 @"ezequiel.munz@globant.com"

NSString* const CELL_ID = @"Cell";

typedef enum
{
    MESSAGES = 0,
    CREDITS,
    
} CellIdentifierWea;

typedef enum
{
    SETTINGS = 0,
    DATA,
    INFORMATION,
    CONTACT_US
    
} CellIdentifierInfo;

typedef enum
{
    WEA = 0,
    INFO
    
} TableSections;

@interface FirstViewController ()

@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, strong) NSArray* dataWea;
@property (nonatomic, strong) NSArray* dataInfo;
@property (nonatomic, strong) NSArray* dataRecipients;

@property (strong, nonatomic) MFMailComposeViewController *correo;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataWea = @[@"Messages" ,@"Credits"];
    self.dataInfo = @[@"Settings", @"Data", @"Information", @"Contact Us"];
    self.dataRecipients = @[MAIL_REC_ADDRESS1, MAIL_REC_ADDRESS2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TableSections idSection = (TableSections)section;
    switch (idSection) {
        case WEA:
            return 2;
            break;
        case INFO:
            return 4;
            break;
        default:
            break;
    }
    //return self.data.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TableSections idSection = (TableSections)section;
    switch (idSection) {
        case WEA:
            return @"Wea";
            break;
        case INFO:
            return @"Info";
            break;
        default:
            break;
    }

}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView* headerView = (UITableViewHeaderFooterView*)view;
    [headerView setTintColor:[UIColor blackColor]];
    [headerView setAlpha:0.6f];
    [headerView.textLabel setTextColor:[UIColor whiteColor]];
    
    TableSections idSection = (TableSections)section;
    switch (idSection) {
        case WEA:
            [headerView.textLabel setText:@"WEA"];
            break;
        case INFO:
            [headerView.textLabel setText:@"INFO"];
            break;
        default:
            break;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID];
    }
    
    switch (indexPath.section) {
        case WEA:
            cell.textLabel.text = (NSString*)self.dataWea[indexPath.row];
            break;
        case INFO:
            cell.textLabel.text = (NSString*)self.dataInfo[indexPath.row];
            break;
        default:
            break;
    }
    
    NSLog(@"%ld", (long)indexPath.row);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableSections idSection = (TableSections)indexPath.section;
    MyCreditsViewController* view;
    IASKAppSettingsViewController* modal;
    
    switch (idSection) {
        case WEA:
            switch (indexPath.row)
            {
                case MESSAGES:
                    [self instantiateViewControllerId:@"part1" inStoryboard:@"Messages"];
                break;
                case CREDITS:
                    //[self instantiateViewControllerId:@"part2" inStoryboard:@"Messages"];
                    view = [[MyCreditsViewController alloc] initWithNibName:@"MyCreditsViewController" bundle:[NSBundle mainBundle]];
                    [self.navigationController pushViewController:view animated:YES];
                break;
            }
            break;
        case INFO:
            switch (indexPath.row) {
                case SETTINGS:
                    modal = [[IASKAppSettingsViewController alloc] initWithStyle: UITableViewStyleGrouped];
                    [self.navigationController presentViewController:modal animated:YES completion:nil];
                    [self performSelector: @selector(discardModal) withObject:nil afterDelay: 5.0f];
                    //[self showAlertViewWithTitle:@"SETTINGS" andMessage:@"Put your settings here" andCancelButton:@"Yes SIR"];
                    break;
                case DATA:
                    
                    [self showAlertViewWithTitle:@"DATA" andMessage:@"Put your data here" andCancelButton:@"Yes SIR"];
                    break;
                case INFORMATION:
                    [self instantiateViewControllerId:@"ContactsList" inStoryboard:@"Contacts"];
                    break;
                case CONTACT_US:
                    [self showMail];
                    break;
            }
            break;
    }
}

- (void) discardModal
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) instantiateViewControllerId: (NSString*)identifier inStoryboard: (NSString*)storyboard
{
    UIStoryboard *story;
    UIViewController *view;
    
    story = [UIStoryboard storyboardWithName:storyboard bundle:[NSBundle mainBundle]];
    view = (MessageFirstViewController*)[story instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - AlertView struct
- (void) showAlertViewWithTitle: (NSString*)title andMessage: (NSString*)message andCancelButton: (NSString*)cancel
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancel otherButtonTitles:nil, nil] show];
}

#pragma mark - Mail
-(void)showMail
{
    MFMailComposeViewController *correo = [[MFMailComposeViewController alloc] init];
    correo.mailComposeDelegate = self;
    
    //Subject
    NSString *mailSubj = [[NSString alloc] initWithFormat:MAIL_SUBJ_MSG];
    [correo setSubject:mailSubj];
    
    //BodyText
    NSString *mailBody = [[NSString alloc] initWithFormat:MAIL_BODY_MSG];
    [correo setMessageBody:mailBody isHTML:NO];
    
    //To
    [correo setToRecipients:[NSArray arrayWithArray:self.dataRecipients]];
    
    //Interface
    [self presentViewController:correo animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultSent:
            [self showAlertViewWithTitle:@"STATUS!" andMessage:@"Message sended!" andCancelButton:@"OKey"];
            break;
            
        case MFMailComposeResultSaved:
            [self showAlertViewWithTitle:@"STATUS!" andMessage:@"Message stored!" andCancelButton:@"OKey"];
            break;
            
        case MFMailComposeResultCancelled:
            [self showAlertViewWithTitle:@"STATUS!" andMessage:@"Message cancelled!" andCancelButton:@"OKey"];
            break;
            
        case MFMailComposeResultFailed:
            [self showAlertViewWithTitle:@"STATUS!" andMessage:@"Compose ERROR!" andCancelButton:@"OKey"];
            break;
            
        default:
            [self showAlertViewWithTitle:@"STATUS!" andMessage:@"ERROR DEF!" andCancelButton:@"OKey"];
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
