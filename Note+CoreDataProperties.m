//
//  Note+CoreDataProperties.m
//  Notes
//
//  Created by José Luis Sánchez-Porro Godoy on 10/1/17.
//  Copyright © 2017 José Luis Sánchez-Porro Godoy. All rights reserved.
//

#import "Note+CoreDataProperties.h"

@implementation Note (CoreDataProperties)

+ (NSFetchRequest<Note *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Note"];
}

@dynamic date;
@dynamic image;
@dynamic text;

@end
