@isTest
public class CaseUtilTest {
    @testSetup public static void setup(){
        Date nasc = Date.newInstance(1990,1,10);
       	Account acct = new Account(
            Name = 'Teste Trigger',
            Phone = '85999999999',
            Email__c = 'test.bemol@test.com.br',
            DataNascimento__c = nasc,
            CPFCNPJ__c = '85498782004',
            StatusConta__c = 'online',
            Type = 'Cliente Pessoa física',
            Logradouro__c = 'Parque', 
            CEP__c = '60311010', 
            //Estado__c = 'CE',
            Bairro__c = 'Alvaro Weyne',
            Cidade__c = 'Fortaleza'
        );
        insert acct;
        
        Contact ctt = new Contact(
            FirstName = 'case',
            LastName = 'Trigger',
            Email = 'test.bemol@test.com.br',
            Phone = '85999999999',
            AccountId = acct.Id
        );
        insert ctt;
        
        Entitlement ent = new Entitlement(
            Name = 'Direito padrão',
            AccountId = acct.Id
        );
        insert ent;
        
        Case css = new Case(
            Priority = 'High',
            Reason = 'Informação',
            // Categoria__c = 'Canais de atendimento',
            // Subcategoria__c = 'Prazos',
            Origin = 'WhatsApp',
            Status = 'Aguardando resposta',
            AccountId = acct.Id,
            ContactId = ctt.Id
        );
        insert css;
    }
    
	@isTest static void insertTest(){
        Date nasc = Date.newInstance(1990,1,10);
        Test.startTest();
        	Account acct = new Account(
                Name='Teste Trigger',
                Phone='85999999999',
                Email__c='test.bemol@test.com.br',
                DataNascimento__c=nasc,
                CPFCNPJ__c='01291261010',
                StatusConta__c='online',
                Type='Cliente Pessoa física',
                Logradouro__c='Parque',
                CEP__c='60311010',
                //Estado__c='CE',
                Bairro__c='Alvaro Weyne',
                Cidade__c='Fortaleza'
            );
            insert acct;
        
        	Contact ctt = new Contact(
                FirstName='test',
                LastName='Trigger',
                Phone='85999999999',
                AccountId=acct.Id
            );
            insert ctt;
        
            Entitlement ent = new Entitlement(
                Name='Direito padrão',
                AccountId=acct.Id
            );
            insert ent;
        
        	Case css = new Case(
                Priority='High',
                Reason='Informação',
                // Categoria__c='Canais de atendimento',
                // Subcategoria__c='Prazos',
                Origin='WhatsApp',
                Status='Aguardando resposta',
                AccountId=acct.Id,
                ContactId=ctt.Id
            );
            insert css;
        Test.stopTest();
    }
    
    @isTest static void updateTest(){
        Case cas = [SELECT Priority, Status FROM Case LIMIT 1];
        Test.startTest();
        	cas.Priority = 'Medium';
        	cas.Status ='Pendente CS';
        	update cas;
        Test.stopTest();
    }
    
    @isTest static void deleteTest(){
        Case caso = [SELECT ID FROM Case LIMIT 1];
        Test.startTest();
        	delete caso;
        Test.stopTest();
    }
}