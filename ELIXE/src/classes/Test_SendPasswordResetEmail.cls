/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/28/2016
    @Purpose: This is the Test Class for SendPasswordResetEamil api
*/

@isTest(SeeAllData=true)
  private class Test_SendPasswordResetEmail {

  static {
    // setup test data  
  }

static testMethod void SendEmailTestMethod() {

   ResetPasswordEmailRequest req = new ResetPasswordEmailRequest();
   
   SendPasswordResponse res = SendPasswordResetEmail.sendResetPasswordEmail(req);
   
   req.email = 'mugdha_gupta@yahoo.com';
   req.userId = 'werty';
   req.resetLink = 'www.google.com';
   
   Account testAcc = new Account(Name = 'Test Acc');
   insert testAcc;
   
   Contact con = new Contact(LastName = 'Con', AccountId = testAcc.Id);
   insert con;
   
   SendPasswordResponse res2 = SendPasswordResetEmail.sendResetPasswordEmail(req);
   
   con.Email = 'mugdha_gupta@yahoo.com';
   con.userid__c = 'werty';
   update con;
   
   SendPasswordResponse res3 = SendPasswordResetEmail.sendResetPasswordEmail(req);
}
}