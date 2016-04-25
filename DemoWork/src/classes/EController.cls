public with sharing class EController {

        @AuraEnabled
    public static List<Employee__c> findAllEmployees() {
    return [SELECT id, name,(Select id, name From Employee_Skills__r)
            FROM   Employee__c
            LIMIT 50];
    }
    
            @AuraEnabled
    public static List<Project__c> findAllProject() {
    return [SELECT id, name,(Select id, name From Employee_Skills__r)
            FROM   Project__c
            LIMIT 50];
    }
    
                @AuraEnabled
    public static List<Employee_Skills__c> findAllSkills() {
    return [SELECT id, name, Employee__r.id, Project__r.id, Project__r.Name, Employee__r.Name
            FROM   Employee_Skills__c
            LIMIT 50];
    }
    

    
    
	

}