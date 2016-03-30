@isTest public class TestSubmitForApprovingESkills {
  @isTest public  static void addNewEmployeeSkills()
    {
        
        
        
         Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
     	 User u = new User(Alias = 'newTes', Email='newuser@testorg.com',
       					  EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        				  LocaleSidKey='en_US', ProfileId = p.Id,
        				  TimeZoneSidKey='America/Los_Angeles', UserName='kava@esp.com');
        insert u;
        System.runAs(u) {
             Employee__c e = new Employee__c(Name='Jor',
            						Email__c='joe@example.com',
            						Description__c='Test',
            						Department__c='Iddfdfd');
        insert e;
       List<Employee__c> temp = [Select id,Name,OwnerId
                                 From Employee__c
                                 Where id=:e.id
           
       ]; 
        System.debug('*****+'+temp.get(0).OwnerId);
        
        Project__c proj = new Project__c (Name='TestProj'
            						);
        insert proj;
            
        Employee_Skills__c es = new Employee_Skills__c(Name='Test Skill',
                                                       Employee__c=e.id,
                                                       Project__c=proj.Id,
                                                       Employee_Email__c='test@test.com',
            										   Grade__c=4);
            System.debug('******'+e.Ownerid);
        	insert es;
                                                       
                                                       
            						
    }		
    }

}