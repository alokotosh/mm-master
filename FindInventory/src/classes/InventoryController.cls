public with sharing class InventoryController {

    @AuraEnabled
    public static List<Computer_Inventory__c> findAll() {
    return [SELECT id, name, Inventory_Number__c,Customer__r.Name,Contact_Person__r.Name, Value__c,LastModifiedDate
            FROM Computer_Inventory__c

            LIMIT 1000];
    }
    @AuraEnabled
    public static List<Computer_Inventory__c> findByString(String searchKey) {
      String searchStr = '%' + searchKey + '%';
        return [SELECT id, name, Inventory_Number__c,Customer__r.Name, Customer__r.id, Contact_Person__r.Name, Contact_Person__r.id, Value__c,LastModifiedDate
                     FROM Computer_Inventory__c WHERE Customer__r.Name LIKE :searchStr
                                                               OR name LIKE :searchStr
                                                               LIMIT 1000];
    }
}