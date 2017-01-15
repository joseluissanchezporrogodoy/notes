//
//  Note+CoreDataProperties.h
//  Notes
//
//  Created by José Luis Sánchez-Porro Godoy on 10/1/17.
//  Copyright © 2017 José Luis Sánchez-Porro Godoy. All rights reserved.
//

#import "Note+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Note (CoreDataProperties)

+ (NSFetchRequest<Note *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, copy) NSString *text;

@end

NS_ASSUME_NONNULL_END
