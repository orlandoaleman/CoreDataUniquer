//
//  CoreDataUniquer.h
//  closett
//
//  Created by Orlando Aleman Ortiz
//  Copyright (c) 2012 orlandoaleman.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 Esta clase permite determinar si un objeto existe en la base de datos CoreData
 en base a su identificador y crearlo cuando no. Se hace mediante una propiedad del objeto, identifier
 */

@interface CoreDataUniquer : NSObject

/// Inicializa un objeto para controlar la existencia de instancias únicos de una entidad
- (id)initWithEntityName:(NSString *)entityName identifyingProperty:(NSString *)idProp andContext:(NSManagedObjectContext *)context;

/// Encuentra un objeto entityName en el contexto
- (NSManagedObject *)findObjectForID:(id)identifier;

/// Crea un objeto entityName en el contexto
- (NSManagedObject *)createObjectForID:(id)identifier;

@end
