//
//  SearchViewController.h
//  TMDB_Objc
//
//  Created by Sergio Freire on 15/11/16.
//  Copyright © 2016 Sergio Freire. All rights reserved.
//

#import "GeneralViewController.h"
#import "HeaderSearchCell.h"
#import "MovieSearchCell.h"
#import "MovieContentCell.h"

@interface SearchViewController : GeneralViewController <UITableViewDelegate, UITableViewDataSource,HeaderSearchCellDelegate>{
    
    NSMutableArray *notifications;
    BOOL hasKeyBoard;
    
    BOOL isUsingServicesSearch;
    BOOL reachEndSearch;
    int pageNumberSearch;
    
    BOOL isUsingServicesRecent;
    BOOL reachEndRecent;
    int pageNumberRecent;
    
    HeaderSearchCell *headerSearchCell;
}

@property (readwrite) BOOL isFirstTime;

@property (weak, nonatomic) IBOutlet UILabel *lTitle;

@property (weak, nonatomic) IBOutlet UIButton *btBack;
@property (weak, nonatomic) IBOutlet UIView *vBack;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *listRecent;
@property (strong, nonatomic) NSMutableArray *listSearch;
@property (strong, nonatomic) UIRefreshControl *pullView;

@end
