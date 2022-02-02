@isTest
public class EmailLiveChatControllerTest {
    @testSetup static void setup(){
        CaseUtilTest.setup();
    }
    
    @isTest static void testHappyWay(){
        Case caso = [SELECT Id, ContactId FROM Case LIMIT 1];
        PageReference page = new PageReference('/apex/pageEmailLiveChat');
        Test.setCurrentPage(page);
        ApexPages.currentPage().getParameters().put('case', caso.Id);
        ApexPages.currentPage().getParameters().put('contact', caso.ContactId);
        
        EmailLiveChatController controller = new EmailLiveChatController();
        String newConversa = EmailLiveChatController.tranlateConversation(controller.conversa);
        
        System.assertEquals('Nenhuma conversa encontrada.', controller.conversa);
        System.assertEquals(newConversa, controller.conversa);
    }
}