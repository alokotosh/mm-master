@isTest
private class AccountControllerExtension_Test {

	@isTest static void cancel_test() {

		University__c university = new University__c(Name = 'Lunds');
		insert university;
		System.assertNotEquals(null, university.Id);

		Account account = new Account();
		account.Name = 'Test account';
		account.Project_Status__c = 'Active';
		account.Project_Phase__c = 'Contact';
		account.University__c = university.Id;
		insert account;
		System.assertNotEquals(null, account.Id);

		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(account);
		AccountControllerExtension ctrl = new AccountControllerExtension(stdCtrl);


	}


	@isTest static void saveStatus_test() {

		University__c university = new University__c(Name = 'Lunds');
		insert university;
		System.assertNotEquals(null, university.Id);

		Account account = new Account();
		account.Name = 'Test account';
		account.Project_Status__c = 'Active';
		account.Project_Phase__c = 'Contact';
		account.University__c = university.Id;
		insert account;


		System.assertNotEquals(null, account.Id);
		System.assertEquals('Active', account.Project_Status__c);
		System.assertEquals('Contact', account.Project_Phase__c);



//checking comercial account
		Account accountCom = new Account();
		accountCom.Name = 'Test account comercial';
		accountCom.Project_Status__c = 'Active';
		accountCom.Project_Phase__c = 'Commercial';
		accountCom.University__c = university.Id;
		insert accountCom;


		System.assertNotEquals(null, accountCom.Id);
		System.assertEquals('Active', accountCom.Project_Status__c);
		System.assertEquals('Commercial', accountCom.Project_Phase__c);


  //check comercial with company
		//Company__c projCompany = new Company__c();
		//projCompany.Name = accountCom.Name;
		//projCompany.Project__c = accountCom.Id;
		//insert projCompany;

		//Account accountComWithCompany = new Account();
		//accountComWithCompany.Name = 'Test account comerc com';
		//accountComWithCompany.Project_Status__c = 'Active';
		//accountComWithCompany.Project_Phase__c = 'Commercial';
		//accountComWithCompany.Company__c = projCompany.id;
		//accountComWithCompany.University__c = university.Id;
		//insert accountComWithCompany;

		//System.assertNotEquals(null, accountComWithCompany.Id);
		//System.assertEquals('Active', accountComWithCompany.Project_Status__c);
		//System.assertEquals('Commercial', accountComWithCompany.Project_Phase__c);
		//System.assertNotEquals(null, accountComWithCompany.Company__c);
		//System.assertNotEquals(null, accountComWithCompany.University__c);


		ApexPages.StandardController stdCtrl = new ApexPages.StandardController(account);
		AccountControllerExtension ctrl = new AccountControllerExtension(stdCtrl);
		ctrl.project.Project_Status__c = 'Pending';
		ctrl.project.Project_Phase__c = 'Commercial';
		ctrl.phase = ctrl.project.Project_Phase__c;
		//update account;
		ctrl.saveStatus();


		Account acc1 = [Select Id, Name, Project_Status__c, Project_Phase__c From Account Where Name = 'Test account'];
		System.assertNotEquals(null, acc1.Id);
		System.assertEquals('Pending', acc1.Project_Status__c);
		System.assertEquals('Commercial', acc1.Project_Phase__c);
		System.assertNotEquals(null, ctrl.project.Company__c);

	}

}