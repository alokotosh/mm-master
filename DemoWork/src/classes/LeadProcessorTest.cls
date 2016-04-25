@IsTest
public class LeadProcessorTest {
    
        @testSetup 
    static void setup() {
        List<Lead> accounts = new List<Lead>();
        // insert 10 accounts
        for (Integer i=0;i<200;i++) {
            accounts.add(new Lead(LastName='Account '+i, 
                CompanyDunsNumber='USA'));
        }
        insert accounts;
        // find the account just inserted. add contact for each

    }

    static testmethod void test() {        
        Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();

        // after the testing stops, assert records were updated properly
        System.assertEquals(10, [select count() from lead where CompanyDunsNumber = 'USA']);
    }
    

}