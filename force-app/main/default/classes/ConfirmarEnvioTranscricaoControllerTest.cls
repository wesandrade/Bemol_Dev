@isTest
private class ConfirmarEnvioTranscricaoControllerTest {
    @testSetup static void setup(){
        CaseUtilTest.setup();
    }
    
    @isTest static void testHappyWay(){
        Id caseId = [SELECT Id FROM Case LIMIT 1].Id;
        PageReference page = new PageReference('/apex/pageConfirmarEnvioTranscricao');
        Test.setCurrentPage(page);
        ApexPages.currentPage().getParameters().put('id', caseId);
        
        ConfirmarEnvioTranscricaoController controller = new ConfirmarEnvioTranscricaoController();
        controller.checkCase();
        ConfirmarEnvioTranscricaoController.Result result = ConfirmarEnvioTranscricaoController.enviarConversa(false, caseId);
        
        System.assertEquals(controller.caseId, caseId, 'Id do caso não retorno o valor esperado!');
        System.assertEquals(controller.page, controller.INVALID_ID, 'Page não retorno o valor esperado!');
        System.assertEquals(result.status, 'success', 'Status não retorno o valor esperado!');
        System.assertEquals(result.message, null, 'Message não retorno o valor esperado!');
    }
    
    @isTest static void testError(){
        Id caseId = [SELECT Id FROM Case LIMIT 1].Id;
        PageReference page = new PageReference('/apex/pageConfirmarEnvioTranscricao');
        Test.setCurrentPage(page);
        ApexPages.currentPage().getParameters().put('id', '');
        
        ConfirmarEnvioTranscricaoController controller = new ConfirmarEnvioTranscricaoController();
        controller.checkCase();
        ConfirmarEnvioTranscricaoController.Result result = ConfirmarEnvioTranscricaoController.enviarConversa(true, caseId);
        
		System.assertEquals(controller.caseId, null, 'Id do caso não retorno o valor esperado!'); 
        System.assertEquals(controller.page, controller.INVALID_ID, 'Page não retorno o valor esperado!');
        System.assertEquals(result.status, 'error', 'Status não retorno o valor esperado!');
    }
}