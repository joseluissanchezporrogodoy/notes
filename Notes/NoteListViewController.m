//
//  ViewController.m
//  Notes
//
//  Created by José Luis Sánchez-Porro Godoy on 10/1/17.
//  Copyright © 2017 José Luis Sánchez-Porro Godoy. All rights reserved.
//

#import "NoteListViewController.h"
#import "AppDelegate.h"
#import "NotesTableViewCell.h"
#import "AddNoteViewController.h"

@interface NoteListViewController ()

@end

@implementation NoteListViewController


///Fijate que es viewDidAppear, este método se ejecuta siempre que aparece la vista
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
     self.selectedNote = nil;
    
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    //Obtengo todas las entidades
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSError *error = nil;
   
    self.notes = (NSMutableArray *) [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    //Se recarga la tabla
    [self.tableView reloadData];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Methods


///Le digo qué tiene que contener cada celda
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    Note *note = (Note *) [self.notes objectAtIndex:indexPath.row];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateStyle:NSDateFormatterLongStyle];
    [df setTimeStyle:NSDateFormatterNoStyle];
    NSString *stringDate = [df stringFromDate:note.date];
    cell.dateLabel.text = stringDate;

    cell.noteTextLabel.text = note.text;
    cell.image.image = [UIImage imageWithData:note.image];
   
        return cell;
}

///Le digo a al tabla el alto que tiene que tener las celdas
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}

///Le digo el número de secciones
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

/// Le digo el número de celdas en cada sección
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.notes count];    //Una fila por cada una de las notas.
}

/// Le digo que las celdas son editables
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

/// Le digo lo que tiene que hacer cuando edite celda
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
        AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        
        self.selectedNote = (Note *) [self.notes objectAtIndex:indexPath.row];
        
        //Se borra del contexto la anotación correspondiente
        [context deleteObject:self.selectedNote];
        //Se borra del array
        [self.notes removeObject:self.selectedNote];
        //Además se pone a nil la celda seleccionada
        self.selectedNote = nil;
        //Finalmente se repintará la celda
        [self.tableView reloadData];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Se guarda la nota seleccionada y se hace el segue
    self.selectedNote = (Note *) [self.notes objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"toNoteDetail" sender:nil];
    
    
    
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"toNoteDetail"]) {
        
        //Se manda la nota que se quiere mostrar a los detalles
        AddNoteViewController *destinationViewController = [segue destinationViewController];
        
        destinationViewController.note =self.selectedNote;
        
    }
    
}


@end
