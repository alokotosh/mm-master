/*
    Copyright (c)
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

* File: TestAssigningContactTrigger <br/>

* Project: Developer Project <br/>

* Date: Creation Date (e.g.: Match 25, 2016)<br/>

* Created By: Andrew Lokotosh <br/> 

* *************************************************************************<br/>

* Description: This test class check correct work on AssigningConactTrigger<br/>

* *************************************************************************<br/>

* History: Used for any changes added to the class after first release.<br/>

* Date(same format as above) - Developer Name - what method was modified, what are the changes<br/>

*/
@isTest
private class TestAssigningContactTrigger {
        /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: Match 25, 2016)
    *
    * @description the testmethod crate and insert new instance  of Computer_Inventory__c
    *
    *
    **/
    private static testmethod void createComputerInventory()
    {
           Computer_Inventory__c ci = new Computer_Inventory__c(Name='HP',
						  										Inventory_Number__c=34653245,
                                                                Description__c='Test',
                                                                Value__c =200,
                                                                Customer__c =createAccount().id
                                                               );
   insert ci;
System.assertEquals(ci.Contact_Person__c,createAccount().Inventory_Manager__c);
    }
       /**
    * @author Andrew Lokotosh
    *
    * @date creation date (e.g.: Match 25, 2016)
    *
    * @description the method used for create new Contact and Account instance.
    *
    * @return Account a
    *
    **/
    private static Account createAccount()
    {
        Contact c = new Contact(LastName='Test');
        Account a = new Account(Name ='TestA',
                                Inventory_Manager__c=c.id);
        insert c;
        insert a;
        return a;

    }
}
