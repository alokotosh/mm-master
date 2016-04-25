@isTest
private class CreateCaseIdTest {
	
    @isTest static void testCaseIDCreation() {

        University__c un = new University__c(Name = 'New Test Account', Short_Name__c = 'NTA', Project_Count__c = 1355);
        insert un;
        Account proj = new Account(Name = 'TestProject', University__c = un.Id);
        insert proj;

        // as we have 'insert before trigger' then we need to retrieve the record we have created and 
        // inserted, because newComp is still null
        Account lastProject = [Select CreatedDate, Case_Id__c From Account 
                               order by CreatedDate desc Limit 1];
        // let's create control variable                                   
        String checkCaseId = un.Short_Name__c + '-' + lastProject.CreatedDate.year() + '-' + (un.Project_Count__c +1);
        
        // let's compare variables
        System.assertEquals(String.valueOf(lastProject.Case_Id__c), checkCaseId);
	}
}