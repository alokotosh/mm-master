@isTest(SeeAllData=true)
  private class Test_KitUtilAPI {

  static {
    // setup test data  
  }

static testMethod void OrderTestMethod() {

     Account testAccount = new Account (Name = 'Test Account');
     insert testAccount;
    
     
     Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
   
     Pricebook2 priceBook = new  Pricebook2(Name = 'Test Price Book', IsActive = true);
     insert priceBook;
    
     Product2 product = new Product2(Name = 'Test Product', ProductCode = '123456');
     insert product;
    
     PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = standardPB.Id, Product2Id = product.Id, UnitPrice = 10, IsActive = true, UseStandardPrice = false);
     insert standardPrice;
    
     PricebookEntry priceBookEntry = new PricebookEntry(Pricebook2Id = priceBook.Id, Product2Id = product.Id, UnitPrice = 50);
     insert priceBookEntry;
     
     Order testOrder = new Order(AccountId = testAccount.Id, EffectiveDate = system.Today(), Status = 'Draft', PriceBook2Id = priceBook.Id);
     insert testOrder;
     
     OrderItem orderProduct = new OrderItem(OrderId = testOrder.id, Quantity = 50, PriceBookEntryId = priceBookEntry.Id, UnitPrice = 10);
     insert orderProduct;
     
     kitIdResponse result1 = KitUtilAPI.isValidKitId('asdf');
     
     orderProduct.Kit_ID__c = 'asdfgh';
     orderProduct.Kit_Order_Status__c = 'Pending';
     update orderProduct;
     
     kitIdResponse result2 = KitUtilAPI.isValidKitId('asdfgh');
     
     orderProduct.Kit_Order_Status__c = 'Shipped';
     update orderProduct;
     
     kitIdResponse result3 = KitUtilAPI.isValidKitId('asdfgh');
}
}