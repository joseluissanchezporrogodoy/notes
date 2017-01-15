//
//  AddNoteViewController.h
//  Notes
//
//  Created by jose luis sanchez-porro godoy on 11/01/2017.
//  Copyright © 2017 José Luis Sánchez-Porro Godoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note+CoreDataProperties.h"
@interface AddNoteViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *noteText;
@property (weak, nonatomic) Note *note;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)save:(id)sender;
- (IBAction)takePhoto:(id)sender;

@end
