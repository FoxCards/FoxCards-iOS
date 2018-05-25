//
//  DictionaryPresenter.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 26.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import CoreData

class DictionaryPresenter: NSObject, DictionaryPresenterInput {
    weak var view: DictionaryViewInput?
    weak var viewFrc:  DictionaryFrcViewChange?
    var selectedWordIndex: Int?
    var selectedSegmentIndex = false
    
    var frc: NSFetchedResultsController<NSFetchRequestResult>?
    
    func setUpFrc(isKnow: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Word")
        let predicate = NSPredicate(format: "isKnow=%i AND language=%@", isKnow as CVarArg, const.app_settings.app_language?.speach_locale ?? "")
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "date", ascending:selectedSegmentIndex )
        fetchRequest.sortDescriptors = [sortDescriptor]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.sharedInstance.getMainContext(), sectionNameKeyPath: nil, cacheName: nil)
        _ = try? frc.performFetch()
        self.frc = frc
        frc.delegate = self
    }

    func viewDidLoad() {
        setUpFrc(isKnow: false)
    }
    
    func viewWillAppear(animate: Bool) {
        
    }
    
    func numberOfEntities(segmentState: Int) -> Int {
        return frc?.fetchedObjects?.count ?? 0
    }
    
    func entityAt(index: IndexPath, segmentState: Int) -> Any? {
        
        return frc?.object(at:index)
    }
    
    func getSelectedWord(segmentState: Int)-> Word? {
        if selectedWordIndex != nil {
            return frc?.object(at: IndexPath(item: selectedWordIndex!, section: 0)) as? Word
        } else {
            return nil
        }
    }
    
    func deleteObj(index: IndexPath) {
        let managedObject = frc?.object(at: index) as! NSManagedObject
        CoreDataManager.sharedInstance.getMainContext().delete(managedObject)
        CoreDataManager.sharedInstance.saveContext()
    }
    
    func shiftObj(index: IndexPath,known: Bool) {
        let obj = frc?.object(at: index) as! Word
        WordsFabrique.setWord(word: obj.word!, transcription: obj.transcriptions!, translate: obj.translate!, isKnow: known, language: nil, context: CoreDataManager.sharedInstance.getMainContext())
        CoreDataManager.sharedInstance.saveContext()
    }
    
    
}

extension DictionaryPresenter: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.viewFrc?.beginUpdates()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        DispatchQueue.main.async {
            switch type {
            case .insert:
                self.viewFrc?.insert(to: newIndexPath)
            case .update:
                self.viewFrc?.update(indexPath: indexPath, object: self.frc?.object(at: indexPath!) as! Word)
            case .move:
                self.viewFrc?.move(from: indexPath, to: newIndexPath)
            case .delete:
                self.viewFrc?.delete(indexPath: indexPath)
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.viewFrc?.endUpdates()
        }
        
    }
}
