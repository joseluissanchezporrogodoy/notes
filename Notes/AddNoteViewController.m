//
//  AddNoteViewController.m
//  Notes
//
//  Created by jose luis sanchez-porro godoy on 11/01/2017.
//  Copyright © 2017 José Luis Sánchez-Porro Godoy. All rights reserved.
//

#import "AddNoteViewController.h"
#import "AppDelegate.h"
@interface AddNoteViewController ()

@end

@implementation AddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    // Si la nota viene rellena del otro viewcontroller relleno los campos de la imagen
    if(self.note != nil){
        
        self.noteText.text = self.note.text;
        self.imageView.image = [UIImage imageWithData:self.note.image];
    }

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)save:(id)sender {
    ///SACO UN CONTEXTO PARA ACTUALIZAR O CREAR
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    if(self.note !=nil){
        /////ACTUALIZO -La nota vino ya rellena del primer viewcontroller y toca actualizarla
            //Actualizo la fecha
        self.note.date =[NSDate dateWithTimeIntervalSinceNow:0];
            //Actualizo el texto de l anota
        self.note.text = self.noteText.text;
            //Actualizo la imagen
        self.note.image = UIImageJPEGRepresentation(self.imageView.image, 1);
        
        /////GUARDO
        NSError *error = nil;
        if ([context save:&error] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
        ///Enseño alerta
        [self showAlert];
        
    }else{
        
        /////CREO -La nota ha sido creada por primera vez, es decir no ha venido ninguna nota del primer viewcontroller (El usuario ha pulsado +)
        Note *newNote;
        newNote = [NSEntityDescription  insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
        
        ///Metemos datos a la nota
        newNote.text = self.noteText.text;
        newNote.date = [NSDate dateWithTimeIntervalSinceNow:0];
        newNote.image =  UIImageJPEGRepresentation(self.imageView.image, 1);
        
        /////GUARDO
        NSError *error = nil;
        if ([context save:&error] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
        ///Enseño alerta
        [self showAlert];
        
    }
    
  }

-(void)showAlert{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Alerta" message:@"La nota se ha guardado correctamente" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (IBAction)takePhoto:(id)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Alerta"
                                          message:@"Seleccione una opción"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cameraRoll = [UIAlertAction
                                  actionWithTitle:@"Carrete"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction *action)
                                  {
                                      
                                      
                                      UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                      picker.delegate = self;
                                      picker.allowsEditing = YES;
                                      picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                      
                                      [self presentViewController:picker animated:YES completion:NULL];
                                      
                                      
                                      NSLog(@"Cancel action");
                                  }];
    
    UIAlertAction *camera = [UIAlertAction
                             actionWithTitle:@"Cámara"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action)
                             {
                                 UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                 picker.delegate = self;
                                 picker.allowsEditing = YES;
                                 picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                 
                                 [self presentViewController:picker animated:YES completion:NULL];
                                 
                                 NSLog(@"OK action");
                             }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancelar"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    [alertController addAction:cameraRoll];
    [alertController addAction:camera];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    

}
- (void) dismissKeyboard {
    
    //Oculta el teclado
    [self.view endEditing:YES];
    
}
#pragma mark Picker methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
