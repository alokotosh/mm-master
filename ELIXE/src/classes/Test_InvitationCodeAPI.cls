/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/25/2016
    @Purpose: This is the Test Class for Invitation Code API
*/
@isTest
  private class Test_InvitationCodeAPI {

  static {
    // setup test data  
  }

static testMethod void OrderTestMethod() {

     Lead testLead = new Lead(LastName = 'Test Lead', Company = 'Test Company', Status = 'Working', Email = 'teast@lead.com');
     insert testLead;
     
     invitationCodeResponse result1 = InvitationCodeAPI.isValidInvitationCode('asdf');
     
     testLead.Invitation_Code__c = 'asdf';
     testLead.Invitation_Code_Used__c = false;
     
     update testLead;
     
     invitationCodeResponse result2 = InvitationCodeAPI.isValidInvitationCode('asdf');
     
     testLead.Invitation_Code__c = 'asdf';
     testLead.Invitation_Code_Used__c = true;
     
     update testLead;
     
     invitationCodeResponse result3 = InvitationCodeAPI.isValidInvitationCode('asdf');
     
     invitationCodeResponse res = new invitationCodeResponse();

}
}