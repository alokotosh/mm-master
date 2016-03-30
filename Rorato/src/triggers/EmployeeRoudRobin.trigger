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

* File: EmployeeRoudRobin.cls<br/>

* Project: Developer Project <br/>

* Date: Creation Date (e.g.: January 10, 2016)<br/>

* Created By: Andrew Lokotosh <br/>

* *************************************************************************<br/>

* Description: This trigger determine  with User ,in Queue Group, Employee will be assignment <br/>

* *************************************************************************<br/>

* History: Used for any changes added to the class after first release.<br/>

* Date(same format as above) - Developer Name - what method was modified, what are the changes<br/>

*/


trigger EmployeeRoudRobin on Employee__c (before insert, before update) {


	public String groupType = 'Queue';
	public String groupNameIT = 'ITQueue';
	public String groupNameHR = 'HRQueue';  
	public String groupNameGD = 'GDQueue';
	public String groupNameManagment = 'ManagmentQueue';
    public  GetUserId useId = new GetUserId();

	for (Employee__c e : Trigger.new) 
	{  
        /** Checking  Department__c field and determine OwnerId field */
        if ( e.Department__c == 'IT' )
        {
        		e.OwnerId = useId.getUserId(groupType, groupNameIT);
           		System.debug('Employee Name: ' +e.Name);
        }
          else if (e.Department__c == 'HR') {
        	    e.OwnerId = useId.getUserId(groupType, groupNameHR);
			     System.debug('Employee Name: ' +e.Name);		
        }
        else if(e.Department__c == 'Graphic Design')
        {	
        	   e.OwnerId = useId.getUserId(groupType, groupNameGD);
        	   System.debug('Employee Name: ' +e.Name);
        }
        else  if (e.Department__c == 'Managment'){
        	   e.OwnerId = useId.getUserId(groupType, groupNameManagment);
        	   System.debug('Employee Name: ' +e.Name);
        }
    }
}