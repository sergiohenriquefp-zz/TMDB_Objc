//
//  SearchViewController.m
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize tableView = _tableView;
@synthesize listRecent = _listRecent;
@synthesize listSearch = _listSearch;
@synthesize pullView = _pullView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pageNumberRecent = 1;
    isUsingServicesRecent = NO;
    reachEndRecent = NO;
    
    pageNumberSearch = 1;
    isUsingServicesSearch = NO;
    reachEndSearch = NO;
    
    self.isFirstTime = YES;
    
    self.listSearch = [NSMutableArray array];
    self.listRecent = [NSMutableArray array];
    
    headerSearchCell = [self.tableView dequeueReusableCellWithIdentifier:@"HeaderSearchCell"];
    headerSearchCell.contentView.autoresizingMask = UIViewAutoresizingNone;
    [headerSearchCell populate];
    [headerSearchCell setDelegate:self];
    
    notifications = [[NSMutableArray alloc] init];
    id n1 = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        hasKeyBoard = YES;
        [self searchWithText:headerSearchCell.tfSearch.text];
    }];
    [notifications addObject:n1];
    
    id n2 = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        hasKeyBoard = NO;
        [self searchWithText:headerSearchCell.tfSearch.text];
    }];
    [notifications addObject:n2];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setTintColor:kGrayColor];
    [refreshControl setBackgroundColor:self.tableView.backgroundColor];
    [refreshControl addTarget:self action:@selector(callInitialPage) forControlEvents:UIControlEventValueChanged];
    [self setPullView:refreshControl];
    [self.tableView addSubview:refreshControl];
    
    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(40.0, 0, 0, 0)];
    
    self.tableView.tableFooterView = [UIView new];
    [self reloadTable];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if (self.isFirstTime) {
        self.isFirstTime = false;
        [self callInitialPage];
    }
}

- (IBAction)backToNormal:(id)sender {
    
    [headerSearchCell clearClicked:self];
    [headerSearchCell.tfSearch resignFirstResponder];
}

- (void)searchWithText:(NSString *)text{
    
    if ([text isEqualToString:@""]) {
        [self.listSearch removeAllObjects];
        if (self.listRecent.count > 0) {
            [self.vBack setBackgroundColor:kGrayBackTable];
        }
        else{
            [self.vBack setBackgroundColor:[UIColor whiteColor]];
        }
    }
    else{
        [self.vBack setBackgroundColor:[UIColor whiteColor]];
    }
    
    [self reloadTable];
    [self callInitialPageSearch];
}

- (void)callInitialPage{
    
    if ([headerSearchCell.tfSearch.text isEqualToString:@""]) {
        
        if (!hasKeyBoard) {
            [self callInitialPageRecent];
        }
    }
    else{
        [self callInitialPageSearch];
    }
}

- (void)callWithPage{
    
    if ([headerSearchCell.tfSearch.text isEqualToString:@""]) {
        
        if (!hasKeyBoard) {
            [self callWithPageRecent];
        }
    }
    else{
        [self callWithPageSearch];
    }
}

- (void)callInitialPageSearch{
    
    if(![headerSearchCell.tfSearch.text isEqualToString:@""]){
        
        isUsingServicesSearch = NO;
        reachEndSearch = NO;
        pageNumberSearch = 1;
        [self callWithPageSearch];
    }
}

- (void)callWithPageSearch{
    
    if (!isUsingServicesSearch && !reachEndSearch) {
        //atualiza da internet
        if ([self connected]) {
            
            isUsingServicesSearch = true;
            
            if(pageNumberSearch > 1){
                [self showFooter:YES];
            }
            else{
                
                if (self.listSearch.count == 0) {
                    [self.tableView reloadData];
                    self.tableView.contentOffset = CGPointMake(0, 0);
                }
            }
            
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:pageNumberSearch],@"page",headerSearchCell.tfSearch.text,@"query", nil];
            
            [[API sharedClient] GET:kILMovieDBSearchMovie parameters:params block:^(id responseObject, NSError *error) {
                if (!error) {
                    if (![@"" isEqualToString:headerSearchCell.tfSearch.text]) {
                        
                        NSArray * array = responseObject[@"results"];
                        
                        if (pageNumberSearch == 1) {
                            self.listSearch = [Movie getListJson:array];
                            [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
                        }
                        else{
                            [self.listSearch addObjectsFromArray:[Movie getListJson:array]];
                        }
                        
                        if ([[Movie getListJson:array] count] > 0) {
                            pageNumberSearch++;
                        }
                        else if(self.listSearch.count == 0){
                            pageNumberSearch = 0;
                        }
                        
                        if ([[Movie getListJson:array] count] == 0) {
                            reachEndSearch = YES;
                        }
                        
                        [self showFooter:NO];
                        isUsingServicesSearch = false;
                        if ([self.pullView isRefreshing]) {
                            [self.tableView reloadData];
                        }
                        else{
                            [self reloadTable];
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[self pullView] endRefreshing];
                        });
                    }

                }
                else{
                    [self showFooter:NO];
                    isUsingServicesSearch = false;
                    [self.tableView reloadData];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[self pullView] endRefreshing];
                    });
                    [self callErrorMessageWithText:nil detail:@"Error"];
                }
            }];
            
            
        }
        else{
            isUsingServicesSearch = false;
            [self.tableView reloadData];
            [self.pullView endRefreshing];
            [self callErrorMessageWithText:nil detail:@"No Internet!"];
        }
    }
}

- (void)callInitialPageRecent{
    
    reachEndRecent = NO;
    pageNumberRecent = 1;
    [self callWithPageRecent];
}

- (void)callWithPageRecent{
    
    if (!isUsingServicesRecent && !reachEndRecent) {
        //atualiza da internet
        if ([self connected]) {
            
            isUsingServicesRecent = true;
            
            if(pageNumberRecent > 1){
                [self showFooter:YES];
            }
            else{
                
                if (self.listRecent.count == 0) {
                    [self.tableView reloadData];
                }
            }
            
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:pageNumberRecent],@"page",@"genres", @"append_to_response", nil];
            
            [[API sharedClient] GET:kILMovieDBMovieUpcoming parameters:params block:^(id responseObject, NSError *error) {
                if (!error) {
                    NSArray * array = responseObject[@"results"];
                    
                    if (pageNumberRecent == 1) {
                        self.listRecent = [Movie getListJson:array];
                    }
                    else{
                        [self.listRecent addObjectsFromArray:[Movie getListJson:array]];
                    }
                    
                    if ([[Movie getListJson:array] count] > 0) {
                        pageNumberRecent++;
                    }
                    else if(self.listRecent.count == 0){
                        pageNumberRecent = 0;
                    }
                    
                    if ([[Movie getListJson:array] count] == 0) {
                        reachEndRecent = YES;
                    }
                    
                    [self showFooter:NO];
                    isUsingServicesRecent = false;
                    if ([self.pullView isRefreshing]) {
                        [self.tableView reloadData];
                    }
                    else{
                        [self reloadTable];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[self pullView] endRefreshing];
                    });
                    
                }
                else{
                    [self showFooter:NO];
                    isUsingServicesRecent = false;
                    [self.tableView reloadData];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[self pullView] endRefreshing];
                    });
                    [self callErrorMessageWithText:nil detail:@"Error"];
                }
            }];

        }
        else{
            isUsingServicesSearch = false;
            [self.tableView reloadData];
            [self.pullView endRefreshing];
            [self callErrorMessageWithText:nil detail:@"No Internet!"];
        }
    }
}

- (void)clickedMovie:(Movie *)movie{
    
    [self goToMovie:movie];
}

- (void)reloadTable{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.tableView
                          duration:0.1f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^(void) {
                            [self.tableView reloadData];
                        } completion:NULL];
    });
}

#pragma mark -
#pragma mark Table view creation (UITableViewDataSource)

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    float reload_distance = -10.0;
    
    if(y > h + reload_distance && offset.y > 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self callWithPage];
        });
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView willDecelerate:(BOOL)decelerate {
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = -10.0;
    
    if(y > h + reload_distance && offset.y > 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self callWithPage];
        });
    }
}


- (void)showFooter:(BOOL)show{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (show) {
            
            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [spinner setColor:kGrayColor];
            CGRect frame = spinner.frame;
            frame.size.height = 50;
            [spinner setFrame:frame];
            [spinner startAnimating];
            self.tableView.tableFooterView = spinner;
        }
        else{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                if ((![headerSearchCell.tfSearch.text isEqualToString:@""] && reachEndSearch) || ([headerSearchCell.tfSearch.text isEqualToString:@""] && reachEndRecent)) {
                    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
                }
                else{
                    
                    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 50)];
                    self.tableView.tableFooterView = viewFooter;
                }
            }];
        }
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([headerSearchCell.tfSearch.text isEqualToString:@""] && !hasKeyBoard) {
        
        //Sem search
        if (section == 0) {
            return 40.0;
        }
    }
    else{
        
        //Com search
        return 40.0;
    }
    
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([headerSearchCell.tfSearch.text isEqualToString:@""] && !hasKeyBoard) {
        
        //Sem search
        if (section == 0) {
            return headerSearchCell.contentView;
        }
    }
    else{
        
        //Com search
        return headerSearchCell.contentView;
    }
    
    return [[UIView alloc] init];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if ([headerSearchCell.tfSearch.text isEqualToString:@""] && !hasKeyBoard) {
        
        [self.btBack setHidden:YES];
        
        //Sem search
        if (section == 0) {
            //return 2;
            
            int count = 0;
            
            if (self.listRecent.count > 0) {
                [self.vBack setBackgroundColor:kGrayBackTable];
                count = count + (int)self.listRecent.count;
            }
            else{
                //For loading and empty state
                count++;
            }
            return count;
        }
    }
    else{
        
        [self.btBack setHidden:NO];
        //Com search
        if (self.listSearch.count > 0) {
            [self.vBack setBackgroundColor:[UIColor whiteColor]];
            return self.listSearch.count;
        }
    }
    
    [self.vBack setBackgroundColor:[UIColor whiteColor]];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([headerSearchCell.tfSearch.text isEqualToString:@""] && !hasKeyBoard) {
        
        //Sem search
        [self.lTitle setText:@"Upcoming Movies"];
        if (indexPath.section == 0) {
            
            if (self.listRecent.count > 0) {
                Movie *obj = (Movie *)[self.listRecent objectAtIndex:indexPath.row];
                MovieContentCell *cellExample = [self.tableView dequeueReusableCellWithIdentifier:@"MovieContentCell"];
                [cellExample populateWithObject:obj];
                return cellExample;
            }
            else if (!reachEndRecent) {
                //Mostrar Loading
                UITableViewCell *cellExample = [self.tableView dequeueReusableCellWithIdentifier:@"Loading"];
                return cellExample;
            }
            else {
                //Mostrar Empty State
                UITableViewCell *cellExample = [self.tableView dequeueReusableCellWithIdentifier:@"Empty State"];
                return cellExample;
            }
        }
    }
    else{
        
        [self.lTitle setText:@"Search Movies"];
        //Com search
        if (self.listSearch.count > 0) {
            
            Movie *obj = (Movie *)[self.listSearch objectAtIndex:indexPath.row];
            MovieSearchCell *cellExample = [self.tableView dequeueReusableCellWithIdentifier:@"MovieSearchCell"];
            [cellExample populateWithObject:obj];
            return cellExample;
        }
        else if (!reachEndSearch) {
            //Mostrar Loading
            UITableViewCell *cellExample = [self.tableView dequeueReusableCellWithIdentifier:@"Loading"];
            return cellExample;
        }
        else {
            //Mostrar Empty State
            UITableViewCell *cellExample = [self.tableView dequeueReusableCellWithIdentifier:@"Empty State"];
            return cellExample;
        }
    }
    
    UITableViewCell *cellExample = [self.tableView dequeueReusableCellWithIdentifier:@"Empty State"];
    return cellExample;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([headerSearchCell.tfSearch.text isEqualToString:@""]  && !hasKeyBoard) {
        
        //Sem search
        if (indexPath.section == 0) {
            
            return 200.0;
        }
    }
    else{
        
        //Com search
        if (self.listSearch.count > 0) {
            
            return 80.0;
        }
    }
    
    return self.tableView.frame.size.height-40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([headerSearchCell.tfSearch.text isEqualToString:@""]  && !hasKeyBoard) {
        
        //Sem search
        if (indexPath.section == 0) {
            
            Movie *obj = (Movie *)[self.listRecent objectAtIndex:indexPath.row];
            [self goToMovie:obj];
        }
    }
    else{
        
        //Com search
        if (self.listSearch.count > 0) {
            
            Movie *obj = (Movie *)[self.listSearch objectAtIndex:indexPath.row];
            [self goToMovie:obj];
        }
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



@end
