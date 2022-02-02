@isTest
private class AccountUtilTest {
    @testSetup static void setup(){
        List<Account> accList = new List<Account>();
        for(integer i=0; i<3;i++){
            Date nasc = Date.newInstance(1990+i,i,10+i);
            Account acc = new Account(Name='Teste '+i,Phone='83970094793',Email__c='test'+i+'@bemol.com.br',DataNascimento__c=nasc,StatusConta__c='online',Type='Cliente Pessoa física',Logradouro__c='Parque',CEP__c='58091-250',Bairro__c='Alto do Mateus',Cidade__c='João Pessoa');
            accList.add(acc);
        }
        
        Date nasc5 = Date.newInstance(2001,6,2);
        Account accCNPJS = new Account(Name='Teste com cnpj',Phone='83970094793',Email__c='test.cnpj@bemol.com.br',DataNascimento__c=nasc5,CPFCNPJ__c='60096161000152',StatusConta__c='online',Type='Cliente Pessoa Jurídica',Logradouro__c='Parque',CEP__c='68509-070',Bairro__c='Nova Marabá',Cidade__c='Marabá');
        accList.add(accCNPJS);
        insert accList;
    }
    
    @isTest static void validateMaskTest(){
        List<Account> acc = [select Email__c,DataNascimento__c,Phone,CPFCNPJ__c,CEP__c,InscricaoMunicipal__c,InscricaoEstadual__c,Imposto__c from Account];
        AccountUtil.validateMask(acc);
    }
    
    @isTest static void validadeMaskErrorTest(){
        try{
            List<Account> accList = new List<Account>();
            Date nasc = Date.newInstance(1998,2,21);
            
            Account accCpf = new Account(Name='Teste erro cpf',Phone='83970094793',Email__c='test.cpf.erro@bemol.com.br',DataNascimento__c=nasc,CPFCNPJ__c='11021095546',StatusConta__c='online',Type='Cliente Pessoa física',Logradouro__c='Parque',CEP__c='57073575',Bairro__c='Cidade Universitária',Cidade__c='Maceió');
            accList.add(accCpf);
            
            Date nasc2 = Date.newInstance(2001,6,2);
            Account accPhone = new Account(Name='Teste erro telefone',Phone='728330947',Email__c='test.telefone.erro@bemol.com.br',DataNascimento__c=nasc2,CPFCNPJ__c='80625938003',StatusConta__c='online',Type='Cliente Pessoa física',Logradouro__c='Parque',CEP__c='57073575',Bairro__c='Cidade Universitária',Cidade__c='Maceió');
            accList.add(accPhone);
            
            Date nasc3 = Date.newInstance(2001,6,2);
            Account accCNPJ = new Account(Name='Teste erro cnpj',Phone='7283370094793',Email__c='test.cnpj.erro@bemol.com.br',DataNascimento__c=nasc3,CPFCNPJ__c='99766770001111',StatusConta__c='online',Type='Cliente Pessoa Jurídica',Logradouro__c='Parque',CEP__c='57073575',Bairro__c='Cidade Universitária',Cidade__c='Maceió');
            accList.add(accCNPJ);
            
            Date nasc4 = Date.newInstance(2001,6,2);
            Account accCEP = new Account(Name='Teste erro cep',Phone='7283370094793',Email__c='test.cep.erro@bemol.com.br',DataNascimento__c=nasc4,CPFCNPJ__c='74310283004',StatusConta__c='online',Type='Cliente Pessoa física',Logradouro__c='Parque',CEP__c='073575',Bairro__c='Cidade Universitária',Cidade__c='Maceió');
            accList.add(accCEP);
            
            Date nasc5 = Date.newInstance(2001,6,2);
            Account accInscM = new Account(Name='Teste erro cep',Phone='7283370094793',Email__c='test.cep.erro@bemol.com.br',DataNascimento__c=nasc4,CPFCNPJ__c='74310283004',StatusConta__c='online',Type='Cliente Pessoa física',InscricaoMunicipal__c ='teste',Logradouro__c='Parque',CEP__c='073575',Bairro__c='Cidade Universitária',Cidade__c='Maceió');
            accList.add(accInscM);
            
            Date nasc6 = Date.newInstance(2001,6,2);
            Account accInscE = new Account(Name='Teste erro cep',Phone='7283370094793',Email__c='test.cep.erro@bemol.com.br',DataNascimento__c=nasc4,CPFCNPJ__c='74310283004',StatusConta__c='online',Type='Cliente Pessoa física',InscricaoEstadual__c ='teste',Logradouro__c='Parque',CEP__c='073575',Bairro__c='Cidade Universitária',Cidade__c='Maceió');
            accList.add(accInscE);
            
            Date nasc7 = Date.newInstance(2001,6,2);
            Account accImposto = new Account(Name='Teste erro cep',Phone='7283370094793',Email__c='test.cep.erro@bemol.com.br',DataNascimento__c=nasc4,CPFCNPJ__c='74310283004',StatusConta__c='online',Type='Cliente Pessoa física',Imposto__c ='teste',Logradouro__c='Parque',CEP__c='073575',Bairro__c='Cidade Universitária',Cidade__c='Maceió');
            accList.add(accImposto);
            
            Test.startTest();
            	insert accList;
            Test.stopTest();
        }catch(Exception error){
            System.debug('Error >>> ' + error);
        }
    }
    
    @isTest static void insertTest(){
        Date nasc = Date.newInstance(1990,1,10);
        Test.startTest();
        	Account acct = new Account(Name='Teste Trigger',Phone='83970094793',Email__c='test.bemol@test.com.br',DataNascimento__c=nasc,CPFCNPJ__c='01291261010',StatusConta__c='online',Type='Cliente Pessoa física',InscricaoMunicipal__c='876545678',InscricaoEstadual__c='0989877',Imposto__c='02',Logradouro__c='Parque',CEP__c='60311010',Bairro__c='Alvaro Weyne',Cidade__c='Fortaleza');
            insert acct;
        	Account acct2 = new Account(Name='Test',Phone='85988218222',Email__c='test.test@test.com.br',DataNascimento__c=nasc,CPFCNPJ__c='74293792066',StatusConta__c='ativo',Type='Cliente Pessoa física',Logradouro__c='Parque',CEP__c='60311010',Bairro__c='Aldeota',Cidade__c='Fortaleza');
            insert acct2;
        Test.stopTest();
    }
    
    @isTest static void updateTest(){
        Account acct = [select Email__c,DataNascimento__c,Phone,CPFCNPJ__c,CEP__c from Account LIMIT 1];
        Test.startTest();
        	acct.Email__c = 'test.updated@test.com.br';
        	update acct;
        Test.stopTest();
    }
    
    @isTest static void deleteTest(){
        Account acct = [select DataNascimento__c,Phone,CPFCNPJ__c,CEP__c from Account LIMIT 1];
        Test.startTest();
        	delete acct;
        Test.stopTest();
    }
}