public with sharing class InventoryController {

    @AuraEnabled
    public static List<Computer_Inventory__c> findAll() {
    return [SELECT id, name, Inventory_Number__c,Customer__r.Name,Contact_Person__r.Name, Value__c,LastModifiedDate
            FROM Computer_Inventory__c

            LIMIT 50];
    }


    @AuraEnabled
    public static List<Computer_Inventory__c> findByName(String searchKey) {
        String name = '%' + searchKey + '%';
        return [SELECT id, name, Inventory_Number__c,Customer__r.Name,Contact_Person__r.Name, Value__c,LastModifiedDate
                FROM Computer_Inventory__c WHERE name LIKE :name LIMIT 50];
    }

    @AuraEnabled
    public static Computer_Inventory__c findById(String inventoryId) {
        return [SELECT id, name, Inventory_Number__c,Customer__r.Name, Customer__r.id, Contact_Person__r.Name, Contact_Person__r.id, Value__c,LastModifiedDate
                    FROM Computer_Inventory__c  WHERE Id = :inventoryId];
    }

    @AuraEnabled
    public static List<Computer_Inventory__c> findByString(String searchKey) {
      String searchStr = '%' + searchKey + '%';
        return [SELECT id, name, Inventory_Number__c,Customer__r.Name, Customer__r.id, Contact_Person__r.Name, Contact_Person__r.id, Value__c,LastModifiedDate
                     FROM Computer_Inventory__c WHERE Customer__r.Name LIKE :searchStr
                                                               OR name LIKE :searchStr


                                                               LIMIT 50];
    }


    @AuraEnabled
public static List<Computer_Inventory__c> getInventories() {

   // Perform isAccessible() check here
    return [SELECT id, name, Inventory_Number__c,Customer__c,Contact_Person__c, Value__c,LastModifiedDate
            FROM Computer_Inventory__c

            LIMIT 50];

}
// @AuraEnabled
// public static Computer_Inventory__c saveInventories(Computer_Inventory__c inventory) {
//
// // Perform isUpdateable() check here
// upsert inventory;
// return inventory;
// }

}
