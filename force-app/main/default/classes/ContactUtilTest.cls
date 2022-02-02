@isTest
private class ContactUtilTest {
	@testSetup static void setup(){
        List<Contact> cctList = new List<Contact>();
        Date nasc5 = Date.newInstance(2001,6,2);
        Account acctCNPJS = new Account(Name='Teste com cnpj',Phone='83970094793',Email__c='test.cnpj@bemol.com.br',DataNascimento__c=nasc5,CPFCNPJ__c='60096161000152',StatusConta__c='online',Type='Cliente Pessoa Jurídica',Logradouro__c='Parque',CEP__c='68509-070',Bairro__c='Nova Marabá',Cidade__c='Marabá');
        insert acctCNPJS;
        for(integer i=0; i<3;i++){
            Contact cct = new Contact(LastName='Teste '+i,AccountId=acctCNPJS.Id);
            cctList.add(cct);
        }
        insert cctList;
    }
    @isTest static void validadeMaskErrorTest(){
        try{
            Contact ctt = new Contact(FirstName='test',LastName='Trigger',Phone='9999999');
            Test.startTest();
            	insert ctt;
            Test.stopTest();
        }catch(Exception error){
            System.debug('Error >>> ' + error);
        }
    }
    @isTest static void insertTest(){
        Test.startTest();
        	Contact ctt = new Contact(FirstName='test',LastName='Trigger',Phone='83970094793');
            insert ctt;
        Test.stopTest();
    }
    
    @isTest static void updateTest(){
        Contact ctt = [select LastName,Phone from Contact LIMIT 1];
        Test.startTest();
        	ctt.Phone = '83970094793';
        	update ctt;
        Test.stopTest();
    }
    
    @isTest static void deleteTest(){
        Contact cct = [select LastName from Contact LIMIT 1];
        Test.startTest();
        	delete cct;
        Test.stopTest();
    }
}