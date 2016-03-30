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

* Description: This Test class check properly sending email to Employee owner. <br/>

* *************************************************************************<br/>

* History: Used for any changes added to the class after first release.<br/>

* Date(same format as above) - Developer Name - what method was modified, what are the changes<br/>

*/


@IsTest
public class TestEmplSkillEmail {
    
    
     /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description the method create new User with System Administrator profile and then create new Employee,Project 
    *              and Employee Skills. Check properly insert.
    **/
     @isTest public  static void addNewEmployeeSkills()
    {
        
         
         Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];  
     	   User u = new User(Alias = 'newTes', 
                           Email='newuser@testorg.com',
       					           EmailEncodingKey='UTF-8', 
                           LastName='Testing', 
                           LanguageLocaleKey='en_US',
        				           LocaleSidKey='en_US', 
                           ProfileId = p.Id,
        				           TimeZoneSidKey='America/Los_Angeles', 
                           UserName='kava@esp.com');
        insert u;
        System.runAs(u) {
             Employee__c e = new Employee__c(Name='Jor',
            						Email__c='joe@example.com',
            						Description__c='Test',
            						Department__c='Iddfdfd');
              insert e;
              List<Employee__c> temp = [Select id,Name,OwnerId
                                        From Employee__c
                                        Where id=:e.id]; 
              System.debug('*****+'+temp.get(0).OwnerId);
              Project__c proj = new Project__c (Name='TestProj');
              insert proj;
              Employee_Skills__c es = new Employee_Skills__c(Name='Test Skill',
                                                             Employee__c=e.id,
                                                             Project__c=proj.Id,
                                                             Employee_Email__c='test@test.com',
                  										                       Grade__c=4);
                  System.debug('******'+e.Ownerid);
              	  insert es;
                                                       
                                                       
            						
    }		
    }

}