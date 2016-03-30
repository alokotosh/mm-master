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

* File: GetUserId.cls<br/>

* Project: Developer Project <br/>

* Date: Creation Date (e.g.: January 10, 2016)<br/>

* Created By: Andrew Lokotosh <br/>

* *************************************************************************<br/>

* Description: This class return User Id with less count of assigment Employee. <br/>

* *************************************************************************<br/>

* History: Used for any changes added to the class after first release.<br/>

* Date(same format as above) - Developer Name - what method was modified, what are the changes<br/>

*/





public with sharing class GetUserId {

		public Map<Id,Integer> idToSize = new Map<Id,Integer>();  //map: key-userId, values- size 
		public List<Integer> employoeeSize = new List<Integer>(); //list with number of size List employeeName
		public List<String> userName = new List<String>();
		public Id userForReturn;
		public User user;
		public List<String> employeeName  = new List<String>();
		public Map<Id, List<String>> userIdToEmployeeName = new Map<Id, List<String>>();



		/**
* @author Andrew Lokotosh
*
* @date creation date (e.g.: January 10, 2016)
*
* @description This method will return User Id with less count of assigment Employee.
*
* @param groupType - String Name of group type.
*
* @param groupName - String Name of group name.
*
* @return id.
*
**/

	public Id getUserId (String groupType, String groupName)
	{
		Group queueGroups = [Select Id,Name 
							From Group 
							Where Type =:groupType 
							AND Name =:groupName 
							LIMIT 1];

		Set<Id> userOrGroupIds = new Set<Id>();
				for (GroupMember member : [Select UserOrGroupId 
										   From GroupMember 
										   Where GroupId =:queueGroups.Id]) {
		   			 userOrGroupIds.add(member.UserOrGroupId);
						}					
				for(Id userId: userOrGroupIds)
				{
					 user = [Select id,Name From User Where id=:userId LIMIT 1];
					userName.add(user.Name);
				}
					for(Id userId: userOrGroupIds)
					{	
							for (Employee__c e: [Select id, Name FROM Employee__c Where OwnerId =:userId])
    							{
    							employeeName.add(e.Name);
    							}
    							employoeeSize.add(employeeName.size());
    					idToSize.put(userId, employeeName.size());
    					userIdToEmployeeName.put(userId, employeeName);
    					 user = [Select id,Name From User Where id=:userId LIMIT 1];
    					System.debug('User:'+'|'+user.Name+'|'+' '+'Count: '+employeeName.size()+' Employees: '+ employeeName);
    					employeeName.clear();
					}
					employoeeSize.sort();
				  for(Id uId: userOrGroupIds)
				  {
				  	if(idToSize.get(uId)==employoeeSize.get(0))
						{
							 userForReturn= uId;
							 user = [Select id,Name From User Where id=:uId LIMIT 1];
							 System.debug('Next Owner id: '+uId+' Name : '+ user.Name);

							break;
						}
				  }
				  return userForReturn;
	}
}