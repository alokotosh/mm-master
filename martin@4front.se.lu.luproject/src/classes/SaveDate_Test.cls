@isTest
private class SaveDate_Test {
    
    @isTest static void saveStatusTriggerPositive1_test() {
        
        University__c un = new University__c();
        un.Name = 'Test University';
        un.Short_Name__c = 'NTA';
        insert un;

        Account account = new Account();
        account.Name = 'Test account';
        account.University__c = un.Id;
        account.Project_Status__c = 'Active';
        account.Project_Phase__c = 'Idea';
        insert account;
        System.assertNotEquals(null, account.Id);

        Account acc = [Select Id, Name, Project_Status__c From Account Where Name = 'Test account'];
        acc.Project_Status__c = 'Pending';
        Date statusDate = System.today();
        update acc;

        Account acc1 = [Select Id, Name, Active_End_Date__c, Pending_Start_Date__c From Account Where Name = 'Test account'];
        System.assertEquals(statusDate, acc1.Active_End_Date__c);
        System.assertEquals(statusDate, acc1.Pending_Start_Date__c);

    }

    @isTest static void saveStatusTriggerPositive2_test() {
        
        University__c un = new University__c();
        un.Name = 'Test University';
        un.Short_Name__c = 'NTA';
        insert un;

        Account account = new Account();
        account.Name = 'Test account';
        account.University__c = un.Id;
        account.Project_Status__c = 'External proceeding';
        account.Project_Phase__c = 'Idea';
        Date statusDate = System.today();
        insert account;
        System.assertNotEquals(null, account.Id);

        Account acc = [Select Id, Name, Project_Status__c, External_Proceeding_Start__c From Account Where Name = 'Test account'];
        System.assertEquals(statusDate, acc.External_Proceeding_Start__c);
        acc.Project_Status__c = 'Pending';
        //Date statusDate = System.today();
        update acc;

        Account acc1 = [Select Id, Name, External_Proceeding_End__c, Pending_Start_Date__c From Account Where Name = 'Test account'];
        System.assertEquals(statusDate, acc1.External_Proceeding_End__c);
        System.assertEquals(statusDate, acc1.Pending_Start_Date__c);

    }
    
    @isTest static void saveStatusTriggerNegative1_test() {
        
        University__c un = new University__c();
        un.Name = 'Test University';
        un.Short_Name__c = 'NTA';
        insert un;

        Account account = new Account();
        account.Name = 'Test account';
        account.University__c = un.Id;
        account.Project_Status__c = 'Active';
        account.Project_Phase__c = 'Idea';
        insert account;
        System.assertNotEquals(null, account.Id);

        Account acc = [Select Id, Name, Project_Status__c From Account Where Name = 'Test account'];
        acc.Project_Status__c = 'Test';
        try {
            update acc;
        }
        catch(System.DmlException e) {
            String message = e.getMessage();
            System.assertEquals(message.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'), true);
        }

        Account acc1 = [Select Id, Name, Active_End_Date__c From Account Where Name = 'Test account'];
        System.assertEquals(null, acc1.Active_End_Date__c);

    }

    @isTest static void saveStatusTriggerNegative2_test() {
        
        University__c un = new University__c();
        un.Name = 'Test University';
        un.Short_Name__c = 'NTA';
        insert un;

        Account account = new Account();
        account.Name = 'Test account';
        account.University__c = un.Id;
        account.Project_Status__c = 'Active';
        account.Project_Phase__c = 'Idea';
        try {
            insert account;
        }
        catch(System.DmlException e) {
            System.assertEquals(null, account.Id);
            String message = e.getMessage();
            System.assertEquals(message.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'), true);
        }
    }

    @isTest static void savePhaseTriggerPositive_test() {
        
        University__c un = new University__c();
        un.Name = 'Test University';
        un.Short_Name__c = 'NTA';
        insert un;

        Account account = new Account();
        account.Name = 'Test account';
        account.University__c = un.Id;
        account.Project_Phase__c = 'Idea';
        insert account;
        System.assertNotEquals(null, account.Id);

        Account acc = [Select Id, Name, Project_Phase__c From Account Where Name = 'Test account'];
        acc.Project_Phase__c = 'Verification';
        Date phaseDate = System.today();
        update acc;

        Account acc1 = [Select Id, Name, Idea_End_Date__c, Verification_Start_Date__c From Account Where Name = 'Test account'];
        System.assertEquals(phaseDate, acc1.Idea_End_Date__c);
        System.assertEquals(phaseDate, acc1.Verification_Start_Date__c);

    }
    
    @isTest static void savePhaseTriggerNegative1_test() {
        
        University__c un = new University__c();
        un.Name = 'Test University';
        un.Short_Name__c = 'NTA';
        insert un;

        Account account = new Account();
        account.Name = 'Test account';
        account.University__c = un.Id;
        account.Project_Phase__c = 'Verification';
        insert account;
        System.assertNotEquals(null, account.Id);

        Account acc = [Select Id, Name, Project_Phase__c From Account Where Name = 'Test account'];
        System.assertEquals('Verification', acc.Project_Phase__c);
        acc.Project_Phase__c = 'Test';
        try {
            update acc;
        }
        catch(System.DmlException e) {
            String message = e.getMessage();
            System.assertEquals(message.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'), true);
        }

        Account acc1 = [Select Id, Name, Verification_End_Date__c From Account Where Name = 'Test account'];
        System.assertEquals(null, acc1.Verification_End_Date__c);

    }

    @isTest static void savePhaseTriggerNegative2_test() {
        
        University__c un = new University__c();
        un.Name = 'Test University';
        un.Short_Name__c = 'NTA';
        insert un;

        Account account = new Account();
        account.Name = 'Test account';
        account.University__c = un.Id;
        account.Project_Phase__c = 'Test';
        try {
            insert account;
        }
        catch(System.DmlException e) {
            System.assertEquals(null, account.Id);
            String message = e.getMessage();
            System.assertEquals(message.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'), true);
        }

    }
    
}