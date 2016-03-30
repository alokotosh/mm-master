@isTest public class TestSubmitForApprovingESkills {
    @isTest public static void insertNewEmployeeSkills()
    {
       

      // Retrieve two profiles, for the standard user and the system &nbsp; 
    
      // administrator, then populate a map with them.&nbsp; 
    

      Map<String,ID> profiles =new Map<String,ID>();
      List<Profile> ps = [select id, name from Profile where name = 
         'Standard User' or name ='System Administrator'];

      for(Profile p : ps){
         profiles.put(p.name, p.id);
    
      // Create the users to be used in this test.&nbsp; 
    
      // First make a new user.&nbsp; 
    

      User standard =new User(alias ='standt', 
      email='standarddduser@testorg.com', 
      emailencodingkey='UTF-8', 
      lastname='Testing', languagelocalekey='en_US', 
      localesidkey='en_US', 
      profileid = profiles.get('Standard User'), 
      timezonesidkey='America/Los_Angeles', 
      username='standar@rg.com');

      insert standard;

      // Then instantiate a user from an existing profile&nbsp; 
    

      User admin = [SELECT Id FROM user WHERE profileid = 
                    :profiles.get('System Administrator')];

      // Create some test data for testing these two users&nbsp; 
    

      List<Account> accnts = new List<Account>();
      Account a1 = 
         new Account(name='Admin Account', ownerid = admin.id);
      Account a2 = 
         new Account(name='Standard Account', ownerid = standard.id);
      accnts.add(a1);
      accnts.add(a2);
      insert accnts;

      // Confirm that the standard user cannot see the admin account&nbsp; 
    

      system.runas(standard){
         accnts.clear();
         accnts = [select id, name from account where id = :a1.id];
         system.debug(accnts.isEmpty()+' really'+accnts);
         System.assertEquals(accnts.isEmpty(), true);

      }
      // Confirm that the admin user can see the standard account&nbsp; 
    

      system.runas(admin){
         accnts.clear();
         accnts = [select id, name from account where id = :a2.id];
         System.assertEquals(accnts.isEmpty(), false);
      }
   


system.runas(admin){
         Employee_Skills__c es = new Employee_Skills__c(Name='Test Skill2',
                                                       
                                                       Employee__c='a0A36000001ygYk',

                                                       
                                                       Project__c='a0736000000Ew01',
                                                       Employee_Email__c='test@test.com',
            										   Grade__c=4);
        insert es;
    }

        
    }
}

}