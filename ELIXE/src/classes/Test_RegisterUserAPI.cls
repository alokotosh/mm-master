@isTest(SeeAllData=true)
  private class Test_RegisterUserAPI {

  static testMethod void OrderTestMethod() {

     RegisterUserRequest user = new RegisterUserRequest();
     //user.userId = ;
     //user.orderNumber = ;

     Account testAccount = new Account(Name = 'Test Account');
     insert testAccount;
     
     Contact testContact = new Contact(LastName = 'Test Contact', AccountId = testAccount.Id);
     insert testContact;
     
     Order testOrder = new Order(AccountId = testAccount.Id, EffectiveDate = system.today(), Status = 'Draft');
     insert testorder;
     
     RegisterUserResponse result1 = RegisterUserAPI.registerUser(user);
     
     Order o = [ Select Id,  Helix_Order_Number__c From Order Where Id = :testOrder.Id ];
     
     user.userId = 'asdfggtr';
     user.orderNumber = o.Helix_Order_Number__c;
     
     RegisterUserResponse result2 = RegisterUserAPI.registerUser(user);
}
}