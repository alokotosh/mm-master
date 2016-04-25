/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/20/2016
    @Purpose: This is the Register User api. Find the contact with given email if exists else create new
*/
@RestResource(urlMapping='/RegisterUser/*')
global with sharing class RegisterUserAPI {
    
    @HttpPost
    global static RegisterUserResponse registerUser( RegisterUserRequest user) {
        try{
           RegisterUserResponse res = new RegisterUserResponse();
           
           //Querying Order for Account Id
           List<Order> orderList = new List<Order>();
           if(user.orderNumber != null){
              orderList = [ Select Id, AccountId, Helix_Order_Number__c From Order Where Helix_Order_Number__c = :user.orderNumber ];
           }
           system.debug('orderList--'+orderList);
           
           Order order = new Order();
           Contact con = new Contact();
           
           //If no Order is found with the matching Order Number
           if(orderList.size() == 0){
              system.debug('No Order found');
              res = generateResponse('Registration Unsuccessful - Order Number not found','108',false);
              return res;
           }
             //if a matching Order is found
             else if (orderList != null && orderList.size() >0){
                order = orderList[0];
                
                //Querying Contacts
                List<Contact> conList = [ Select Id, userid__c, AccountId From Contact Where AccountId = :order.AccountId ];
                
                if(conList == null){
                   system.debug('No Contact Found');
                   res = generateResponse('Registration Unsuccessful - No Contact Found','109',false);
                   return res;
                }
                  //if a matching conTact is found
                  else if(conList != null && conList.size() > 0){
                     con = conList[0];
                     
                     //updating Contacts UserId
                     con.userid__c = user.userId;
                     update con;
                     
                     system.debug('Registration Successful');
                     res = generateResponse(null,null,true);
                  }
             }
           
           return res;
        }catch(Exception e){
           system.debug('Error = '+e.getMessage());
           RegisterUserResponse res = generateResponse(e.getMessage(),'102',false);
        }
        return null;
    }
    
     //Method to generate response
    global static RegisterUserResponse generateResponse(String msg, String code, Boolean registrationSuccessful){
        RegisterUserResponse res = new RegisterUserResponse();
        res.registrationSuccessful = registrationSuccessful;
        if(msg != null){
            HMAPIError error = new HMAPIError();
            error.message = msg;
            error.errorCode = code;
            res.error = error;
        }
        return res;
    }
}