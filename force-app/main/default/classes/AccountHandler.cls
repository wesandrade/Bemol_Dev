/**
 * @File Name          : 
 * @Description        :
 * @Author             : bianca.andrade@moldsoft.com.br
 * @Group              :
 * @Last Modified By   : bianca.andrade@moldsoft.com.br
 * @Last Modified On   : 07/01/2021
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    07/01/2021  bianca.andrade@moldsoft.com.br         Initial Version
**/
public with sharing class AccountHandler implements TriggerHandlerInterface {

    private static final AccountHandler instance = new AccountHandler ();
    public static AccountHandler getInstance () {
        return instance;
    }

    public void beforeUpdate () {
        AccountUtil.validateMask((List<Account>) Trigger.new);
    }

    public void beforeInsert () {
        AccountUtil.validateMask((List<Account>) Trigger.new);
    }

    public void beforeDelete () { 
        String valor  = 'beforeDelete';
        System.debug(valor);
    }

    public void afterUpdate () { 
        String valor  = 'beforeDelete';
        System.debug(valor);
    }

    public void afterInsert () { 
        String valor  = 'afterInsert';
        AccountUtil.createRelatedContact((List<Account>) Trigger.new);
        System.debug(valor);
    }

    public void afterDelete () { 
        String valor  = 'afterDelete';
        System.debug(valor);
    }
}