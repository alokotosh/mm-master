@isTest (SeeAllData=true)
  private class Test_RegisterKitAPI {

  static {
    // setup test data  
  }

static testMethod void kitTestMethod() {

   //Creating HM_Agreement
   HM_Agreement agreement1 = new HM_Agreement();
   agreement1.key = '' ;
   agreement1.version = '' ;
   agreement1.agreed = true ;
   HM_Agreement agreement2 = new HM_Agreement();
   agreement2.key = '' ;
   agreement2.version = '' ;
   agreement2.agreed = true ;
   List<HM_Agreement> agreements = new List<HM_Agreement>();
   agreements.add(agreement1);
   agreements.add(agreement2);
   
   HM_Contact buyerHMCon = new HM_Contact();
   buyerHMCon.firstName = 'fName';
   buyerHMCon.lastName = 'lName';
   buyerHMCon.email = 'fName@lName.com';
   buyerHMCon.userId = '';
   buyerHMCon.phone = '9902944899';
   buyerHMCon.biologicalSex = 'Male';
   buyerHMCon.blackNaturally = 'Yes';
   buyerHMCon.agreements = agreements;
   
   HM_Account buyerHMAcc = new HM_Account();
   buyerHMAcc.contact = buyerHMCon;
   
   HM_Kit hmkit = new HM_Kit();
    hmkit.account = buyerHMAcc ;
    hmkit.kitId = '12345';
    hmkit.orderProductId= 'H01258692';
        
   HM_OrderLine orderLine1 = new HM_OrderLine();
   orderLine1.quantity = 2;
   orderLine1.sku = '';
   orderLine1.appId = '654321';
   
   HM_OrderLine orderLine2 = new HM_OrderLine();
   orderLine2.quantity = 3;
   orderLine2.sku = '';
   orderLine2.appId = '123456';
   
   List<HM_OrderLine> lineList = new List<HM_OrderLine>();
   lineList.add(orderLine1);
   lineList.add(orderLine2);
   
   
   RegisterKitResponse result1 = RegisterKitAPI.registerKit(hmKit);
   
   hmkit.Account.contact.userId = '123456';
   
   RegisterKitResponse result2 = RegisterKitAPI.registerKit(hmKit);
   
   /*RegisterUserRequest userReq = new RegisterUserRequest();
   userReq.userId = '456789';
   userreq.orderNumber = '';*/
   
   Account buyerAcc = new Account(Name = 'Buyer Acc', NON_BUYER_Account__c = False);
   insert buyerAcc;
   
   Account nonBuyerAcc = new Account(Name = 'Non-Buyer Acc', NON_BUYER_Account__c = true);
   insert nonBuyerAcc;
   
   Contact con1 = new Contact(LastName = 'Con1', AccountId = buyerAcc.Id, userid__c = '456789');
   insert con1;
   
   Contact con2 = new Contact(LastName = 'Con2', AccountId = nonBuyerAcc.Id, userid__c = '45678909');
   insert con2;
   
   hmkit.account.contact.userId = '456789';  
   RegisterKitResponse result3 = RegisterKitAPI.registerKit(hmKit);
   
   hmkit.account.contact.userId = '45678909';  
   RegisterKitResponse result4 = RegisterKitAPI.registerKit(hmKit);
   
   Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
   
    
}

}