@isTest
public class SendAttachmentFilesByMail_Test {
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
            ContactId = ctt.Id,
            Sistema_Operacional__c = 'Android',
            Description = 'Test'
        );
        insert css;
       EmailSustentacao__mdt theRecord = new EmailSustentacao__mdt(
      		Email__c = 'test@test.com.br',
     		Active__c = true
       );
        
    }
     @isTest static void SendAttachmentFilesByMail_sendMail(){
     
     	List<Case> cases = [SELECT CaseNumber,Subject,Description,Categoria__c,Subcategoria__c,Sistema_Operacional__c,CreatedDate,CPFCNPJ__c from case];
        SendAttachmentFilesByMail.sendMail(cases);
     }
}