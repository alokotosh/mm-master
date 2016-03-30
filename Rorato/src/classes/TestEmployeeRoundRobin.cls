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

* File: TestEmployeeRoundRobin.cls<br/>

* Project: Developer Project <br/>

* Date: Creation Date (e.g.: January 10, 2016)<br/>

* Created By: Andrew Lokotosh <br/>

* *************************************************************************<br/>

* Description: This test class checking properly inserting Employee with diferent field Department__c parrams <br/>

* *************************************************************************<br/>

* History: Used for any changes added to the class after first release.<br/>

* Date(same format as above) - Developer Name - what method was modified, what are the changes<br/>

*/

@isTest
public class TestEmployeeRoundRobin {
       
      /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description  method checking the properly inserting Employee with field Department__c parrams
    *
    **/
    @isTest static void addNewEmployeeITQueue()
    {
        Employee__c e = new Employee__c(Name='Jordan',
            						Email__c='joedan@example.com',
            						Description__c='Test',
            						Department__c='IT');
        insert e;
    }
      /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description method checking the properly inserting Employee with field Department__c parrams
    *
    **/
     @isTest static void addNewEmployeeHRQueue()
    {
        Employee__c e = new Employee__c(Name='Jordan',
            						Email__c='joedan@example.com',
            						Description__c='Test',
            						Department__c='HR');
        insert e;
    }
      /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description method checking the properly inserting Employee with field Department__c parrams
    *
    **/
     @isTest static void addNewEmployeeGDQueue()
    {
        Employee__c e = new Employee__c(Name='Jordan',
            						Email__c='joedan@example.com',
            						Description__c='Test',
            						Department__c='Graphic Design');
        insert e;
    }
      /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description  method checking the properly inserting Employee with field Department__c parrams
    *
    **/
     @isTest static void addNewEmployeeManagmentQueue()
    {
        Employee__c e = new Employee__c(Name='Jordan',
            						Email__c='joedan@example.com',
            						Description__c='Test',
            						Department__c='Managment');
        insert e;
    }
      /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: January 15, 2016)
    *
    * @description  method checking the properly inserting Employee with field Department__c without parrams
    *
    **/
     @isTest static void addNewEmployeeNonQueue()
    {
        Employee__c e = new Employee__c(Name='Jordan',
            						Email__c='joedan@example.com',
            						Description__c='Test',
            						Department__c=' ');
        insert e;
    }


}