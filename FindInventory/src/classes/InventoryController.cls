public with sharing class InventoryController {

    @AuraEnabled
    public static List<Computer_Inventory__c> findAll() {

     String [] fields = new String [] {'id',
                                       'Name',
                                       'Inventory_Number__c',
                                       'Customer__r.Name',
                                       'Contact_Person__r.Name',
                                       'Value__c',
                                       'LastModifiedDate'
          };



Map<String,Schema.SObjectField> m = Schema.SObjectType.Computer_Inventory__c.fields.getMap();

for (String field : fields) {

    // Check if user has permission to view field
    if (!m.get(field).getDescribe().isAccessible()) {
        throw new System.NoAccessException();
        return null;
    }
}



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
