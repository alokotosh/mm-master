/*
    @author: Shirish Goel (Thirdwave Analytics)
    @Date: 3/28/2016
    @Purpose: This is SendPasswordResetEmail api to be invoked by Helix Marketplace for sending emails to users when they forget password.
                input: ResetPasswordEmailRequest 
                output: SendPasswordResponse and an email sent out to the contact/user
*/
@RestResource(urlMapping='/SendPasswordResetEmail/*')
global with sharing class SendPasswordResetEmail {

   
    
@HttpPost
global static SendPasswordResponse sendResetPasswordEmail( ResetPasswordEmailRequest resetPasswordEmailRequest) {
    try{
       
       List<Contact> conList = [ Select Id, Email From Contact Where Email = :resetPasswordEmailRequest.email And userid__c = :resetPasswordEmailRequest.userId ];
       
       Contact con ;//= new Contact();
       if(conlist != null && conlist.size() > 0){
          con = conList[0];
       }
       
       if(con == null){
          SendPasswordResponse res = generateResponse('Email not sent - No Contact found', '110', false);
          return res;
       }
         else if (con != null){
            
            //send email
            //get email template
            EmailTemplate et = [select id, htmlvalue,body from EmailTemplate where developername = 'Password_Reset' limit 1];
             
            //get org wide email address id
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'alpha@helix.com'];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {resetPasswordEmailRequest.email};
            mail.setToAddresses(toAddresses);
            mail.setSubject('Password Reset Notification');
            mail.setOrgWideEmailAddressId(owea[0].id);
            String htmlBody = et.HtmlValue;
            String plainBody = et.Body;
            htmlBody = htmlBody.replace('{!link}',resetPasswordEmailRequest.resetLink);
            plainBody = plainBody.replace('{!link}',resetPasswordEmailRequest.resetLink);
            /*String emailMsgHeader = System.Label.Password_Reset_Email_Header;
            String emailMsgBody = System.Label.HM_Password_Reset_Email;
            mail.setHtmlBody(' <b> '+ emailMsgHeader+ ' </b> '+ ' <p> ' + emailMsgBody + ' <p> ' + '<a href="'+resetPasswordEmailRequest.resetLink+'">Reset Password</a>');      //<a href=<link>"/>
            */
            mail.setHtmlBody(htmlBody);
            mail.setPlainTextBody(plainBody);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

            SendPasswordResponse res = generateResponse(null, null, true);
            return res;
         }
    
    }
      catch(Exception e){
         SendPasswordResponse res = generateResponse(e.getmessage(), '102', false);
         return res;
      }
      
    return null;
   }
   
    global static SendPasswordResponse generateResponse(String msg, String code, Boolean success){
        SendPasswordResponse res = new SendPasswordResponse();
        res.success = success;
        if(msg != null){
            HMAPIError error = new HMAPIError();
            error.message = msg;
            error.errorCode = code;
            res.error = error;
        }
        return res;
    }
    

}

/* 
JSon

{
"contact":{
"email" : "shirish.goel@gmail.com",
"userId":"asdf",
"url":"www.google.com"
}
}
*/