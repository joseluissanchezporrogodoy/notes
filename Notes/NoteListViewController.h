//
//  ViewController.h
//  Notes
//
//  Created by José Luis Sánchez-Porro Godoy on 10/1/17.
//  Copyright © 2017 José Luis Sánchez-Porro Godoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note+CoreDataProperties.h"
@interface NoteListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) IBOutlet NSMutableArray *notes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) Note *selectedNote;

@end

