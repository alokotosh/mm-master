/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/20/2016
    @Purpose: This is the api to check if the invitation code is valid or not. If valid invitation code (matching lead exists) then it also checks if the code has already been used. return true only if the code has not been used
*/
@RestResource(urlMapping='/IsValidInvitationCode/*')
global with sharing class InvitationCodeAPI {
    
    @HttpPost
    global static invitationCodeResponse isValidInvitationCode( String invitationCode) {
        try{
           invitationCodeResponse res = new invitationCodeResponse();
           
           //Querying Lead With the given invitationCode
           List<Lead> leadList = [ Select Id, Invitation_Code__c, Invitation_Code_Used__c, Name,firstName, lastName, Email From Lead Where Invitation_Code__c = :invitationCode ];
           
           Lead lead;
           
           if( leadList != null && leadList.size() > 0){
              lead = leadList[0];  
           }
           System.debug('Lead = '+lead);
           if(lead == null){
               System.debug('Lead not found ');
               res = generateResponse('Invitation code not found','103',false, null, null,null);
              
           }
             else if(lead != null && lead.Invitation_Code_Used__c == true){
             System.debug('Lead code already used ');
             res = generateResponse('Invitation code already used','104',false, null, null,null);
                
             }
               else if(lead != null && lead.Invitation_Code_Used__c == false){
                   System.debug('Lead code valid ');
                    res = generateResponse(null,null,true, lead.firstName,lead.lastName, lead.Email);
                  
               }
               System.debug('response = '+res);
           return res;
        }catch(Exception e){
            System.debug('Error = '+e.getMessage());
            invitationCodeResponse response = generateResponse(e.getMessage(),'102',false, null, null,null);
        }
        return null;
    }
    
    //Method to generate response
    global static invitationCodeResponse generateResponse(String msg, String code, Boolean isValid, String leadFName, String leadLName, String leadEmail){
        invitationCodeResponse res = new invitationCodeResponse();
        res.isvalid = isValid;
        HM_Lead l ;
        if(isValid){
             l = new HM_Lead();
             l.firstName = leadFName;
             l.lastName = leadLName;
             l.email = leadEmail;
             res.lead = l;
        }
        
        System.debug('Lead : '+l);
        if(msg != null){
            HMAPIError error = new HMAPIError();
            error.message = msg;
            error.errorCode = code;
            res.error = error;
            
        }
        System.debug('Response : '+res);
        return res;
    }
}