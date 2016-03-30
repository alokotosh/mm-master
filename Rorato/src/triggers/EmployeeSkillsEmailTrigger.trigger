/*
    Copyright (c) osf-global.com
    All rights reserved.
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:
    1. Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
    3. The name of the author may not be used to endorse or promote products
       derived from this software without specific prior written permission.
    
    THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
    IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
    OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
    IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, 
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
    NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
    THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
/**

* File: EmployeeSkillsEmailTrigger.cls<br/>

* Project: Developer Project <br/>

* Date: Creation Date (e.g.: January 10, 2016)<br/>

* Created By: Andrew Lokotosh <br/>

* *************************************************************************<br/>

* Description: This after insert new Employee_Skills__c trigger sed email to Employee owner<br/>

* *************************************************************************<br/>

* History: Used for any changes added to the class after first release.<br/>

* Date(same format as above) - Developer Name - what method was modified, what are the changes<br/>

*/


trigger EmployeeSkillsEmailTrigger on Employee_Skills__c (after insert, after update) {


    Employee_Skills__c rdv= trigger.new[0];   
    ID userid = rdv.CreatedById; 
    User activeUser = [SELECT Name,Email FROM User WHERE Id = :userid limit 1];
    String userName = activeUser.Name;
    String userEmail = activeUser.Email;
    String employeeskills = rdv.Name;
    
    System.debug(userEmail);
    EmailTemplate emailTemplate = [SELECT Id,Name,HtmlValue, Subject, Body FROM EmailTemplate WHERE Name = 'NewSkillWasCreated']; //Email Template's ID
    String htmlBody = emailTemplate.HtmlValue;
   // htmlBody = htmlBody.replace('{!Employee__c.CreatedBy}', 'userName ');
   // htmlBody = htmlBody.replace('{!Name}', employeeskills );
    String plainBody = emailTemplate.Body;
    plainBody = plainBody.replace('{!CreatedBy}', userName );
    plainBody = plainBody.replace('{!Name}', employeeskills );

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setSenderDisplayName('Salesforce Support'); //Sender's Display name
    mail.setReplyTo('support@salesforce.com'); //Sender's Email ID
    mail.setUseSignature(false);
    mail.setBccSender(false);
    mail.setSaveAsActivity(false);
    mail.setSubject(emailTemplate.Subject);
    mail.setHtmlBody(htmlBody);
    mail.setPlainTextBody(plainBody);
    List<String> sendTo = new List<String>();
    sendTo.add(userEmail);
    mail.setToAddresses(sendTo);       
    Messaging.sendEmail(new Messaging.SingleEmailmessage[] {mail});  
  }